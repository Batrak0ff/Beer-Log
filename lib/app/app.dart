import 'package:flutter/material.dart';

import 'router.dart';
import 'theme.dart';

class BrewLogApp extends StatelessWidget {
  const BrewLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BrewLog',
      theme: buildDarkTheme(),
      themeMode: ThemeMode.dark,
      routerConfig: appRouter,
    );
  }
}
