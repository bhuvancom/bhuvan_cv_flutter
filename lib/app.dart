import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/splash_page.dart';
import 'blocs/theme_bloc.dart';
import 'blocs/token_bloc.dart';
import 'models/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeBloc>(
      create: (_) => ThemeBloc(),
      child: Consumer<ThemeBloc>(
        builder: (_, mode, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<TokenBloc>(
                  create: (context) => TokenBloc()),
            ],
            child: MaterialApp(
              theme: ThemeModel().lightMode,
              darkTheme: ThemeModel().darkMode,
              themeMode:
                  mode.darkTheme == true ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: const SplashPage(),
            ),
          );
        },
      ),
    );
  }
}
