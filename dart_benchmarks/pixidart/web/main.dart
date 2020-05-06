import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:http/browser_client.dart';
import 'package:http/http.dart';
import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/helpers/user_agent.dart';
import 'package:uuid/uuid.dart';

String server;
DivElement canvasContainer;
HeadingElement benchMarkState;

main() {
  ButtonElement buttonElement = querySelector('#start');
  InputElement inputIp = querySelector('#input-ip');
  SelectElement selectDevice = querySelector('#input-user-device');
  document.body.style.display = 'flex';

  canvasContainer = querySelector('#canvas-container');
  benchMarkState = canvasContainer.querySelector('h1');
  inputIp.value = Uri.base.host;
  inputIp.placeholder = Uri.base.host;
  UserAgent agent = new UserAgent.current();
  selectDevice.value = agent.mobile ? 'mobile' : 'desktop';
  buttonElement.onClick.listen(_run);

  //  window.console.info('Benchmark : $importChildren is running');
}

BrowserClient _client = new BrowserClient();
String runID;
AnchorElement _resultUrl;

_run(_) async {
  InputElement ip = querySelector('#input-ip');
  InputElement port = querySelector('#input-port');

  server = 'http://${ip.value}:${port.value}';

  try {
    runID = "${new Uuid().v4()}";
    Map config = _initConfig();
    Response rep = await _client.post(server + '/api/config?id=$runID',
        body: json.encode(config));

    if (rep.statusCode == 200) {
      String _resRawUrl = 'http://${ip.value}:8080/result_view.html?id=$runID';
      window.console.log('Result viewer : $_resRawUrl');
      _resultUrl = new AnchorElement()
        ..text = _resRawUrl
        ..href = _resRawUrl;
      querySelector('#bm-container').remove();
      canvasContainer.style.display = 'block';
      _runBenchmarks(rep);
    } else {
      window.alert('Couldn\'t connect to the server');
    }
  } catch (e) {
    window.alert('Couldn\'t connect to the server');
  }
}



Map<String, String> _initConfig() {
  InputElement user = querySelector('#input-user');
  SelectElement device = querySelector('#input-user-device');
  InputElement ip = querySelector('#input-ip');
  InputElement port = querySelector('#input-port');
  InputElement runDuration = querySelector('#input-run-duration');
  InputElement canvasWidth = querySelector('#input-canvas-width');
  InputElement canvasHeight = querySelector('#input-canvas-height');
//  InputElement useNg1n = querySelector('#input-use-ng1n');
//  InputElement useStagexl = querySelector('#input-use-stagexl');
  InputElement usePixi = querySelector('#input-use-pixi');
  InputElement useBenchmarkChildren = querySelector('#input-use-children');
  InputElement useBenchmarkLabel = querySelector('#input-use-label');
  InputElement useBenchmarkFilter = querySelector('#input-use-filter');
  InputElement useBenchmarkMask = querySelector('#input-use-mask');
  InputElement useBenchmarkBlendMode = querySelector('#input-use-blend');
  InputElement useBenchmarkGpuSlot = querySelector('#input-use-gpu');
  InputElement useBenchmarkAtlas = querySelector('#input-use-atlas');
  InputElement useBenchmarkFlipbook = querySelector('#input-use-flipbook');
  InputElement useBenchmarkParticles = querySelector('#input-use-particles');
  InputElement useBenchmarkRenderTexture =
      querySelector('#input-use-render-texture');
  InputElement useBenchmarkShader = querySelector('#input-use-shader');
  InputElement useBenchmarkSpine = querySelector('#input-use-spine');
  InputElement useBenchmarkVisibility = querySelector('#input-use-visibility');
  InputElement useBenchmarkZindex = querySelector('#input-use-zindex');

  return {
    "target": Uri.base.toString(),
    "userAgent": new UserAgent.current().value,
    "userName": user.value,
    "device": device.value,
    "serverIp": ip.value,
    "serverPort": port.value,
    "runDuration": runDuration.value,
    "canvasWidth": canvasWidth.value,
    "canvasHeight": canvasHeight.value,
//    "runNg1n": useNg1n.checked.toString(),
//    "runStageXl": useStagexl.checked.toString(),
    "runPixi": usePixi.checked.toString(),
    "runChildren": useBenchmarkChildren.checked.toString(),
    "runLabels": useBenchmarkLabel.checked.toString(),
    "runFilters": useBenchmarkFilter.checked.toString(),
    "runMasks": useBenchmarkMask.checked.toString(),
    "runBlendMode": useBenchmarkBlendMode.checked.toString(),
    "runGpuSlot": useBenchmarkGpuSlot.checked.toString(),
    "runAtlas": useBenchmarkAtlas.checked.toString(),
    "runFlipbook": useBenchmarkFlipbook.checked.toString(),
    "runParticles": useBenchmarkParticles.checked.toString(),
    "runRenderTexture": useBenchmarkRenderTexture.checked.toString(),
    "runShader": useBenchmarkShader.checked.toString(),
    "runSpine": useBenchmarkSpine.checked.toString(),
    "runVisibility": useBenchmarkVisibility.checked.toString(),
    "runZindex": useBenchmarkZindex.checked.toString()
  };
}

