// Copyright (c) East-Tec <https://www.east-tec.com/>. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../common/strings.dart' as strings;
import '../screens/invalid_screen.dart';
import '../screens/passease_screen.dart';
import '../screens/settings_screen.dart';

/// The route configuration for the app.
final GoRouter appRouter = GoRouter(
  // The error handler redirects to the Invalid screen
  onException: (_, GoRouterState state, GoRouter router) {
    router.go('/404', extra: state.uri.toString());
  },

  // The routes configuration
  routes: <RouteBase>[
    // The home route of the app is the PassEase screen
    GoRoute(
      path: '/',
      builder: _passEaseRouteBuilder,
      routes: [
        // The child route for the Settings screen
        GoRoute(
          path: 'settings',
          builder: _settingsRouteBuilder,
        ),
      ],
    ),

    // The route for the Invalid screen, when the route is invalid
    GoRoute(
      path: '/404',
      builder: (BuildContext context, GoRouterState state) {
        return InvalidScreen(message: strings.invalidPage(state.extra as String?));
      },
    ),
  ],
);

// -------------------------------------------------------------------------------------------------
// PassEase Route (Home)
// -------------------------------------------------------------------------------------------------

/// The route builder for the PassEase screen, which is the home screen of the app.
Widget _passEaseRouteBuilder(BuildContext context, GoRouterState state) {
  return const PassEaseScreen();
}

// -------------------------------------------------------------------------------------------------
// Settings Route
// -------------------------------------------------------------------------------------------------

/// The route builder for the Settings screen.
Widget _settingsRouteBuilder(BuildContext context, GoRouterState state) {
  return const SettingsScreen();
}

/// Navigates to the Settings screen.
Future<void> gotoSettingsRoute(BuildContext context) async {
  return await context.push<void>('/settings');
}
