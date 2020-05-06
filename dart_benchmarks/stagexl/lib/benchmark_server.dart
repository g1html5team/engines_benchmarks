import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf/src/message.dart';
import 'package:shelf_packages_handler/shelf_packages_handler.dart';
import 'package:shelf_proxy/shelf_proxy.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/src/channel.dart';

import 'benchmarks/keys.dart';

final Logger _logger = new Logger('benchmark.server');
const int _port = 12345;
const String _ip = '10.150.136.26';
const String _localhost = 'localhost';
const int _pubServePort = 10001;

Future main() => startServer(_localhost);

Future startServer(String ip, {bool verbose: false}) {
  if (verbose) {
    Logger.root.level = Level.ALL;
  }

  Logger.root.onRecord.listen(print);
  return new _Server().start(ip);
}

Process pubServe;
_pubServe() async {
  Directory.current = Platform.script.resolve('..').toFilePath();
//
  pubServe = await Process.start('webdev' + (Platform.isWindows ? '.bat' : ''),
      ['serve', 'web:$_pubServePort']);

//  pubServe = await  Process.start('webdev.bat',['serve', '$_localhost:$_pubServePort'] );

  _logger.info('webdev serve started');

  await Future.wait(
      [stdout.addStream(pubServe.stdout), stderr.addStream(pubServe.stderr)]);

  await pubServe.exitCode;

  _logger.info('Pub serve stopped');
}

class _Server {
  String _ip;

  Map<String, WebSocketChannel> _sockets = {};
  Map<String, String> _datas = {};

  Map<String, _BenchmarkRun> _runs = {};
  HttpServer _server;

  _Server();

  String _getRequestID(Request request) =>
      request.requestedUri.queryParameters['id'];

  Map<String, String> benchmarksConnections = {};

  Future start(String ip) async {
    _pubServe();
    _ip = ip;
    Router globalRouter = Router();

    globalRouter.add('POST','/api/save', _handleSave);
    globalRouter.add('POST','/api/config', _handleConfig);
    globalRouter.add( 'POST','/api/next', _handleNextRun);
    globalRouter.add(
      'GET','/',  proxyHandler('http://localhost:$_pubServePort'),
        );
    globalRouter.add('GET','/packages', packagesHandler()
        );
    globalRouter.add('GET','/',  createStaticHandler('web'));

    Router iFrameRouter = Router();
    iFrameRouter.add( 'GET','/run/packages', packagesHandler(),
      );
    iFrameRouter.add(
      'GET','/',  proxyHandler('http://localhost:$_pubServePort'),
      );
    iFrameRouter.add(

      'GET',
      '/',
        createStaticHandler('web/run/',
            serveFilesOutsidePath: true, listDirectories: true),
        );

    int i = -1;
    for (; ++i < 200;) {
      HttpServer server = await io.serve(
          _removeXFrameOptionsHandler(iFrameRouter.handler),
          InternetAddress.anyIPv4,
          15000 + i);
      server.defaultResponseHeaders.set('Access-Control-Allow-Origin', '*');
      server.defaultResponseHeaders.remove('x-frame-options', "SAMEORIGIN");
      server.defaultResponseHeaders
          .set('Content-Type', "application/javascript");
    }

    _logger.info(
        'All servers for iFrame are started : http://$ip from port 15000 to ${15000 +
            i}');

    _server = await io.serve(_removeXFrameOptionsHandler(globalRouter.handler),
        InternetAddress.anyIPv4, _port);
    _logger.info(InternetAddress.anyIPv4);

    _server.defaultResponseHeaders.set('Access-Control-Allow-Origin', "*");
    _server.defaultResponseHeaders.remove('x-frame-options', "SAMEORIGIN");
    _logger.info('Benchmark Server started on : http://$ip:$_pubServePort/main.html');

    Handler webSocketHand = webSocketHandler(_handleWebSocket);

    HttpServer serverWebSocket = await io.serve(webSocketHand, _ip, 7070);
    _logger
        .info('Serving at ws://${serverWebSocket.address.host}:${serverWebSocket
        .port}');

    await _createDatasMap();
  }

