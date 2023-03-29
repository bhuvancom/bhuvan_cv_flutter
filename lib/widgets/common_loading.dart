import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../blocs/theme_bloc.dart';
import '../config/config.dart';
import 'package:provider/src/provider.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tb = context.watch<ThemeBloc>();
    return Center(
        child: SizedBox(
          height: 250,
          child: Lottie.asset(
            tb.darkTheme == true
                ? Config.LOTTIE_LOADING_DARK
                : Config.LOTTIE_LOADING,
            fit: BoxFit.cover,
          ),
        ));
  }
}
