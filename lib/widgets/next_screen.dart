import 'dart:io';

import 'package:flutter/cupertino.dart';
import "package:flutter/foundation.dart";
import 'package:flutter/material.dart';

import '../pages/full_screen_image.dart';

void navigateToFullScreenImg(context, imgUrl, String? tag) {
  final page = FullScreenImage(imageUrl: imgUrl, tag: tag);
  nextScreen(context, page);
}

Future nextScreen(context, page) async {
  if (!kIsWeb && Platform.isAndroid) {
    return await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
  } else if (!kIsWeb && Platform.isIOS) {
    return await nextScreeniOS(context, page);
  } else {
    return await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
  }
}

Future nextScreeniOS(context, page) async {
  return await Navigator.push(
      context, CupertinoPageRoute(builder: (context) => page));
}

void nextScreenCloseOthers(context, page) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => page), (route) => false);
}

void goBack(context) {
  Navigator.pop(context);
}

void nextScreenReplace(context, page) {
  if (!kIsWeb && Platform.isAndroid)
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  else if (!kIsWeb && Platform.isIOS)
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => page));
  else
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenPopup(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(fullscreenDialog: true, builder: (context) => page),
  );
}

/*
void navigateToNewsComment(context, NewsFront news) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => NewsComment(newsFront: news)),
  );
}

void navigateToAddNews(context, tag) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => UserNewsPage(tag: tag)),
  );
}

void navigateToBookMarks(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => BookMarksPage()));
}

void navigateToFullScreenImg(context, imgUrl, String? tag) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FullScreenImage(imageUrl: imgUrl, tag: tag)));
}

void navigateToNewsDetailsScreen(context, NewsFront news, String? herotag) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => NewsDetails(
              data: news,
              tag: herotag,
            )),
  );
}
void navigateToNewsDetailsScreenReplacing(context, NewsFront news, String? herotag) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) => NewsDetails(
              data: news,
              tag: herotag,
            )),
  );
}

void navigateToVideo(context, NewsVideoModel m, String tag) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => VideoNewsDetails(d: m, tag: tag)),
  );
}

 */