  static _removeXFrameOptionsHandler(Handler handler) {
    return (Request request) async {
      Response response = await handler(request);
      return response;
    };
  }

  Future _createDatasMap() async {
    try {
      Directory dir = new Directory('_benchmarks');
      List<FileSystemEntity> files = dir.listSync().where((FileSystemEntity f) {
        return f is File && f.path.endsWith('.json');
      }).toList();

      for (File file in files) {
        String fileName =
            file.path.split(new RegExp(r'[/\\]')).last.split('.').first;
        String data = await file.readAsString();
        _datas[fileName] = data;
      }

    } catch (e) {
      _logger.info('force close server : error from create data as map');
      pubServe.kill();
      await _server.close(force: true);
      rethrow;
    }
  }

  _handleWebSocket(WebSocketChannel webSocket) {
    _logger.info('New web socket connection');
    webSocket.stream.listen((message)
    {
      if (message.contains('link'))
      {
        _handleWebSocketLink(webSocket, message);
      }
    });
  }

  _handleWebSocketLink(WebSocketChannel webSocket, String message) {
    String id = message.split('=')[1];
    _sockets[id] = webSocket;
    _sendDataViaWebSocket(webSocket, _datas[id]);
  }

  _sendDataViaWebSocket(WebSocketChannel webSocket, String data) {
//    _logger.info('send data');
//    webSocket.sink.add('data=$data');
  }

  Future<Response> _handleSave(Request request) async {
    try {
      String id = _getRequestID(request);
      if (_runs[id].file == null) {
        File file = new File('_benchmarks/$id.json');
        if (!file.existsSync()) {
          await file.create();
        }
        _runs[id].file = file;
      }
      String data = await request.readAsString();
      _datas[id] = data;
      await _runs[id].file.writeAsString(data);
      WebSocketChannel webSocketChannel = _sockets[id];
      if (webSocketChannel != null) {
        _sendDataViaWebSocket(webSocketChannel, data);
      }
      return new Response(200);
    } catch (e) {
      _logger.info('force close server : error from saving file');
      pubServe.kill();
      await _server.close(force: true);
      return new Response(500);
    }
  }

  Future<Response> _handleConfig(Request request) async {
    String data = await request.readAsString();
    Map<String, String> jsonMsg = Map.castFrom(json.decode(data));

    _Config config = new _Config(jsonMsg);

    String id = _getRequestID(request);

    try {
      _BenchmarkRun run = new _BenchmarkRun(config, _ip);

      run.id = id;
      _runs[id] = run;
      _logger.info('Link requested from $id');
      _logger
          .info('Results viewer : http://$_ip:$_port/result_view.html?id=$id');
      Response res = new Response(200, body: json.encode(_runs[id].runs.removeAt(0)));
      return res;
    } catch (e) {
      pubServe.kill();
      await _server.close(force: true);
      return new Response(500);
    }
  }

  Future<Response> _handleNextRun(Request request) async {
    try {
      String data = await request.readAsString();
      Map req = json.decode(data);
      String id = _getRequestID(request);

      _runs[id].addResult(req);

      _handleSaveSync(_runs[id]);

      _logger.info('Next run for $id');
      if (_runs[id].runs.isEmpty) {
        return new Response(204);
      } else {
        return new Response(200, body: json.encode(_runs[id].runs.removeAt(0)));

      }
    } catch (e) {
      _logger.info('error on next run');
      pubServe.kill();
      await _server.close(force: true);
      rethrow;
    }
  }

  _handleSaveSync(_BenchmarkRun run) async {
    try {
      if (run.file == null) {
        File file = new File('_benchmarks/${run.id}.json');
        if (!file.existsSync()) {
          await file.create();
        }
        run.file = file;
      }
      String data = json.encode(run.result);
      await run.file.writeAsString(data);
      WebSocketChannel webSocketChannel = _sockets[run.id];
      if (webSocketChannel != null) {
        _sendDataViaWebSocket(webSocketChannel, data);
      }
    } catch (e) {
      _logger.info('force close server : error from save sync');
      await _server.close(force: true);
      rethrow;
    }
  }
}

