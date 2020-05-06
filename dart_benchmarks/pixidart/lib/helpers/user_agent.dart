import 'dart:html';

//TODO(xha): investiguer un vrai parser de User-Agent:
//https://github.com/typekit/webfontloader/blob/master/src/core/useragentparser.js

final UserAgent _current = new UserAgent(window.navigator.userAgent);

// On implémente la même logique que dans le boot.min.js.
//TODO(xha): essayer d'unifier cette logique.
final bool isMobile = _current.mobile ||
    _current.android ||
    Uri.base.queryParameters['mobile'] != null;

class UserAgent {
  final String _ua, _uaLower;
  final bool _ieMobile;

  UserAgent(String ua)
      : _ua = ua,
        _uaLower = ua.toLowerCase(),
        _ieMobile = ua.contains('IEMobile') || ua.contains('WPDesktop');

  factory UserAgent.current() => _current;

  String get value => _ua;

  bool get desktop => !mobile && !android;

  bool get mobile => _uaLower.contains("mobile") || _ua.contains("WPDesktop");

  bool get iOS => _ua.contains(new RegExp(r'(iPad|iPhone|iPod)')) && !_ieMobile;

  bool get iPad => _ua.contains('iPad');

  bool get iPhone => _ua.contains('iPhone') && !_ieMobile;

  bool get iPod => _ua.contains('iPod');

  bool get iOS8 => iOS && _ua.contains('OS 8_');

  bool get iOS7 => iOS && _ua.contains('OS 7_');

  bool get iOS6 => iOS && _ua.contains('OS 6_');

  bool get webKit => _ua.contains('AppleWebKit') && !_ieMobile;

  bool get android => _ua.contains('Android') && !_ieMobile;

  bool get safari => _ua.contains('Safari') && !_ieMobile;

  bool get chrome => _ua.contains('Chrome') && !_ua.contains('Edge');

  bool get chromeiOS => _ua.contains('CriOS');

  // Tester pour MSIE ne marche plus dans IE11
  bool get internetExplorer => _ua.contains('MSIE') || isIE11;

  bool get edge => _ua.contains('Windows') && _ua.contains('Edge');

  bool get windowsNt61 => _ua.contains('Windows NT 6.1');

  bool get isIE11 => _ua.contains('Trident/');

  bool get ieMobile => _ieMobile;

  bool get firefox => _ua.contains('Firefox') && !_ua.contains('Edge');

  bool get appleApp =>
      webKit && _ua.contains('Mobile/') && !_ua.contains('Safari/');

  bool get crosswalk => _ua.contains('Crosswalk');

  List<String> get classes {
    List<String> values = new List<String>();

    if (iOS)
      values.add('ios');
    else if (android)
      values.add('android');
    else if (chrome)
      values.add('chrome');
    else if (internetExplorer)
      values.add('ie');
    else if (firefox)
      values.add('firefox');
    else if (safari) values.add('safari');

    if (webKit) values.add('webkit');

    if (iPad) values.add('ipad');

    if (iOS7)
      values.add('ios7');
    else if (iOS6) values.add('ios6');

    if (appleApp) values.add('apple-app');

    if (ieMobile) values.add('ie-mobile');

    return values;
  }

  String getString() => _ua;

  String toString() => classes.join(' ');
}
