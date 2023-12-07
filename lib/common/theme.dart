// Copyright (c) East-Tec <https://www.east-tec.com/>. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

/// The light and dark themes of the app.
library;

import 'package:flutter/material.dart';

// The East-Tec colors used in the app.
const Color _eastTecBlue = Color(0xFF00A4F9);
const Color _eastTecGrey = Color(0xFF4A4B4B);
const Color _eastTecGreyDarker = Color(0xFF3A3B3B);

/// Defines the default visual properties for this app's material widgets.
///
/// Currently the light and dark themes are identical, so the [brightness] parameter is ignored.
ThemeData appTheme(Brightness brightness) {
  return ThemeData(
    // The app bars have a black background and white text
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),

    colorScheme: const ColorScheme.dark(
      // The primary color(s) are East-Tec Blue and they are used for the switches and sliders
      primary: _eastTecBlue,
      onPrimary: Colors.white,
      primaryContainer: _eastTecBlue,

      // Surface colors are used for the background of the Drawer, the Settings screen, and the dialogs
      surface: _eastTecGrey,
      surfaceTint: Colors.white,
    ),

    // By default the FABs have a black background and white text
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),

    // Sliders have a dark grey background
    sliderTheme: const SliderThemeData(
      inactiveTrackColor: _eastTecGreyDarker,
    ),

    // The snack bars have a dark grey background and white text
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: _eastTecGreyDarker,
      contentTextStyle: TextStyle(color: Colors.white),
      actionTextColor: _eastTecBlue,
    ),

    // The selection & cursor colors for text fields are East-Tec Blue
    // textSelectionTheme: const TextSelectionThemeData(
    //   cursorColor: _eastTecBlue,
    //   selectionColor: _eastTecBlue,
    //   selectionHandleColor: _eastTecBlue,
    // ),
  );
}