class _BenchmarkRun {
  String id;
  WebSocketChannel socket;
  Map result = {};
  File file;
  _Config config;
  List<Map<String, String>> runs = [];
  String _baseIp;

  Map<String, bool> _runEngine = {};

  _BenchmarkRun(this.config, this._baseIp) {
    result[info] = _addBenchmarkInfos();
    result[benchmark] = new Map();

    if (config.runChildren) {
      print("A");
      result[benchmark]["simple add"] = new Map();
      result[benchmark]["simple add remove"] = new Map();
      result[benchmark]["add remove container"] = new Map();
    }

    if (config.runFilters) {
      result[benchmark][filters + ' ' + brightness] = new Map();
      result[benchmark][filters + ' ' + hue] = new Map();
    }

    //TODO: reimplements
//    if (config.runMasks) {
//      result[benchmark][mask + ' ' + size + ' 50*50'] = new Map();
//      result[benchmark][mask + ' ' + size + ' 250*250'] = new Map();
//      result[benchmark][mask + ' ' + size + ' 500*500'] = new Map();
//    }

    if (config.runBlendMode) {
      result[benchmark]["blend mode normal"] = new Map();
      result[benchmark]["blend mode add"] = new Map();
      result[benchmark]["blend mode multiply"] = new Map();
      result[benchmark]["blend mode overlay"] = new Map();
      result[benchmark]["blend mode screen"] = new Map();
    }

    if (config.runGpuSlot) {
      result[benchmark]["GPU overflow"] = new Map();
    }

    if (config.runAddRemoveContainer) {
      result[benchmark]["add remove container"] = new Map();
    }

    if (config.runAtlas) {
      result[benchmark]["atlas - no atlas - add child"] = new Map();
      result[benchmark]["atlas - no atlas - 1 bitmap"] = new Map();
      result[benchmark]["atlas - no atlas - 100 bitmap"] = new Map();
      result[benchmark]["atlas - 1 atlas - add child"] = new Map();
      result[benchmark]["atlas - 1 atlas - 1 bitmap"] = new Map();
      result[benchmark]["atlas - 1 atlas - 100 bitmap"] = new Map();
      result[benchmark]["atlas - 2 atlas - add child"] = new Map();
      result[benchmark]["atlas - 2 atlas - 1 bitmap"] = new Map();
      result[benchmark]["atlas - 2 atlas - 100 bitmap"] = new Map();
      result[benchmark]["atlas - 3 atlas - add child"] = new Map();
      result[benchmark]["atlas - 3 atlas - 1 bitmap"] = new Map();
      result[benchmark]["atlas - 3 atlas - 100 bitmap"] = new Map();
    }

    if (config.runFlipbook) {
      result[benchmark]["flipbooks"] = new Map();
    }

    if (config.runParticles) {
      result[benchmark]["particles - A"] = new Map();
      result[benchmark]["particles - B"] = new Map();
    }

    if (config.runRenderTexture) {
      result[benchmark]["render texture"] = new Map();
    }

    if (config.runShader) {
      result[benchmark]["shader - blur"] = new Map();
      result[benchmark]["shader - glow"] = new Map();
      result[benchmark]["shader - displacement"] = new Map();
      result[benchmark]["shader - step by step"] = new Map();
      result[benchmark]["shader - all"] = new Map();
    }

    if (config.runShape) {
      result[benchmark]["shape - rect"] = new Map();
      result[benchmark]["shape - bezier"] = new Map();
      result[benchmark]["shape - quadratic"] = new Map();
      result[benchmark]["shape - line"] = new Map();
      result[benchmark]["shape - arc"] = new Map();
    }

    if (config.runSpine) {
      result[benchmark]["spine - 10 deforms"] = new Map();
    }

    if (config.runVisibility) {
      result[benchmark]["visibility - out of scene"] = new Map();
      result[benchmark]["visibility - visibility false"] = new Map();
      result[benchmark]["visibility - alpha 0"] = new Map();
      result[benchmark]["visibility - move outside"] = new Map();
      result[benchmark]["visibility - scale 0"] = new Map();
    }

    if (config.runZindex) {
      result[benchmark]["zindex - one child"] = new Map();
      result[benchmark]["zindex - all child"] = new Map();
      result[benchmark]["zindex - all child several textures"] = new Map();
    }

    _runEngine = {
      ng1n: config.runNg1n,
      stagexl: config.runStageXl,
      pixi: config.runPixi
    };

    _buildRuns();
  }

