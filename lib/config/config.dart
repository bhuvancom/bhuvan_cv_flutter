import "dart:math";

import "package:flutter/material.dart";

class Config {

  static const String _BASE_URL = "https://demo.goredcat.com";
  static const BASE_URL_API = _BASE_URL + "/api/";
  static const String LOTTIE_LOADING_DARK =
      "assets/animation_files/loading.json";
  static const String LOTTIE_LOADING =
      "assets/animation_files/loading.json";

  static const Color BLUE_DIANNE = Color.fromARGB(255, 38, 70, 83);
  static const Color JUNGLE_GREEN = Color.fromARGB(250, 42, 157, 143);
  static const Color YELLOW_ROY = Color.fromARGB(255, 233, 196, 106);
  static const Color SANDY_ORANGE = Color.fromARGB(255, 244, 162, 97);
  static const Color BRUNT_RED = Color.fromARGB(255, 231, 111, 81);
  static const Color ACCENT_COLOR = Color.fromARGB(28, 106, 188, 100);
  final Color appColor = ACCENT_COLOR; //Colors.deepPurpleAccent;
  static const String USER_SP = "user";
  static const String USER_ENC_ROLL = "enc_roll";
  static const String AUTH_TOKEN = "auth";
  static const String IS_LOGGED_IN = "isLoggedIn";
  static const String GUEST_USER = "guestUser";
  static const String SP_KEY = "TOKEN";

  //animation files
  final String doneAsset = "assets/animation_files/done.json";

  //Language Setup
  final List<String> languages = [
    "English",
    // 'Spanish',
    // 'Arabic'
  ];


  static List<String> imgs = [
    "https://images.pexels.com/photos/11434107/pexels-photo-11434107.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/9711938/pexels-photo-9711938.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/11763347/pexels-photo-11763347.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/11258764/pexels-photo-11258764.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/3748961/pexels-photo-3748961.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/11633600/pexels-photo-11633600.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/12003586/pexels-photo-12003586.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/12237096/pexels-photo-12237096.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/12125084/pexels-photo-12125084.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/12190111/pexels-photo-12190111.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/10404283/pexels-photo-10404283.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/9485465/pexels-photo-9485465.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/12240136/pexels-photo-12240136.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/8539548/pexels-photo-8539548.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/12072057/pexels-photo-12072057.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
  ];

  static const String INTRO_STATUS = "INTRO_STATUS";

  static String getRandom() {
    int min = 0;
    int max = imgs.length - 1;
    final rnd = Random();
    int r = min + rnd.nextInt(max - min);
    return imgs[r];
  }

  static String secondToMinute(int seconds) {
    int minutes = (seconds / 60).round();
    return (minutes % 60).toString().padLeft(2, "0") + " minutes";
  }

  static String secondToStringTime(int sec) {
    final Duration duration = Duration(seconds: sec);
    return secToHMS(duration);
  }

  static String secToHMS(Duration duration) {
    String hours = duration.inHours.toString().padLeft(0, "2");
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, "0");
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, "0");
    return "$hours:$minutes:$seconds";
  }
}
