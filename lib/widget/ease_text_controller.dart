// Copyright (c) East-Tec <https://www.east-tec.com/>. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import 'dart:math';
import 'package:flutter/material.dart';

/// A [TextEditingController] that allows for the text to be segmented into chunks for easier reading.
class EaseTextController extends TextEditingController {
  /// Creates a new [EaseTextController].
  EaseTextController({
    String? text,
    this.chunksOn = true,
    this.chunkLength = 4,
  }) : super(text: text);

  /// Whether the eased text should be segmented into chunks for easier reading.
  final bool chunksOn;

  /// The length of each chunk of eased text.
  final int chunkLength;

  /// Builds a [TextSpan] that displays the given text with the specified style, and with the
  /// character at the given position highlighted.
  TextSpan _textWithHightlightChar(String text, int highlightCharPos, TextStyle? style) {
    // If the highlight character position is invalid, just return the text as is.
    if (highlightCharPos < 0 || highlightCharPos >= text.length) {
      return TextSpan(style: style, text: text);
    }

    return TextSpan(
      style: style,
      children: <TextSpan>[
        TextSpan(text: text.substring(0, highlightCharPos)),

        // Display the highlighted character with a faded highlight background.
        TextSpan(
          style: style?.copyWith(backgroundColor: style.color?.withOpacity(0.25)),
          text: text.substring(highlightCharPos, highlightCharPos + 1),
        ),

        TextSpan(text: text.substring(highlightCharPos + 1)),
      ],
    );
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    // If the text is empty, just return the default text span.
    if (text.isEmpty) {
      return super.buildTextSpan(context: context, style: style, withComposing: withComposing);
    }

    // Get the index of the current character (the character before the cursor position)
    int currentCharIndex = selection.baseOffset - 1;

    // If chunks are not on, just return the text with the provided style and the current character highlighted
    if (!chunksOn) {
      return _textWithHightlightChar(text, currentCharIndex, style);
    }

    // Get the text before the start of the current chunk (if any).
    final int currentChunkStart = max((currentCharIndex) - ((currentCharIndex) % chunkLength), 0);
    final String textBeforeCurrentChunk = text.substring(0, currentChunkStart);

    // Get the text of the current chunk (if any).
    final int currentChunkEnd = min(currentChunkStart + chunkLength, text.length);
    final String currentChunkText = text.substring(currentChunkStart, currentChunkEnd);

    // Get the text after the end of the current chunk (if any).
    final String textAfterCurrentChunk = text.substring(currentChunkEnd);

    // Create and return the text spans.
    return TextSpan(
      style: style,
      children: <TextSpan>[
        // If there is text before the current chunk, display it with the faded style.
        if (textBeforeCurrentChunk.isNotEmpty)
          TextSpan(
            text: textBeforeCurrentChunk,
            style: style?.copyWith(color: style.color?.withOpacity(0.25)),
          ),

        // If there is text in the current chunk, display it with the normal style.
        if (currentChunkText.isNotEmpty)
          _textWithHightlightChar(currentChunkText, currentCharIndex - currentChunkStart, style),

        // If there is text after the current chunk, display it with the faded style.
        if (textAfterCurrentChunk.isNotEmpty)
          TextSpan(
            text: textAfterCurrentChunk,
            style: style?.copyWith(color: style.color?.withOpacity(0.25)),
          ),
      ],
    );
  }
}