  Map<String, String> _addBenchmarkInfos() {
    DateTime d = new DateTime.now();
    return {
      agent: config.userAgent,
      user: config.userName,
      date: '${d.day}/${d.month}/${d.year} - ${d.hour}:${d.minute}',
      duration: '',
      runDuration: config.runDuration.toString() + ' sec',
      canvasWidth: config.canvasWidth.toString(),
      canvasHeight: config.canvasHeight.toString(),
      ng1n: config.runNg1n.toString(),
      stagexl: config.runStageXl.toString(),
      pixi: config.runPixi.toString()
    };
  }

  String _key(int n) => '$n $objects';

  _buildRuns() {
    List<int> childrenData = [1000];
    List<int> labelsData = [50];
    //TODO: reimplements
//    List<int> maskData = [50, 250, 500];

    List<int> shaders = [10];

    List<String> _childrenStep = [
      "simple add",
      "simple add remove",
      "add remove container"
    ];
//
//    List<String> _filtersStep = [
//      filters + ' ' + brightness,
//      filters + ' ' + hue
//    ];

    //TODO: reimplements
//    List<String> _masksStep = [
//      mask + ' ' + size + ' 50*50',
//      mask + ' ' + size + ' 250*250',
//      mask + ' ' + size + ' 500*500'
//    ];
//
//    List<String> _blendModeStep = [
//      "blend mode normal",
//      "blend mode add",
//      "blend mode multiply",
//      "blend mode overlay",
//      "blend mode screen"
//    ];
//
//    List<String> _atlasStep = [
//      "atlas - no atlas - add child",
//      "atlas - no atlas - 1 bitmap",
//      "atlas - no atlas - 100 bitmap",
//      "atlas - 1 atlas - add child",
//      "atlas - 1 atlas - 1 bitmap",
//      "atlas - 1 atlas - 100 bitmap",
//      "atlas - 2 atlas - add child",
//      "atlas - 2 atlas - 1 bitmap",
//      "atlas - 2 atlas - 100 bitmap",
//      "atlas - 3 atlas - add child",
//      "atlas - 3 atlas - 1 bitmap",
//      "atlas - 3 atlas - 100 bitmap"
//    ];
//
//    List<String> _particlesStep = ["particles - A", "particles - B"];
//
//    List<String> _shaderStep = [
//      "shader - blur",
//      "shader - glow",
//      "shader - displacement",
//      "shader - step by step",
//      "shader - all"
//    ];
//
//    List<String> _shapeStep = [
//      "shape - rect",
//      "shape - bezier",
//      "shape - quadratic",
//      "shape - line",
//      "shape - arc"
//    ];
//
//    List<String> _visibilityStep = [
//      "visibility - out of scene",
//      "visibility - visibility false",
//      "visibility - alpha 0",
//      "visibility - move outside",
//      "visibility - scale 0"
//    ];
//
//    List<String> _zIndexStep = [
//      "zindex - one child",
//      "zindex - all child",
//      "zindex - all child several textures"
//    ];

    int basePort = 10001;

    if (config.runChildren) {
      int benchmarkID = 0;
      for (String step in _childrenStep) {
        for (int data in childrenData) {
          for (String engine in _runEngine.keys) {
            if (_runEngine[engine]) {
              benchmarkID++;
              Map<String, String> run = {
                "target": config.target,
                "id": benchmarkID.toString(),
                "baseUrl": '$_baseIp:${basePort}',
                "path": '/run/add_remove_child.html',
                "cw": config.canvasWidth.toString(),
                "ch": config.canvasHeight.toString(),
                "nbObj": data.toString(),
                "engine": engine,
                "step": step,
                "parameter": _key(data)
              };
              runs.add(run);
            }
          }
        };
      }
    }
//
//    if (config.runFilters) {
//      int benchmarkID = 1;
//      for (String step in _filtersStep) {
//        for (int data in childrenData) {
//          for (String engine in _runEngine.keys) {
//            if (_runEngine[engine]) {
//              Map<String, String> run = {
//                "target": config.target,
//                "id": benchmarkID.toString(),
//                "baseUrl": '$_baseIp:${basePort++}',
//                "path": '/run/filters.html',
//                "cw": config.canvasWidth.toString(),
//                "ch": config.canvasHeight.toString(),
//                "nbObj": data.toString(),
//                "engine": engine,
//                "step": step,
//                "parameter": _key(data)
//              };
//              runs.add(run);
//            }
//          }
//        }
//        benchmarkID++;
//      }
//    }

//    Todo: reimplements
//    if (config.runMasks) {
//      int benchmarkID = 1;
//      for (String step in _masksStep) {
//        for (int size in maskData) {
//          for (int data in childrenData) {
//            for (String engine in _runEngine.keys) {
//              if (_runEngine[engine]) {
//                Map<String, String> run = {
//                  "target": config.target,
//                  "id": benchmarkID.toString(),
//                  "baseUrl": '$_baseIp:${basePort++}',
//                  "path": '/run/masks',
//                  "cw": config.canvasWidth.toString(),
//                  "ch": config.canvasHeight.toString(),
//                  "nbObj": data.toString(),
//                  "size": size.toString(),
//                  "engine": engine,
//                  "step": step,
//                  "parameter": _key(data)
//                };
//                runs.add(run);
//              }
//            }
//          }
//        }
//        benchmarkID++;
//      }
//    }
//
//    if (config.runBlendMode) {
//      int benchmarkID = 1;
//      for (String step in _blendModeStep) {
//        for (int data in childrenData) {
//          for (String engine in _runEngine.keys) {
//            if (_runEngine[engine]) {
//              Map<String, String> run = {
//                "target": config.target,
//                "id": benchmarkID.toString(),
//                "baseUrl": '$_baseIp:${basePort++}',
//                "path": '/run/blend_mode/blend_mode.html',
//                "cw": config.canvasWidth.toString(),
//                "ch": config.canvasHeight.toString(),
//                "nbObj": data.toString(),
//                "engine": engine,
//                "step": step,
//                "parameter": _key(data)
//              };
//              runs.add(run);
//            }
//          }
//        }
//        benchmarkID++;
//      }
//    }
//
//    if (config.runGpuSlot) {
//      for (String engine in _runEngine.keys) {
//        if (_runEngine[engine]) {
//          Map<String, String> run = {
//            "target": config.target,
//            "id": "1",
//            "baseUrl": '$_baseIp:${basePort++}',
//            "path": '/run/gpu_slots/gpu_slots.html',
//            "cw": config.canvasWidth.toString(),
//            "ch": config.canvasHeight.toString(),
//            "nbObj": "0",
//            "engine": engine,
//            "step": "GPU overflow",
//            "parameter": _key(0)
//          };
//          runs.add(run);
//        }
//      }
//    }
//
//    if (config.runAddRemoveContainer) {
//      for (int data in childrenData) {
//        for (String engine in _runEngine.keys) {
//          if (_runEngine[engine]) {
//            Map<String, String> run = {
//              "target": config.target,
//              "id": "0",
//              "baseUrl": '$_baseIp:${basePort++}',
//              "path": '/run/add_remove.html',
//              "cw": config.canvasWidth.toString(),
//              "ch": config.canvasHeight.toString(),
//              "nbObj": data.toString(),
//              "engine": engine,
//              "step": "add remove container",
//              "parameter": _key(data)
//            };
//            runs.add(run);
//          }
//        }
//      }
//    }
//
//    if (config.runAtlas) {
//      int benchmarkID = 1;
//      for (String step in _atlasStep) {
//        for (String engine in _runEngine.keys) {
//          if (_runEngine[engine]) {
//            Map<String, String> run = {
//              "target": config.target,
//              "id": benchmarkID.toString(),
//              "baseUrl": '$_baseIp:${basePort++}',
//              "path": '/run/atlasses.html',
//              "cw": config.canvasWidth.toString(),
//              "ch": config.canvasHeight.toString(),
//              "nbObj": "1",
//              "engine": engine,
//              "step": step,
//              "parameter": _key(1)
//            };
//            runs.add(run);
//          }
//        }
//        benchmarkID++;
//      }
//    }
//
//    if (config.runFlipbook) {
//      for (String engine in _runEngine.keys) {
//        if (_runEngine[engine]) {
//          Map<String, String> run = {
//            "target": config.target,
//            "baseUrl": '$_baseIp:${basePort++}',
//            "path": '/run/flipbook.html',
//            "cw": config.canvasWidth.toString(),
//            "ch": config.canvasHeight.toString(),
//            "engine": engine,
//            "step": "flipbooks",
//            "parameter": _key(1)
//          };
//          runs.add(run);
//        }
//      }
//    }
//
//    if (config.runParticles) {
//      int benchmarkID = 1;
//      for (String step in _particlesStep) {
//        for (String engine in _runEngine.keys) {
//          if (_runEngine[engine]) {
//            Map<String, String> run = {
//              "target": config.target,
//              "id": benchmarkID.toString(),
//              "baseUrl": '$_baseIp:${basePort++}',
//              "path": '/run/particles.html',
//              "cw": config.canvasWidth.toString(),
//              "ch": config.canvasHeight.toString(),
//              "nbObj": "1",
//              "engine": engine,
//              "step": step,
//              "parameter": _key(1)
//            };
//            runs.add(run);
//          }
//        }
//        benchmarkID++;
//      }
//    }
//
//    if (config.runRenderTexture) {
//      for (String engine in _runEngine.keys) {
//        if (_runEngine[engine]) {
//          Map<String, String> run = {
//            "target": config.target,
//            "id": "1",
//            "baseUrl": '$_baseIp:${basePort++}',
//            "path": '/run/render_texture.html',
//            "cw": config.canvasWidth.toString(),
//            "ch": config.canvasHeight.toString(),
//            "nbObj": "1",
//            "engine": engine,
//            "step": "render texture",
//            "parameter": _key(1)
//          };
//          runs.add(run);
//        }
//      }
//    }
//
//    if (config.runShader) {
//      int benchmarkID = 1;
//      for (int data in shaders) {
//        for (String step in _shaderStep) {
//          for (String engine in _runEngine.keys) {
//            if (_runEngine[engine]) {
//              Map<String, String> run = {
//                "target": config.target,
//                "id": benchmarkID.toString(),
//                "baseUrl": '$_baseIp:${basePort++}',
//                "path": '/run/shaders.html',
//                "cw": config.canvasWidth.toString(),
//                "ch": config.canvasHeight.toString(),
//                "nbObj": data.toString(),
//                "engine": engine,
//                "step": step,
//                "parameter": _key(data)
//              };
//              runs.add(run);
//            }
//          }
//          benchmarkID++;
//        }
//      }
//    }
//
//    if (config.runShape) {
//      int benchmarkID = 1;
//      for (String step in _shapeStep) {
//        for (int data in childrenData) {
//          for (String engine in _runEngine.keys) {
//            if (_runEngine[engine]) {
//              Map<String, String> run = {
//                "target": config.target,
//                "id": benchmarkID.toString(),
//                "baseUrl": '$_baseIp:${basePort++}',
//                "path": '/run/shape.html',
//                "cw": config.canvasWidth.toString(),
//                "ch": config.canvasHeight.toString(),
//                "nbObj": data.toString(),
//                "engine": engine,
//                "step": step,
//                "parameter": _key(data)
//              };
//              runs.add(run);
//            }
//          }
//        }
//        benchmarkID++;
//      }
//    }
//
//    if (config.runSpine) {
//      int benchmarkID = 1;
//      for (int deform in shaders) {
//        for (int data in labelsData) {
//          for (String engine in _runEngine.keys) {
//            if (_runEngine[engine]) {
//              Map<String, String> run = {
//                "target": config.target,
//                "id": benchmarkID.toString(),
//                "baseUrl": '$_baseIp:${basePort++}',
//                "path": '/run/spines.html',
//                "cw": config.canvasWidth.toString(),
//                "ch": config.canvasHeight.toString(),
//                "nbObj": data.toString(),
//                "nbDeformObj": deform.toString(),
//                "engine": engine,
//                "step": "spine - $deform deforms",
//                "parameter": _key(data)
//              };
//              runs.add(run);
//            }
//          }
//        }
//      }
//      benchmarkID++;
//    }
//
//    if (config.runVisibility) {
//      int benchmarkID = 1;
//      for (String step in _visibilityStep) {
//        for (int data in childrenData) {
//          for (String engine in _runEngine.keys) {
//            if (_runEngine[engine]) {
//              Map<String, String> run = {
//                "target": config.target,
//                "id": benchmarkID.toString(),
//                "baseUrl": '$_baseIp:${basePort++}',
//                "path": '/run/visibility.html',
//                "cw": config.canvasWidth.toString(),
//                "ch": config.canvasHeight.toString(),
//                "nbObj": data.toString(),
//                "engine": engine,
//                "step": step,
//                "parameter": _key(data)
//              };
//              runs.add(run);
//            }
//          }
//        }
//        benchmarkID++;
//      }
//    }

//    if (config.runZindex) {
//      int benchmarkID = 1;
//      for (String step in _zIndexStep) {
//        for (int data in childrenData) {
//          for (String engine in _runEngine.keys) {
//            if (_runEngine[engine]) {
//              Map<String, String> run = {
//                "target": config.target,
//                "id": benchmarkID.toString(),
//                "baseUrl": '$_baseIp:${basePort++}',
//                "path": '/run/zindex.html',
//                "cw": config.canvasWidth.toString(),
//                "ch": config.canvasHeight.toString(),
//                "nbObj": data.toString(),
//                "engine": engine,
//                "step": step,
//                "parameter": _key(data)
//              };
//              runs.add(run);
//            }
//          }
//        }
//        benchmarkID++;
//      }
//    }
  }

