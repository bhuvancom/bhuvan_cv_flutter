import 'package:bhuvan_cv/pages/main_page.dart';
import "package:flutter/foundation.dart";
import 'package:flutter/material.dart';
import "package:lottie/lottie.dart";
import '../config/config.dart';
import '../util/rest_api.dart';
import '../widgets/common_loading.dart';
import '../blocs/token_bloc.dart';
import 'package:provider/src/provider.dart';
import '../blocs/theme_bloc.dart';
import '../widgets/next_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isLoading = false;
  bool isDataReady = false;
  String error = "";

  @override
  void initState() {
    _fetchUserData();
    super.initState();
  }

  _fetchUserData() {
    _setData(true, false, "");
    context.read<TokenBloc>().getUserData(1, "").then((value) {
      _setData(false, value != null, value != null ? "" : "Error in Fetch");
      if (value != null) {
        _gotoPage(const MainPage());
      }
    }).catchError((onError) {
      _setData(false, false, onError.toString());
    });
  }

  _setData(isLoad, isReady, errorMsg) {
    if (mounted) {
      setState(() {
        isLoading = isLoad;
        isDataReady = isReady;
        error = errorMsg;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<TokenBloc>();
    final ThemeBloc tb = context.read<ThemeBloc>();
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          // top: true,
          // bottom: true,
          child: Column(
            children: [Text("Data is loading...")],
          ),
        ));
  }

  _gotoPage(page) {
    nextScreenReplace(context, page);
  }
}
