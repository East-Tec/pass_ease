// Copyright (c) East-Tec <https://www.east-tec.com/>. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import 'package:flutter/material.dart';

import '../common/settings.dart' as settings;
import '../common/strings.dart' as strings;
import '../widget/basic_color_picker.dart';

/// The settings screen widget.
///
/// This screen allows the user to change the app settings.
class SettingsScreen extends StatefulWidget {
  /// Creates a new settings screen widget.
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

/// The state of the settings screen widget.
class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    // A vertical spacer widget to separate the settings.
    const SizedBox vSpacer = SizedBox(height: 16.0);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      // A simple app bar with just a title.
      appBar: AppBar(
        title: const Text(strings.settingsScreenTitle),
      ),

      body: ListView(
        children: <Widget>[
          vSpacer,

          // Add the chunks setting, including the enabled switch and the chunk length dropdown
          _buildChunksSetting(),
          vSpacer,

          // Add the text size setting
          _buildTextSizeSetting(),
          vSpacer,

          // Add the monospaced font setting
          _buildMonospacedFontSetting(),
          vSpacer,

          // Add the background color setting
          _buildBackgroundColorSetting(),
        ],
      ),
    );
  }

  /// Builds the text size setting with a slider.
  Widget _buildTextSizeSetting() {
    return ListTile(
      title: const Text(strings.textSizeSetting),
      subtitle: Text('${settings.textSize?.toStringAsFixed(0)}'),
      trailing: FittedBox(
        child: Slider(
          value: settings.textSize ?? settings.defaultTextSize,
          min: settings.minTextSize,
          max: settings.maxTextSize,
          divisions: (settings.maxTextSize - settings.minTextSize).toInt(),
          onChanged: (double value) => setState(() => settings.textSize = value.roundToDouble()),
        ),
      ),
    );
  }

  /// Builds the chunks setting, including the enabled switch and the chunk length dropdown.
  Widget _buildChunksSetting() {
    /// Converts a chunk length integer [value] to a [DropdownMenuItem].
    DropdownMenuItem<int> chunkLength2Item(int value) => DropdownMenuItem(
          value: value,
          child: Text(value.toString()),
        );

    return SwitchListTile(
      value: settings.chunksOn,
      title: Row(
        children: [
          const Text(strings.chunksSetting),
          const SizedBox(width: 8.0),
          DropdownButton(
            dropdownColor: Theme.of(context).colorScheme.surface,
            items: settings.chunkLengths.map(chunkLength2Item).toList(),
            value: settings.validateChunkLength(settings.chunkLength),
            // Only enable the dropdown if the chunks setting is on
            onChanged: settings.chunksOn
                ? (int? value) => setState(() => settings.chunkLength = value!)
                : null,
          ),
        ],
      ),
      onChanged: (bool value) => setState(() => settings.chunksOn = value),
    );
  }

  /// Builds the monospaced font setting.
  Widget _buildMonospacedFontSetting() {
    return SwitchListTile(
      value: settings.monospacedFont,
      title: const Text(strings.monospacedFontSetting),
      onChanged: (bool value) => setState(() => settings.monospacedFont = value),
    );
  }

  /// Builds the background color setting.
  Widget _buildBackgroundColorSetting() {
    return BasicColorPicker(
      title: const Text(strings.backgroundColorSetting),
      colors: [Colors.white, Colors.black, settings.customColor],
      selectedColorIndex: settings.backgroundColorIndex,
      editCustomColorTooltip: strings.editCustomColorTooltip,
      onColorIndexChanged: (int index) => setState(() => settings.backgroundColorIndex = index),
      onCustomColorChanged: (Color color) => setState(() => settings.customColor = color),
    );
  }
}
