// Copyright (c) East-Tec <https://www.east-tec.com/>. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

/// Various utility functions.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:url_launcher/url_launcher.dart';

import '../common/strings.dart' as strings;

/// Shows a [SnackBar] with the specified [content] widget at the bottom of the specified scaffold.
void showSnackBar(
  ScaffoldMessengerState messengerState,
  String message, {
  TextAlign textAlign = TextAlign.center,
}) {
  final SnackBar snackBar = SnackBar(content: Text(message, textAlign: textAlign));
  messengerState
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}

/// Stores the given text on the clipboard, and shows a [SnackBar] on success or failure.
Future<void> copyToClipboard(BuildContext context, String value) async {
  ScaffoldMessengerState messengerState = ScaffoldMessenger.of(context);
  try {
    await Clipboard.setData(ClipboardData(text: value));
    showSnackBar(messengerState, strings.copiedSnackbar);
  } catch (error) {
    showSnackBar(messengerState, '${strings.copyFailSnackbar} $error');
  }
}

/// Retrieves the text from the clipboard, and shows a [SnackBar] on failure.
Future<String?> pasteFromClipboard(BuildContext context) async {
  ScaffoldMessengerState messengerState = ScaffoldMessenger.of(context);

  // Get the data from the clipboard
  final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);

  // If there is no valid data on the clipboard, show a warning snackbar and return null
  if (data == null || data.text == null || data.text!.isEmpty) {
    showSnackBar(messengerState, strings.pasteFail);
    return null;
  }

  return data.text;
}

/// Launches the specified [URL] in the mobile platform, using the default external application.
///
/// Shows an error [SnackBar] if there is no support for launching the URL.
Future<void> launchUrlExternal(BuildContext context, String url) async {
  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

  // TODO: Start reusing this code when launchUrl is fixed and stops returning false for all URLs!
  // ScaffoldMessengerState messengerState = ScaffoldMessenger.of(context);
  // if (!(await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication))) {
  //   showSnackBar(messengerState, '${strings.openFail} $url');
  // }
}
