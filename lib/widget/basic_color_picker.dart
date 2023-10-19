// Copyright (c) East-Tec <https://www.east-tec.com/>. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import 'package:flutter/material.dart';

import '../utils/color_utils.dart' as color_utils;
import 'rgb_sliders_dialog.dart';

/// A basic color picker widget that allows the user to choose a color from a list of colors.
///
/// The last color in the list is the custom color. The user can edit the custom color by tapping
/// on the edit button.
class BasicColorPicker extends StatefulWidget {
  const BasicColorPicker({
    super.key,
    this.title,
    required this.colors,
    this.selectedColorIndex = 0,
    this.editCustomColorTooltip = 'Edit custom color',
    this.onColorIndexChanged,
    this.onCustomColorChanged,
  });

  /// The title of this basic color picker.
  final Widget? title;

  /// The list of colors to choose from.
  final List<Color> colors;

  /// The index of the selected color in the [colors] list.
  final int selectedColorIndex;

  /// The tooltip of the edit custom color button.
  final String editCustomColorTooltip;

  /// Called when the selected color index changes.
  final void Function(int)? onColorIndexChanged;

  /// Called when the custom color changes.
  final void Function(Color)? onCustomColorChanged;

  @override
  State<BasicColorPicker> createState() => _BasicColorPickerState();
}

class _BasicColorPickerState extends State<BasicColorPicker> {
  /// The index of the selected color in the [colors] list.
  late int _selectedColorIndex;

  /// Overrides the default [initState] method to initialize the selected color index.
  @override
  void initState() {
    super.initState();
    _selectedColorIndex = widget.selectedColorIndex;
  }

  /// Changes the selected color index and calls the [onColorIndexChanged] callback.
  void _selectColor(int index) {
    setState(() => _selectedColorIndex = index);
    widget.onColorIndexChanged?.call(_selectedColorIndex);
  }

  /// Shows a color picker dialog and updates the custom color (the last color in the list).
  Future<void> _editCustomColor() async {
    final Color? color = await showColorPickerDialog(
      context,
      initialColor: widget.colors.last,
    );

    // If the user typed and selected a valid color, update the custom color and call the callback
    if (color != null) {
      // Update the custom color
      widget.colors.last = color;
      widget.onCustomColorChanged?.call(color);

      // Select the custom color
      _selectColor(widget.colors.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: widget.title,

      // The trailing widget is a row of color options and the edit button for the custom color
      trailing: Wrap(
        // spacing: 8.0,
        runSpacing: 8.0,
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // Add a color option for each color in the list
          for (final (index, color) in widget.colors.indexed)
            _ColorOption(
              color: color,
              isSelected: index == _selectedColorIndex,
              onTap: () => _selectColor(index),
            ),

          // Add the edit button for the custom color (the last color in the list)
          // const SizedBox(width: 8.0),
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: widget.editCustomColorTooltip,
            onPressed: _editCustomColor,
          ),
        ],
      ),
    );
  }
}

/// A simple round color option widget that the user can tap to select the color.
class _ColorOption extends StatelessWidget {
  const _ColorOption({
    // ignore: unused_element
    super.key,
    required this.color,
    this.isSelected = false,
    this.onTap,
  });

  /// The color of this color option.
  final Color color;

  /// Whether this color option is selected.
  final bool isSelected;

  /// Called when the user taps on this color option.
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final Color contrastColor = color_utils.contrastColor(color);
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(side: BorderSide(color: Colors.white, width: 2.0)),
        padding: const EdgeInsets.all(20.0),
        backgroundColor: color,
        foregroundColor: contrastColor,
      ),
      child: Icon(isSelected ? Icons.check : null, color: contrastColor, size: 16.0),
    );
  }
}
