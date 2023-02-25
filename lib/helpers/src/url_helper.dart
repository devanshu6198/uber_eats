import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:url_launcher/url_launcher_string.dart';

Future<bool> launchUrl(String url) async {
  var uri = Uri.parse(url);
  var canLaunch = await url_launcher.canLaunchUrl(uri);
  if (canLaunch) {
    url_launcher
        .launchUrl(uri, mode: LaunchMode.externalApplication)
        .whenComplete(() => debugPrint("launchUrl -> $url"));
  }
  return canLaunch;
}
