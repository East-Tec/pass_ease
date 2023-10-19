// Copyright (c) East-Tec <https://www.east-tec.com/>. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import 'package:flutter/material.dart';

import 'package:url_launcher/link.dart';

import '../common/strings.dart' as strings;

/// The Invalid screen that is displayed for invalid routes.
class InvalidScreen extends StatelessWidget {
  /// Creates a new Invalid screen to display the specified error [message].
  const InvalidScreen({
    super.key,
    required this.message,
  });

  /// The error message to display.
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A basic app bar with the app name
      appBar: AppBar(
        title: const Text(strings.appName),
      ),

      // The body of the screen displays the error message
      body: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),

      // The floating action button takes the user back to the home screen
      floatingActionButton: Link(
        uri: Uri.parse('/'),
        builder: (BuildContext context, FollowLink? followLink) => FloatingActionButton(
          tooltip: strings.goHome,
          onPressed: followLink,
          child: const Icon(Icons.home),
        ),
      ),
    );
  }
}
