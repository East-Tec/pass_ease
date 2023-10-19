// Copyright (c) East-Tec <https://www.east-tec.com/>. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

/// The minimum text size.
const double minTextSize = 16.0;

/// The maximum text size.
const double maxTextSize = 256.0;

/// The default text size.
const double defaultTextSize = 96.0;

/// The step used for increasing or decreasing the text size.
// const double textSizeStep = 16.0;
const double textSizeStep = 8.0;

/// The list of possible chunk lengths.
const List<int> chunkLengths = <int>[2, 3, 4, 5, 6, 7, 8];

/// The default chunk length.
const int defaultChunkLength = 4;

// -----------------------------------------------------------------------------------------------
// textSize setting
// -----------------------------------------------------------------------------------------------

const String _textSizeKey = 'textSize';

/// The current value of the textSize setting.
double? _textSize;
double? get textSize => _textSize;

/// Sets the value of the textSize setting and saves it to shared preferences.
set textSize(double? newValue) {
  if (newValue == _textSize) return;

  _textSize = newValue;
  SharedPreferences.getInstance().then((SharedPreferences preferences) {
    if (_textSize != null) preferences.setDouble(_textSizeKey, _textSize!);
  });
}

/// Returns a good enough text (font) size to fit a normal password on the screen.
///
/// The screen has the given [screenWidth] and total horizontal [padding]. The returned font size
/// is a multiple of [textSizeStep].
double textSizeForScreenWidth(double screenWidth, {double padding = 64}) {
  const int goodEnoughDivisor = 10;
  final double maxFontSize = (screenWidth - padding) / goodEnoughDivisor;
  final double fontSize = ((maxFontSize / textSizeStep).floor() * textSizeStep);
  return fontSize;
}

// -----------------------------------------------------------------------------------------------
// chunksOn setting
// -----------------------------------------------------------------------------------------------

const String _chunksOnKey = 'chunksOn';

/// The current value of the chunksOn setting.
bool _chunksOn = false;
bool get chunksOn => _chunksOn;

/// Sets the value of the chunksOn setting and saves it to shared preferences.
set chunksOn(bool newValue) {
  if (newValue == _chunksOn) return;

  _chunksOn = newValue;
  SharedPreferences.getInstance().then((SharedPreferences preferences) {
    preferences.setBool(_chunksOnKey, _chunksOn);
  });
}

// -----------------------------------------------------------------------------------------------
// chunkLength setting
// -----------------------------------------------------------------------------------------------

const String _chunkLengthKey = 'chunkLength';

/// The current value of the chunkLength setting.
int _chunkLength = defaultChunkLength;
int get chunkLength => _chunkLength;

/// Sets the value of the chunkLength setting and saves it to shared preferences.
set chunkLength(int newValue) {
  if (newValue == _chunkLength) return;

  _chunkLength = newValue;
  SharedPreferences.getInstance().then((SharedPreferences preferences) {
    preferences.setInt(_chunkLengthKey, _chunkLength);
  });
}

/// Returns the given chunk length if it is valid, otherwise returns the default chunk length.
int validateChunkLength(int value) {
  return chunkLengths.contains(value) ? value : defaultChunkLength;
}

// -----------------------------------------------------------------------------------------------
// monospacedFont setting
// -----------------------------------------------------------------------------------------------

const String _monospacedFontKey = 'monospacedFont';

/// The current value of the monospacedFont setting.
bool _monospacedFont = false;
bool get monospacedFont => _monospacedFont;

/// Sets the value of the monospacedFont setting and saves it to shared preferences.
set monospacedFont(bool newValue) {
  if (newValue == _monospacedFont) return;

  _monospacedFont = newValue;
  SharedPreferences.getInstance().then((SharedPreferences preferences) {
    preferences.setBool(_monospacedFontKey, _monospacedFont);
  });
}

// -----------------------------------------------------------------------------------------------
// backgroundColorIndex setting
// -----------------------------------------------------------------------------------------------

const String _backgroundColorIndexKey = 'backgroundColorIndex';

/// The current value of the backgroundColorIndex setting.
int _backgroundColorIndex = 0;
int get backgroundColorIndex => _backgroundColorIndex;

/// Sets the value of the backgroundColorIndex setting and saves it to shared preferences.
set backgroundColorIndex(int newValue) {
  if (newValue == _backgroundColorIndex) return;

  _backgroundColorIndex = newValue;
  SharedPreferences.getInstance().then((SharedPreferences preferences) {
    preferences.setInt(_backgroundColorIndexKey, _backgroundColorIndex);
  });
}

// -----------------------------------------------------------------------------------------------
// customColor setting
// -----------------------------------------------------------------------------------------------

const String _customColorKey = 'customColor';

/// The current value of the customColor setting.
Color _customColor = const Color(0xFFEDD1B0);
Color get customColor => _customColor;

/// Sets the value of the customColor setting and saves it to shared preferences.
set customColor(Color newValue) {
  if (newValue == _customColor) return;

  _customColor = newValue;
  SharedPreferences.getInstance().then((SharedPreferences preferences) {
    preferences.setInt(_customColorKey, _customColor.value);
  });
}

/// Gets the background color based on the current values of the backgroundColorIndex and
/// customColor settings.
Color getBackgroundColor() => switch (backgroundColorIndex) {
      0 => Colors.white,
      1 => Colors.black,
      2 => _customColor,
      _ => Colors.white, // Default value
    };

// -----------------------------------------------------------------------------------------------
// Settings loading
// -----------------------------------------------------------------------------------------------

/// Loads the app settings from shared preferences.
Future<void> load() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  _textSize = prefs.getDouble(_textSizeKey);
  _chunksOn = prefs.getBool(_chunksOnKey) ?? _chunksOn;
  _chunkLength = prefs.getInt(_chunkLengthKey) ?? _chunkLength;
  _monospacedFont = prefs.getBool(_monospacedFontKey) ?? _monospacedFont;
  _backgroundColorIndex = prefs.getInt(_backgroundColorIndexKey) ?? _backgroundColorIndex;
  _customColor = Color(prefs.getInt(_customColorKey) ?? _customColor.value);
}
