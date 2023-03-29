import "package:flutter/material.dart";
import "empty.dart";
class EmptyData extends StatelessWidget {
  const EmptyData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height:
          MediaQuery.of(context).size.height * 0.20,
        ),
        EmptyPage(
            icon: Icons.hourglass_empty,
            message: "no-content",
            message1: ""),
      ],
    );
  }
}
