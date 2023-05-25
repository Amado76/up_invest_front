import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'core/themes/themes.dart';
import 'modules/settings/bloc/settings_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsBloc = context.watch<SettingsBloc>((bloc) => bloc.stream);
    final settingsState = settingsBloc.state;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: settingsState.themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      title: 'Up Invest',
      builder: (context, child) {
        return ResponsiveWrapper.builder(child,
            defaultScale: true, defaultScaleFactor: 1);
      },
    );
  }
}
