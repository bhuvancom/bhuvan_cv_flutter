// import "dart:convert";
//
// import "package:cached_network_image/cached_network_image.dart";
// import "package:flutter/material.dart";
// import "package:flutter_html/flutter_html.dart";
// import "package:provider/src/provider.dart";
// import "../blocs/theme_bloc.dart";
// import "../config/log_me.dart";
// import "../pages/navigation_pages/full_screen_image.dart";
// import "../services/app_service.dart";
// import "../utils/next_screen.dart";
//
// class HtmlBodyWidget extends StatelessWidget {
//   final String content;
//   final bool isVideoEnabled;
//   final bool isimageEnabled;
//   final bool isIframeVideoEnabled;
//   final double? fontSize;
//
//   const HtmlBodyWidget({
//     Key? key,
//     required this.content,
//     required this.isVideoEnabled,
//     required this.isimageEnabled,
//     required this.isIframeVideoEnabled,
//     this.fontSize,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Html(
//       data: """$content""",
//       onLinkTap: (String? url, RenderContext context1,
//           Map<String, String> attributes, _) {
//         if (url != null) AppService().openLink(context, url);
//       },
//       onImageTap: (String? url, RenderContext context1,
//           Map<String, String> attributes, _) {
//         nextScreen(context, FullScreenImage(imageUrl: url!));
//       },
//       style: {
//         "body": Style(
//           margin: Margins.zero,
//           padding: EdgeInsets.zero,
//
//           //Enable the below line and disble the upper line to disble full width image/video
//
//           //padding: EdgeInsets.all(20),
//
//           fontSize:
//               fontSize == null ? FontSize(18.0) : FontSize(16.0),
//           lineHeight: const LineHeight(1.5),
//           fontFamily: "Oswald",
//           // fontWeight: FontWeight.w400,
//           textAlign: TextAlign.start,
//           //
//           // color: context.watch<ThemeBloc>().darkTheme == false
//           //   ? CustomColor().bodyTextColorLight
//           //   : CustomColor().bodyTextColorDark,
//           // backgroundColor: context.watch<ThemeBloc>().darkTheme == false
//           //     ? Colors.white
//           //     : Color(0xff303030),
//           // textDecorationColor: context.watch<ThemeBloc>().darkTheme != false
//           //     ? Colors.white
//           //     : Color(0xff303030),
//         ),
//         "figure": Style(margin: Margins.zero, padding: EdgeInsets.zero),
//         "p,div,body,font": Style(
//             backgroundColor: context.watch<ThemeBloc>().darkTheme == false
//                 ? Colors.white
//                 : const Color(0xff303030),
//             color: context.watch<ThemeBloc>().darkTheme == false
//                 ? Colors.black
//                 : Colors.white,
//             margin: Margins.zero,
//             padding: EdgeInsets.zero),
//
//         //Disable this line to disble full width image/video
//         "p,h1,h2,h3,h4,h5,h6": Style(
//           margin: Margins.only(top: 5, bottom: 0, right: 0, left: 0),
//           padding: EdgeInsets.zero,
//           wordSpacing: 0,
//           lineHeight: const LineHeight(1.3),
//         ),
//
//         "p": Style(padding: const EdgeInsets.only(top: 1, bottom: 1))
//       },
//       customRenders: {
//         "img": (RenderContext context1, Widget child) {
//           final String _imageSource =
//               context1.tree.element!.attributes["src"].toString();
//           if (isimageEnabled == false) return Container();
//           LogMe.logInfo("url ${_imageSource.toString()}");
//           final isDataImg = _imageSource.toLowerCase().startsWith("data:image");
//           return InkWell(
//             child: Container(
//                 padding: const EdgeInsets.only(top: 5, bottom: 5),
//                 child: isDataImg
//                     ? Image.memory(base64Decode(_imageSource.substring(
//                         _imageSource.indexOf(",") + 1, _imageSource.length)))
//                     : CachedNetworkImage(imageUrl: _imageSource)),
//             onTap: () =>
//                 nextScreen(context, FullScreenImage(imageUrl: _imageSource)),
//           );
//         },
//         "video": (RenderContext context1, Widget child) {
//           final String _videoSource =
//               context1.tree.element!.attributes["src"].toString();
//           if (isVideoEnabled == false) return Container();
//           return LocalVideoPlayer(videoUrl: _videoSource);
//         },
//         "iframe": (RenderContext context1, Widget child) {
//           final String _videoSource =
//               context1.tree.element!.attributes["src"].toString();
//           print("url of video is $_videoSource");
//           if (isIframeVideoEnabled == false) return Container();
//           if (_videoSource.contains("youtube")) {
//             return IframePlayerWidget(youtubeVideoUrl: _videoSource);
//           } else if (_videoSource.contains("vimeo")) {
//           } else {
//             LogMe.logInfo("inside else  and  ${_videoSource}");
//             if (_videoSource.contains("twitter")) {
//               const reg = r"^.*&id=([0-9]+)(&).*$";
//               final regex = RegExp(reg, caseSensitive: false);
//               final c = regex.firstMatch(_videoSource)?.groupCount;
//               if (c != null && c >= 1) {
//                 LogMe.logInfo("custom twitter coming");
//                 try {
//                   return twitter_web.WebView(
//                     initialUrl: Uri.dataFromString(
//                       getHtmlString(
//                           regex.firstMatch(_videoSource)!.group(1) ?? ""),
//                       mimeType: "text/html",
//                       encoding: Encoding.getByName("utf-8"),
//                     ).toString(),
//                     onPageFinished: (data) {
//                       LogMe.logInfo("page twitter finish $data");
//                     },
//                     onProgress: (prog) {
//                       LogMe.logInfo("prog twitter $prog");
//                     },
//                     javascriptMode: JavascriptMode.unrestricted,
//                   );
//                 } catch (e) {
//                   LogMe.logError("error in web $e");
//                 }
//               }
//             }
//           }
//         },
//       },
//     );
//   }
//
//   String getHtmlString(String tweetId) {
//     return """
//       <html>
//
//         <head>
//           <meta name="viewport" content="width=device-width, initial-scale=1">
//         </head>
//         <body>
//             <div id="container"></div>
//
//         </body>
//         <script id="twitter-wjs" type="text/javascript" async defer src="https://platform.twitter.com/widgets.js" onload="createMyTweet()"></script>
//         <script>
//
//
//       function  createMyTweet() {
//          var twtter = window.twttr;
//          twttr.widgets.createTweet(
//           "$tweetId",
//           document.getElementById("container"),
//         )
//       }
//         </script>
//
//       </html>
//     """;
//   }
// }
