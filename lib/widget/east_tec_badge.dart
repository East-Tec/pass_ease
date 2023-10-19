// Copyright (c) East-Tec <https://www.east-tec.com/>. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import 'package:flutter/material.dart';

import '../../utils/utils.dart' as utils;
import '../common/custom_icons.dart' as custom_icons;
import '../common/strings.dart' as strings;
import '../common/urls.dart' as app_urls;

/// A badge that displays the East-Tec logo and the "Brought to you by" texts.
///
/// The badge is clickable and opens the East-Tec website in the default browser.
class EastTecBadge extends StatelessWidget {
  /// Creates a new [EastTecBadge].
  const EastTecBadge({super.key});

  /// Opens the East-Tec website in the default browser.
  void _onTap(BuildContext context) {
    utils.launchUrlExternal(context, app_urls.eastTecBadgeUrl);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    // The badge is displayed only on wide enough screens
    if (width < 576) {
      return const SizedBox.shrink();
    }

    bool isWide = width >= 768;
    final Color backgroundColor = Theme.of(context).colorScheme.secondary;
    final Color foregroundColor = Theme.of(context).colorScheme.onSecondary;

    // The badge can be (and should be) clickable.
    return InkWell(
      onTap: () => _onTap(context),
      child: Ink(
        // Padding and background color
        padding: EdgeInsets.symmetric(horizontal: isWide ? 20 : 12, vertical: 12),
        color: backgroundColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // The East-Tec logomark
            Icon(
              custom_icons.eastTecLogoMark,
              color: foregroundColor,
              size: 32.0,
            ),

            const SizedBox(width: 8),

            // The "Brought to you by" texts
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  isWide ? strings.broughtToYouByWide : strings.broughtToYouBy,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: foregroundColor),
                ),
                Text(
                  isWide ? strings.eastTecWide : strings.eastTec,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: foregroundColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
