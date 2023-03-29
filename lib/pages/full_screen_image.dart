import "dart:convert";

import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final String? tag;

  const FullScreenImage({Key? key, required this.imageUrl, this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDatImg = imageUrl.toLowerCase().startsWith("data:image");
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: InteractiveViewer(
                child: tag == null
                    ? isDatImg
                        ? Image.memory(
                            base64Decode(
                              imageUrl.substring(
                                  imageUrl.indexOf(",") + 1, imageUrl.length),
                            ),
                            fit: BoxFit.contain,
                          )
                        : CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.contain,
                          )
                    : Hero(
                        tag: tag!,
                        child: isDatImg
                            ? Image.memory(
                                base64Decode(
                                  imageUrl.substring(imageUrl.indexOf(",") + 1,
                                      imageUrl.length),
                                ),
                                fit: BoxFit.contain,
                              )
                            : CachedNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.contain,
                              ))),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
