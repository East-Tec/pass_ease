// Copyright (c) East-Tec <https://www.east-tec.com/>. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import 'package:flutter/material.dart';

import '../common/strings.dart' as strings;
import '../utils/color_utils.dart' as color_utils;

/// Displays a dialog that allows the user to select a color using RGB sliders.
Future<Color?> showColorPickerDialog(
  BuildContext context, {
  required Color initialColor,
}) async {
  return showDialog<Color>(
    context: context,
    builder: (BuildContext context) {
      // The selected color is initially the initial color
      Color selectedColor = initialColor;
      int red = selectedColor.red;
      int green = selectedColor.green;
      int blue = selectedColor.blue;

      // Build the alert dialog using a StatefulBuilder so that we can update the selected color
      return StatefulBuilder(
        builder: (context, setState) {
          /// Updates the selected color using a callback that changes the appropriate RGB component.
          void updateComponent(int value, Function(int) change) {
            change(value);
            selectedColor = Color.fromARGB(255, red.toInt(), green.toInt(), blue.toInt());
            setState(() {});
          }

          // Build the alert dialog
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            contentPadding: const EdgeInsets.symmetric(vertical: 24.0),

            // The title of the dialog is filled with the selected color and displays the hex code
            title: _ColorTitle(color: selectedColor),

            // The content of the dialog is a column of the three RGB sliders
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Add the red slider
                _RGBSlider(
                  color: const Color(0xFFFF0000),
                  value: red,
                  onChanged: (value) => updateComponent(value, (value) => red = value),
                ),

                // Add the green slider
                _RGBSlider(
                  color: const Color(0xFF00FF00),
                  value: green,
                  onChanged: (value) => updateComponent(value, (value) => green = value),
                ),

                // Add the blue slider
                _RGBSlider(
                  color: const Color(0xFF0000FF),
                  value: blue,
                  onChanged: (value) => updateComponent(value, (value) => blue = value),
                ),
              ],
            ),
            actions: [
              // Add the cancel button that closes the dialog without returning a color (null)
              TextButton(
                child: const Text(strings.cancelButtonTitle),
                onPressed: () => Navigator.of(context).pop(),
              ),

              // Add the OK button that closes the dialog and returns the selected color
              TextButton(
                child: const Text(strings.okButtonTitle),
                onPressed: () => Navigator.of(context).pop(selectedColor),
              ),
            ],
          );
        },
      );
    },
  );
}

/// A simple slider widget that the user can use to select the value of an RGB component.
class _RGBSlider extends StatelessWidget {
  /// Creates a new [_RGBSlider] widget.
  const _RGBSlider({
    // ignore: unused_element
    super.key,
    required this.color,
    required this.value,
    this.onChanged,
  });

  /// The RGB component color of this slider (red, green or blue).
  final Color color;

  /// The current value of this slider.
  final int value;

  /// The callback that is called when the value of this slider changes.
  final Function(int)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value.toDouble(),
      min: 0,
      max: 255,
      divisions: 255,
      activeColor: color,
      onChanged: (value) {
        onChanged?.call(value.toInt());
      },
    );
  }
}

/// A simple color title widget that displays the color code, using the color as the background.
class _ColorTitle extends StatelessWidget {
  /// Creates a new [_ColorTitle] widget.
  const _ColorTitle({
    // ignore: unused_element
    super.key,
    required this.color,
  });

  /// The color to display in the title.
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      // The title is filled with the color and the top corners are rounded to match the rounded
      // bottom corners of the dialog (Material Design 3)
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28.0),
          topRight: Radius.circular(28.0),
        ),
      ),

      // color: color,
      padding: const EdgeInsets.all(16),
      child: Text(
        color_utils.toHexString(color),
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: color_utils.contrastColor(color)),
      ),
    );
  }
}
