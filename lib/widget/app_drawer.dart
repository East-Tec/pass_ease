// Copyright (c) East-Tec <https://www.east-tec.com/>. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import 'package:flutter/material.dart';

import '../common/strings.dart' as strings;

/// The items that appear in the app drawer.
enum AppDrawerItems {
  keepItFree,
  settings,
  help,
  safety,
}

/// The app drawer.
class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    this.onItemTap,
  });

  /// The callback that is called when a drawer item is tapped.
  final void Function(AppDrawerItems)? onItemTap;

  /// Handles the tap on a drawer item by closing the drawer and calling the callback.
  void _onItemTap(BuildContext context, AppDrawerItems item) {
    Navigator.pop(context);
    onItemTap?.call(item);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          // The header
          _AppDrawerHeader(
            onTryOurProductsTap: () => _onItemTap(context, AppDrawerItems.keepItFree),
          ),

          // The Try Our Products drawer item
          ListTile(
            tileColor: Theme.of(context).colorScheme.secondary,
            leading: const Icon(Icons.free_breakfast),
            title: const Text(strings.tryOurProductsDrawerItem),
            onTap: () => _onItemTap(context, AppDrawerItems.keepItFree),
          ),

          const SizedBox(height: 8),

          // Settings drawer item
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text(strings.settingsDrawerItem),
            onTap: () => _onItemTap(context, AppDrawerItems.settings),
          ),

          const Divider(),

          // Add the Help & Support drawer item
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text(strings.helpDrawerItem),
            onTap: () => _onItemTap(context, AppDrawerItems.help),
          ),

          // Add the Safety drawer item
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text(strings.safetyDrawerItem),
            onTap: () => _onItemTap(context, AppDrawerItems.safety),
          ),
        ],
      ),
    );
  }
}

/// The app drawer header.
class _AppDrawerHeader extends StatelessWidget {
  /// Creates a new app drawer header.
  const _AppDrawerHeader({
    // ignore: unused_element
    super.key,
    this.onTryOurProductsTap,
  });

  /// The callback that is called when the user taps on the Try Our Products button.
  final void Function()? onTryOurProductsTap;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // The app name
          Text(
            strings.appName,
            style: Theme.of(context).textTheme.titleLarge,
          ),

          // The Keep It Free text
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(strings.keepItFree),
            onTap: onTryOurProductsTap,
          ),
        ],
      ),
    );
  }
}
