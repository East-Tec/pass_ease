// Copyright (c) East-Tec <https://www.east-tec.com/>. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import 'package:flutter/material.dart';

import 'ease_text_controller.dart';

/// A text field that displays the text in an eased format.
///
/// The font size of the text is automatically scaled to fit the width of the text field. The text
/// can also be segmented into chunks for easier reading.
class EaseTextField extends StatefulWidget {
  const EaseTextField({
    super.key,
    this.initialValue,
    this.fontSize,
    required this.foregroundColor,
    this.obscureText = false,
    this.chunksOn = true,
    this.chunkLength = 4,
    this.monospacedFont = false,
    required this.hintText,
    this.onControllerCreated,
    this.onChanged,
    this.onCurrentCharChanged,
  });

  /// The initial value of the text field.
  final String? initialValue;

  /// The font size of the text field.
  final double? fontSize;

  /// The foreground color of the text field.
  ///
  /// This is used for the text color, the border color, and the cursor color.
  final Color foregroundColor;

  /// Whether the password should be obscured.
  final bool obscureText;

  /// Whether the eased text should be segmented into chunks for easier reading.
  final bool chunksOn;

  /// The length of each chunk of eased text.
  final int chunkLength;

  /// Whether the text field should use a monospaced font.
  final bool monospacedFont;

  /// The hint text to display when the text field is empty.
  final String hintText;

  /// Called when the text field's controller is created.
  final ValueChanged<EaseTextController>? onControllerCreated;

  /// Called when the text field's value changes.
  final ValueChanged<String>? onChanged;

  /// Called when the current character (the character before the cursor) changes.
  final ValueChanged<String?>? onCurrentCharChanged;

  @override
  State<EaseTextField> createState() => _EaseTextFieldState();
}

class _EaseTextFieldState extends State<EaseTextField> {
  // The text field controller.
  late EaseTextController _controller;

  /// The current character (the character before the cursor)
  String? _currentChar;

  /// Overrides the default [initState] method to create the text field controller.
  @override
  void initState() {
    super.initState();
    _createController();
  }

  /// Overrides the default [didUpdateWidget] method to update the text field controller, if needed.
  @override
  void didUpdateWidget(covariant EaseTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the chunks on or chunk length settings changed, update the controller.
    if (widget.chunksOn != oldWidget.chunksOn || widget.chunkLength != oldWidget.chunkLength) {
      _controller.dispose(); // Dispose the old controller.
      _createController(); // Create the new controller
    }
  }

  /// Overrides the default [dispose] method to dispose the text field controller.
  @override
  void dispose() {
    _controller.removeListener(_textFieldListener);
    _controller.dispose();
    super.dispose();
  }

  /// Update and notify the widget when the value of the current character changes.
  void _textFieldListener() {
    // Get the current character (the character before the cursor).
    final String? newCurrentChar = _controller.selection.baseOffset > 0 &&
            _controller.text.isNotEmpty &&
            _controller.text.length > _controller.selection.baseOffset - 1
        ? _controller.text[_controller.selection.baseOffset - 1]
        : null;

    // If the current character changed, call the onCurrentCharChanged callback (if any).
    if (newCurrentChar != _currentChar) {
      _currentChar = newCurrentChar;
      widget.onCurrentCharChanged?.call(_currentChar);
    }
  }

  /// Creates the text controller for this text field with the current settings and initial value.
  void _createController() {
    _controller = EaseTextController(
      text: widget.initialValue,
      chunksOn: widget.chunksOn,
      chunkLength: widget.chunkLength,
    )..addListener(_textFieldListener);
    widget.onControllerCreated?.call(_controller);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      fontFamily: widget.monospacedFont ? 'RobotoMono' : null,
      fontSize: widget.fontSize,
      color: widget.foregroundColor,
    );

    return TextField(
      controller: _controller,

      // The ease text field is usually the main widget on the screen, so it should be focused
      autofocus: true,

      // Prevent auto-correct when typing passwords.
      // Bug: https://github.com/flutter/flutter/issues/22828
      keyboardType: TextInputType.visiblePassword,

      obscureText: widget.obscureText,

      // Text style, color and decoration
      style: textStyle,
      textAlign: TextAlign.center,
      cursorColor: widget.foregroundColor,
      decoration: InputDecoration.collapsed(
        hintText: widget.hintText,
        hintStyle: textStyle.copyWith(color: widget.foregroundColor.withOpacity(0.25)),
      ),

      onChanged: widget.onChanged,
    );
  }
}
