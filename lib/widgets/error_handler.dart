import 'package:flutter/material.dart';

class ErrorHandler extends StatelessWidget {
  final Function onRetry;
  final String msg;

  const ErrorHandler({Key? key, required this.onRetry, required this.msg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(
            'Error loading data, $msg',
            textAlign: TextAlign.center,
          ),
          TextButton.icon(
            style: ButtonStyle(
              padding: MaterialStateProperty.resolveWith(
                  (states) => EdgeInsets.only(left: 10, right: 10)),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => Theme.of(context).primaryColor),
              shape: MaterialStateProperty.resolveWith((states) =>
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3))),
            ),
            icon: Icon(Icons.refresh, color: Colors.white, size: 20),
            label: Text('Retry', style: TextStyle(color: Colors.white)),
            onPressed: () {
              onRetry();
            },
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