  addResult(Map req) {
    String step = req['reponse']['step'];
    String parameter = req['reponse']['parameter'];
    String engine = req['reponse']['engine'];
    result[benchmark][step][parameter] ??= new Map();
    result[benchmark][step][parameter][engine] = req['result'];
  }
}

class _Config {
  String target;
  String userAgent;
  String userName;
  bool isMobile;
  String serverIp;
  String serverPort;
  int runDuration;
  int canvasWidth;
  int canvasHeight;
  bool runNg1n;
  bool runStageXl;
  bool runPixi;
  bool runChildren;
  bool runLabels;
  bool runFilters;
  bool runMasks;
  bool runBlendMode;
  bool runGpuSlot;
  bool runAddRemoveContainer;
  bool runAtlas;
  bool runFlipbook;
  bool runParticles;
  bool runRenderTexture;
  bool runShader;
  bool runShape;
  bool runSpine;
  bool runVisibility;
  bool runZindex;

  _Config(Map<String, String> base) {
    target = base["target"];
    userAgent = base["userAgent"];
    userName = base["userName"];
    isMobile = base["device"] == 'mobile';
    serverIp = base["serverIp"];
    serverPort = base["serverPort"];
    runDuration = int.parse(base["runDuration"]);
    canvasWidth = int.parse(base["canvasWidth"]);
    canvasHeight = int.parse(base["canvasHeight"]);
    runNg1n = base["runNg1n"] == "true";
    runStageXl = base["runStageXl"] == "true";
    runPixi = base["runPixi"] == "true";
    runChildren = base["runChildren"] == "true";
    runLabels = base["runLabels"] == "true";
    runFilters = base["runFilters"] == "true";
    runMasks = base["runMasks"] == "true";
    runBlendMode = base["runBlendMode"] == "true";
    runGpuSlot = base["runGpuSlot"] == "true";
    runAddRemoveContainer = base["runAddRemoveContainer"] == "true";
    runAtlas = base["runAtlas"] == "true";
    runFlipbook = base["runFlipbook"] == "true";
    runParticles = base["runParticles"] == "true";
    runRenderTexture = base["runRenderTexture"] == "true";
    runShader = base["runShader"] == "true";
    runShape = base["runShape"] == "true";
    runSpine = base["runSpine"] == "true";
    runVisibility = base["runVisibility"] == "true";
    runZindex = base["runZindex"] == "true";
  }
}
