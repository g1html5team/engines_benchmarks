

import 'package:pixi/pixi.dart';
import 'package:pixi_dart_benchmark/benchmarks/shader/interfaces/shaders_facade.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';

import 'common.dart';

class PixiShaderInterface extends PixiInterface implements ShaderInterface {
  PixiShaderInterface();

  setShader(Sprite object, ShaderType shaderType,
      {DisplayObject optionnalObject}) //List<Filter<dynamic>>
  {
    switch (shaderType) {
      case ShaderType.blur:
        object.filters = [new BlurFilter()];
        break;
      case ShaderType.displacement:
        DisplacementFilter s = new DisplacementFilter(optionnalObject, 5.0);
        object.filters = [s];
        break;
      case ShaderType.glow:
        object.filters = [new NoiseFilter()];
        break;
    }
  }
}

class GlowFilter {
  GlowFilter(String vertexSrc, String fragmentSrc) {
    //basé sur pixi-extra-filters https://github.com/pixijs/pixi-extra-filters
    callFilter(vertexSrc, fragmentSrc);
  }
}
/*new Filter(
        // vertex shader
        '''#define GLSLIFY 1'''
        '''attribute vec2 aVertexPosition;'''
        '''attribute vec2 aTextureCoord;'''
        ''''''
        '''uniform mat3 projectionMatrix;'''
        '''varying vec2 vTextureCoord;'''
        ''''''
        '''void main(void){'''
        '''    gl_Position = vec4((projectionMatrix * vec3(aVertexPosition, 1.0)).xy, 0.0, 1.0);'''
        '''    vTextureCoord = aTextureCoord;'''
        '''}''',
        // fragment shader
        '''#define GLSLIFY 1'''
        '''varying vec2 vTextureCoord;'''
        '''varying vec4 vColor;'''
        ''''''
        '''uniform sampler2D uSampler;'''
        ''''''
        '''uniform float distance;'''
        '''uniform float outerStrength;'''
        '''uniform float innerStrength;'''
        '''uniform vec4 glowColor;'''
        '''uniform vec4 filterArea;'''
        '''uniform vec4 filterClamp;'''
        '''vec2 px = vec2(1.0 / filterArea.x, 1.0 / filterArea.y);'''
        ''''''
        '''void main(void) {'''
        '''    const float PI = 3.14159265358979323846264;'''
        '''    vec4 ownColor = texture2D(uSampler, vTextureCoord);'''
        '''    vec4 curColor;'''
        '''    float totalAlpha = 0.0;'''
        '''    float maxTotalAlpha = 0.0;'''
        '''    float cosAngle;'''
        '''    float sinAngle;'''
        '''    vec2 displaced;'''
        '''    for (float angle = 0.0; angle <= PI * 2.0; angle += $qualityDistance) {'''
        '''       cosAngle = cos(angle);'''
        '''       sinAngle = sin(angle);'''
        '''       for (float curDistance = 1.0; curDistance <= $distance; curDistance++) {'''
        '''           displaced.x = vTextureCoord.x + cosAngle * curDistance * px.x;'''
        '''           displaced.y = vTextureCoord.y + sinAngle * curDistance * px.y;'''
        '''           curColor = texture2D(uSampler, clamp(displaced, filterClamp.xy, filterClamp.zw));'''
        '''           totalAlpha += (distance - curDistance) * curColor.a;'''
        '''           maxTotalAlpha += (distance - curDistance);'''
        '''       }'''
        '''    }'''
        '''    maxTotalAlpha = max(maxTotalAlpha, 0.0001);'''
        ''''''
        '''    ownColor.a = max(ownColor.a, 0.0001);'''
        '''    ownColor.rgb = ownColor.rgb / ownColor.a;'''
        '''    float outerGlowAlpha = (totalAlpha / maxTotalAlpha)  * outerStrength * (1. - ownColor.a);'''
        '''    float innerGlowAlpha = ((maxTotalAlpha - totalAlpha) / maxTotalAlpha) * innerStrength * ownColor.a;'''
        '''    float resultAlpha = (ownColor.a + outerGlowAlpha);'''
        '''    gl_FragColor = vec4(mix(mix(ownColor.rgb, glowColor.rgb, innerGlowAlpha / ownColor.a), glowColor.rgb, outerGlowAlpha / resultAlpha) * resultAlpha, resultAlpha);'''
        '''}'''
        );*/
