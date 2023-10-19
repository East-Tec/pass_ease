// Copyright (c) East-Tec <https://www.east-tec.com/>. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import 'dart:math';

import 'package:flutter/material.dart';

import '../../common/urls.dart' as urls;
import '../../utils/utils.dart' as utils;
import '../common/routes.dart' as routes;
import '../common/settings.dart' as settings;
import '../common/strings.dart' as strings;
import '../data/ascii.dart' as ascii;
import '../utils/color_utils.dart' as color_utils;
import '../utils/utils.dart';
import '../widget/app_drawer.dart';
import '../widget/east_tec_badge.dart';
import '../widget/ease_text_controller.dart';
import '../widget/ease_text_field.dart';

/// The PassEase screen widget.
///
/// This is the home screen of the app. It allows the user to enter a password and see it in a more
/// readable way.
class PassEaseScreen extends StatefulWidget {
  /// Creates a PassEase screen widget.
  const PassEaseScreen({super.key});

  @override
  State<PassEaseScreen> createState() => _PassEaseScreenState();
}

/// The state of the PassEase screen widget.
class _PassEaseScreenState extends State<PassEaseScreen> {
  /// The current password typed or pasted by the user.
  String? _currentPassword;

  /// The current character (the character before the cursor position) that is highlighted.
  String? _currentChar;

  /// The controller of the ease text field.
  late EaseTextController _controller;

  /// Whether the lock mode is enabled (the password is obscured).
  bool _lockMode = false;

  /// Displays an information snackbar about the given character.
  void _showCharInfo(String char) {
    final String info = ascii.printableAsciiDescriptions[char] ?? 'Character $char';
    showSnackBar(ScaffoldMessenger.of(context), info);
  }

  /// Toggles the lock mode. When the lock mode is enabled, the password is obscured.
  void _toggleLockMode() {
    setState(() {
      _lockMode = !_lockMode;
    });
  }

  /// Performs the actions of the app bar.
  void _onAction(_AppBarActions action) {
    switch (action) {
      // Increase the text size with the text size step
      case _AppBarActions.textIncrease:
        setState(() {
          settings.textSize = settings.textSize == null
              ? settings.defaultTextSize
              : min(settings.textSize! + settings.textSizeStep, settings.maxTextSize);
        });
        break;

      // Decrease the text size with the text size step
      case _AppBarActions.textDecrease:
        setState(() {
          settings.textSize = settings.textSize == null
              ? settings.defaultTextSize
              : max(settings.textSize! - settings.textSizeStep, settings.minTextSize);
        });
        break;

      // Show the current character help snackbar
      case _AppBarActions.currentChar:
        if (_currentChar != null) _showCharInfo(_currentChar!);
        break;

      // Paste and replace the current password with the text from the clipboard
      case _AppBarActions.paste:
        utils.pasteFromClipboard(context).then((String? value) {
          if (value != null) {
            // Set the current password to the pasted value and move the cursor to the end of the text
            _controller.text = _currentPassword = value;
            _controller.selection = TextSelection.collapsed(offset: value.length);
          }
        });
        break;

      // Copy the current password to the clipboard
      case _AppBarActions.copy:
        if (_currentPassword != null) utils.copyToClipboard(context, _currentPassword!);
        break;

      // Clear the current password
      case _AppBarActions.clear:
        _controller.text = _currentPassword = '';
        break;
    }
  }

