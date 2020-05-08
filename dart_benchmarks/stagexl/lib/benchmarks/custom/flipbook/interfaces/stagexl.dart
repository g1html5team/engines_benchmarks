import 'dart:async';

import 'package:stagexl/stagexl.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';

import 'common.dart';

class StagexlFlipbookInterface extends StagexlInterface
    implements FlipbookInterface {
  StagexlFlipbookInterface();

  ResourceManager resourceManager = ResourceManager();
  List<BitmapData> imgData;

  Future load( List<String> strings) async {
    imgData = List<BitmapData>();
    for(int i = 0 ; i< strings.length; i++)
      {

    resourceManager.addBitmapData('img$i', strings[i]);
      }
    await resourceManager.load();

    for(int i = 0 ; i< strings.length; i++)
    {
      imgData.add(resourceManager.getBitmapData('img$i'));
    }
  }

  play(FlipBook object, int currentFrame) {

    object.gotoAndPlay(currentFrame);
  }

  FlipBook createFlipbook() {

    return new FlipBook(imgData);
  }
}