typedef GraphicEngineBenchmark BenchmarkFactory(IFrameElement iFrame);

IFrameElement currentIFrame;

_setState(String graphicEngine, String step, String parameters) {
  benchMarkState.text =
      graphicEngine.toUpperCase() + ' - ' + step + ' - ' + parameters;
}

_runBenchmarks(Response rep) async {
  Response lastRep = rep;

  while (true) {
    Map<String, String> body = Map.castFrom(json.decode(lastRep.body));
    _setState(body['engine'], body['step'], body['parameter']);
    String baseUrl = body.remove("baseUrl");
    String path = body.remove("path");
    Uri uri = new Uri.http(baseUrl, path, body);

    createIFrame(uri.toString(), body["cw"], body["ch"]);

    Completer _completer = new Completer();
    Map benchmarkResult;

    StreamSubscription sub = window.onMessage.listen((MessageEvent e) {
      benchmarkResult = json.decode(e.data);
      _completer.complete();
    });

    await _completer.future;

    await sub.cancel();

    Map req = {'result': benchmarkResult, 'reponse': json.decode(lastRep.body)};

    lastRep = await _client.post(server + '/api/next?id=$runID',
        body: json.encode(req));

    if (lastRep.statusCode != 200) break;
  }
}

createIFrame(String url, String canvasWidth, String canvasHeight) {
  if (currentIFrame != null) {
    currentIFrame.src = '';
    currentIFrame.width = '1px';
    currentIFrame.height = '1px';
    currentIFrame.remove();
    currentIFrame = null;
  }

  currentIFrame = new IFrameElement();
  currentIFrame.src = url;
  currentIFrame.width = '${canvasWidth}px';
  currentIFrame.height = '${canvasHeight}px';
  canvasContainer.append(currentIFrame);
}

//_startBenchmark() async {
//  canvasContainer = querySelector('#canvas-container');
//  canvasContainer.className = 'active';
//  benchMarkState = querySelector('#bm-state');
//
//  _buildMap();
//
//  Stopwatch watch = new Stopwatch()..start();
//
//  num d = watch.elapsedMilliseconds / 1000;
//  mainMap[info][duration] = d.toStringAsFixed(2) + ' sec';
//  await _client.post(server + '/api/save?id=$_id', body: JSON.encode(mainMap));
//  benchMarkState
//    ..text = ''
//    ..append(new SpanElement()..text = 'Bencharmks done - ')
//    ..append(_resultUrl);
//}
//

//
//Map<String, String> _addBenchmarkInfos() {
//  DateTime d = new DateTime.now();
//  return {
//    user: _config.userName,
//    agent: new UserAgent.current().value,
//    date: '${d.day}/${d.month}/${d.year} - ${d.hour}:${d.minute}',
//    duration: '',
//    runDuration: _config.runDuration.toString() + ' sec',
//    canvasWidth: _config.canvasWidth.toString(),
//    canvasHeight: _config.canvasHeight.toString(),
//    ng1n: _config.runNg1n.toString(),
//    stagexl: _config.runStageXl.toString(),
//    pixi: _config.runPixi.toString()
//  };
//}
//

