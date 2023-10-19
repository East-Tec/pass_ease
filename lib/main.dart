// Copyright (c) East-Tec <https://www.east-tec.com/>. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import 'package:flutter/material.dart';

import '../common/settings.dart' as settings;
import 'common/routes.dart' as routes;
import 'common/strings.dart' as strings;
import 'common/theme.dart' as theme;

/// The main entry point of the app that runs the app.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // First try to load the app settings from Shared Preferences
  await Future.any([
    settings.load(),
    Future.delayed(const Duration(seconds: 5)),
  ]);

  // Then run the app
  runApp(const PassEaseApp());
}

/// The main app widget.
class PassEaseApp extends StatelessWidget {
  /// Constructs a [PassEaseApp].
  const PassEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: strings.appName,

      // The app routes configuration
      routerConfig: routes.appRouter,

      // The light theme of the app
      theme: theme.appTheme(Brightness.light),

      // The dark theme of the app
      darkTheme: theme.appTheme(Brightness.dark),
    );
  }
}
