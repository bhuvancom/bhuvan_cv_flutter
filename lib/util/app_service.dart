import "dart:io";

import "package:flutter/foundation.dart";
import "package:url_launcher/url_launcher.dart" as urlLauncher;
import "package:url_launcher/url_launcher.dart";

import "../config/config.dart";
import "../widgets/toast.dart";
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AppService {
  Future<bool?> checkInternet() async {
    bool? internet;
    try {
      if (kIsWeb) return true;

      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        internet = true;
      }
    } on SocketException catch (_) {
      internet = false;
    }
    return internet;
  }

  Future openLink(context, String url) async {
    if (await urlLauncher.canLaunch(url)) {
      urlLauncher.launch(url);
    } else {
      openToast1(context, "Can't launch the url");
    }
  }
}