  /// Starts a specific functionality of the app when the user taps a drawer [item].
  void _onDrawerItemTap(AppDrawerItems item) {
    switch (item) {
      // Launch the external Keep It Free url
      case AppDrawerItems.keepItFree:
        utils.launchUrlExternal(context, urls.tryOurProductsUrl);
        break;

      // Navigate to the Settings screen, then reload the state to reflect the new settings
      case AppDrawerItems.settings:
        routes.gotoSettingsRoute(context).then((_) => setState(() {}));
        break;

      // Launch the external Online Help url
      case AppDrawerItems.help:
        utils.launchUrlExternal(context, urls.help);
        break;

      // Launch the external PassEase Safety url
      case AppDrawerItems.safety:
        utils.launchUrlExternal(context, urls.safety);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // Get the current background color and the contrast color to use for the password text field and more
    final Color backgroundColor = settings.getBackgroundColor();
    final Color contrastColor = color_utils.contrastColor(backgroundColor);

    // If the textSize setting is null, set it to a good enough value for the current screen width
    settings.textSize ??= settings.textSizeForScreenWidth(screenWidth, padding: 64.0);

    return Scaffold(
      backgroundColor: backgroundColor,

      // The app bar with the common operations
      appBar: _AppBar(
        hasPassword: _currentPassword != null && _currentPassword!.isNotEmpty,
        // Show the current character help button only if there is a current character and the lock mode is off
        hasCurrentChar: _currentChar != null && !_lockMode,
        screenWidth: screenWidth,
        onAction: _onAction,
      ),

      // The app drawer with the main screens and external links of the app
      drawer: AppDrawer(
        onItemTap: _onDrawerItemTap,
      ),

      // The body of the screen with the ease text field in the center
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          // The ease text field that displays the password in a more readable way
          // This is the main widget of this screen and of the whole app!
          child: EaseTextField(
            initialValue: _currentPassword,
            fontSize: settings.textSize,
            foregroundColor: contrastColor,
            obscureText: _lockMode,
            chunksOn: settings.chunksOn,
            chunkLength: settings.chunkLength,
            monospacedFont: settings.monospacedFont,
            hintText: strings.textFieldHint,
            onControllerCreated: (EaseTextController controller) => _controller = controller,
            onChanged: (String value) => setState(() {
              _currentPassword = value;
            }),
            onCurrentCharChanged: (String? currentChar) => setState(() {
              _currentChar = currentChar;
            }),
          ),
        ),
      ),

      // The floating action button that toggles the lock mode
      floatingActionButton: FloatingActionButton(
        backgroundColor: contrastColor,
        foregroundColor: color_utils.contrastColor(contrastColor),
        tooltip: _lockMode ? strings.lockModeOffTooltip : strings.lockModeOnTooltip,
        onPressed: _toggleLockMode,
        child: Icon(_lockMode ? Icons.lock_open : Icons.lock),
      ),
    );
  }
}

/// Enum that defines the actions of the app bar.
enum _AppBarActions {
  paste,
  textIncrease,
  textDecrease,
  currentChar,
  copy,
  clear,
  // colorInfo,
}

/// The app bar of the PassEase screen.
class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    Key? key,
    this.hasPassword = false,
    this.hasCurrentChar = false,
    required this.screenWidth,
    required this.onAction,
  }) : super(key: key);

  /// Whether the user has entered a password.
  final bool hasPassword;

  /// Whether the current character help button should be displayed.
  final bool hasCurrentChar;

  /// The width of the screen.
  final double screenWidth;

  /// The callback that is called when an app bar action is pressed.
  final Function(_AppBarActions action) onAction;

  @override
  Widget build(BuildContext context) {
    // The title row of the app bar with the app title and the East-Tec badge
    const Widget titleRow = Row(
      children: <Widget>[
        Text(strings.homeScreenTitle),
        Spacer(),
        EastTecBadge(),
        Spacer(),
      ],
    );

    return AppBar(
      // The title row is displayed only on wide enough screens, so that the action buttons don't overflow
      title: screenWidth >= 390 ? titleRow : null,

      // The common operations displayed in this app bar
      actions: <Widget>[
        // The paste button
        IconButton(
          icon: const Icon(Icons.paste),
          tooltip: strings.pasteTooltip,
          onPressed: () => onAction(_AppBarActions.paste),
        ),

        // The button to increase the text size
        IconButton(
          icon: const Icon(Icons.text_increase),
          tooltip: strings.textIncreaseTooltip,
          onPressed: () => onAction(_AppBarActions.textIncrease),
        ),

        // The button to decrease the text size
        IconButton(
          icon: const Icon(Icons.text_decrease),
          tooltip: strings.textDecreaseTooltip,
          onPressed: () => onAction(_AppBarActions.textDecrease),
        ),

        // The current character help button.
        IconButton(
          icon: const Icon(Icons.help_outline),
          tooltip: strings.currentCharTooltip,
          onPressed: hasCurrentChar ? () => onAction(_AppBarActions.currentChar) : null,
        ),

        // The popup menu button with more actions
        PopupMenuButton<_AppBarActions>(
          onSelected: onAction,
          itemBuilder: (BuildContext context) => <PopupMenuEntry<_AppBarActions>>[
            // The copy action item
            PopupMenuItem<_AppBarActions>(
              value: _AppBarActions.copy,
              enabled: hasPassword,
              child: const Text(strings.copyAction),
            ),

            // The clear action item
            PopupMenuItem<_AppBarActions>(
              value: _AppBarActions.clear,
              enabled: hasPassword,
              child: const Text(strings.clearAction),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
