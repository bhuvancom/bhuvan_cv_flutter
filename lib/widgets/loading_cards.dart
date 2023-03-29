import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:skeleton_text/skeleton_text.dart";

import "../blocs/theme_bloc.dart";

class LoadingFeaturedCard extends StatelessWidget {
  const LoadingFeaturedCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      child: Container(
        margin: const EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

class LoadingCard extends StatelessWidget {
  final double? height;
  final double? width;

  const LoadingCard({Key? key, required this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: SkeletonAnimation(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          height: height,
          width: width ?? MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