//
////TODO : refacto ou trouver mieux
//// Faire une liste de steps ?
//_buildMap() {
//  mainMap[info] = _addBenchmarkInfos();
//  mainMap[benchmark] = new Map();
//  if (_config.runChildren) {
//    mainMap[benchmark][children + ' ' + animate] = new Map();
//    mainMap[benchmark][children + ' ' + addRemove] = new Map();
//    mainMap[benchmark][children + ' ' + stairs] = new Map();
//  }
//  if (_config.runLabels) {
//    mainMap[benchmark][labels + ' ' + maxValue + ' 1000'] = new Map();
//    mainMap[benchmark][labels + ' ' + maxValue + ' 10000'] = new Map();
//    mainMap[benchmark][labels + ' ' + maxValue + ' 100000'] = new Map();
//  }
//  if (_config.runFilters) {
//    mainMap[benchmark][filters + ' ' + brightness] = new Map();
//    mainMap[benchmark][filters + ' ' + hue] = new Map();
//  }
//  if (_config.runMasks) {
//    mainMap[benchmark][mask + ' ' + size + ' 50*50'] = new Map();
//    mainMap[benchmark][mask + ' ' + size + ' 250*250'] = new Map();
//    mainMap[benchmark][mask + ' ' + size + ' 500*500'] = new Map();
//  }
//}
//
//String key(int n) => '$n $objects';
//
//Future _runBenchmark(BenchmarkFactory benchmarkFactory, String engine) async {
//  String step, parameter;
//
//  List<int> childrenData = [100, 500, 2000, 5000];
//  List<int> labelsData = [100, 250, 500];
//  List<int> maskData = [50, 250, 500];
//
//  if (_config.runChildren) {
//    ///Animation
//    for (int data in childrenData) {
//      GraphicEngineBenchmark benchmarker = benchmarkFactory(currentIFrame);
//      _setState(engine, step = children + ' ' + animate, parameter = key(data));
//      mainMap[benchmark][step][parameter] ??= new Map();
//      mainMap[benchmark][step][parameter][engine] =
//          await benchmarker.manager.runChildrenAnimateBenchmark(data);
//    }
//
//    ///Add & Remove
//    for (int data in childrenData) {
//      GraphicEngineBenchmark benchmarker = benchmarkFactory(currentIFrame);
//      _setState(
//          engine, step = children + ' ' + addRemove, parameter = key(data));
//      mainMap[benchmark][step][parameter] ??= new Map();
//      mainMap[benchmark][step][parameter][engine] =
//          await benchmarker.manager.runChildrenAddRemoveBenchmark(data);
//    }
//
//    ///Stairs
//    for (int data in childrenData) {
//      GraphicEngineBenchmark benchmarker = benchmarkFactory(currentIFrame);
//      _setState(engine, step = children + ' ' + stairs, parameter = key(data));
//      mainMap[benchmark][step][parameter] ??= new Map();
//      mainMap[benchmark][step][parameter][engine] =
//          await benchmarker.manager.runChildrenStairsBenchmark(data);
//    }
//  }
//
//  if (_config.runLabels) {
//    ///1.000
//    for (int data in labelsData) {
//      GraphicEngineBenchmark benchmarker = benchmarkFactory(currentIFrame);
//      _setState(engine, step = labels + ' ' + maxValue + ' 1000',
//          parameter = key(data));
//      mainMap[benchmark][step][parameter] ??= new Map();
//      mainMap[benchmark][step][parameter][engine] =
//          await benchmarker.manager.runLabelsBenchmark(data, 1000);
//    }
//
//    ///10.000
//    for (int data in labelsData) {
//      GraphicEngineBenchmark benchmarker = benchmarkFactory(currentIFrame);
//      _setState(engine, step = labels + ' ' + maxValue + ' 10000',
//          parameter = key(data));
//      mainMap[benchmark][step][parameter] ??= new Map();
//      mainMap[benchmark][step][parameter][engine] =
//          await benchmarker.manager.runLabelsBenchmark(data, 10000);
//    }
//
//    ///100.000
//    for (int data in labelsData) {
//      GraphicEngineBenchmark benchmarker = benchmarkFactory(currentIFrame);
//      _setState(engine, step = labels + ' ' + maxValue + ' 100000',
//          parameter = key(data));
//      mainMap[benchmark][step][parameter] ??= new Map();
//      mainMap[benchmark][step][parameter][engine] =
//          await benchmarker.manager.runLabelsBenchmark(data, 100000);
//    }
//  }
//
//  if (_config.runFilters) {
//    ///Brightness
//    for (int data in childrenData) {
//      GraphicEngineBenchmark benchmarker = benchmarkFactory(currentIFrame);
//      _setState(
//          engine, step = filters + ' ' + brightness, parameter = key(data));
//      mainMap[benchmark][step][parameter] ??= new Map();
//      mainMap[benchmark][step][parameter][engine] =
//          await benchmarker.manager.runFilterBrightnessBenchmark(data);
//    }
//
//    ///Hue
//    for (int data in childrenData) {
//      GraphicEngineBenchmark benchmarker = benchmarkFactory(currentIFrame);
//      _setState(engine, step = filters + ' ' + hue, parameter = key(data));
//      mainMap[benchmark][step][parameter] ??= new Map();
//      mainMap[benchmark][step][parameter][engine] =
//          await benchmarker.manager.runFilterHueBenchmark(data);
//    }
//  }
//
//  if (_config.runMasks) {
//    /// Masks
//    for (int sizing in maskData) {
//      for (int data in childrenData) {
//        GraphicEngineBenchmark benchmarker = benchmarkFactory(currentIFrame);
//        _setState(engine, step = mask + ' ' + size + ' $sizing*$sizing',
//            parameter = key(data));
//        mainMap[benchmark][step][parameter] ??= new Map();
//        mainMap[benchmark][step][parameter][engine] = await benchmarker.manager
//            .runMaskBenchmark(data, new Size(sizing, sizing));
//      }
//    }
//  }
//}
