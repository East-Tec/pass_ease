// Copyright (c) East-Tec <https://www.east-tec.com/>. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

/// The strings used in the user interface, defined as constants.
library;

// -----------------------------------------------------------------------------------------------
// App
// -----------------------------------------------------------------------------------------------

const String appName = 'PassEase';

// -----------------------------------------------------------------------------------------------
// Common
// -----------------------------------------------------------------------------------------------

const String keepItFree =
    'We are dedicated to keeping PassEase free and open source, and we hope you will support our effort by using our products to protect your privacy and security.';
const String tryOurProductsDrawerItem = 'Try our products for free';
const String settingsDrawerItem = 'Settings';
const String helpDrawerItem = 'Help & support';
const String safetyDrawerItem = 'Are my passwords safe?';
const String openFail = 'Failed to open';

// -----------------------------------------------------------------------------------------------
// PassEase Screen (Home Screen)
// -----------------------------------------------------------------------------------------------

const String homeScreenTitle = 'PassEase';
const String textFieldHint = 'Type or paste';
const String lockModeOnTooltip = 'Hide password';
const String lockModeOffTooltip = 'Show password';

// App bar actions

const String textIncreaseTooltip = 'Increase text size';
const String textDecreaseTooltip = 'Decrease text size';
const String currentCharTooltip = 'What\'s this character?';
const String pasteTooltip = 'Paste and replace password';
const String pasteFail = 'No text to paste';
const String copyAction = 'Copy to clipboard';
const String copiedSnackbar = 'Copied to clipboard.';
const String copyFailSnackbar = 'Failed to copy to clipboard:';
const String clearAction = 'Clear';

// The East-Tec badge

const String broughtToYouBy = 'Made by';
const String broughtToYouByWide = 'Brought to you by';
const String eastTec = 'East-Tec';
const String eastTecWide = 'East-Tec - Privacy since 1997';

// -----------------------------------------------------------------------------------------------
// Settings Screen
// -----------------------------------------------------------------------------------------------

const String settingsScreenTitle = 'Settings';
const String chunksSetting = 'Split into chunks of';
const String textSizeSetting = 'Text size';
const String monospacedFontSetting = 'Monospaced font';
const String backgroundColorSetting = 'Background color';
const String editCustomColorTooltip = 'Edit custom color';
const String okButtonTitle = 'OK';
const String cancelButtonTitle = 'Cancel';

// -----------------------------------------------------------------------------------------------
// Invalid Color Screen
// -----------------------------------------------------------------------------------------------

String invalidPage(String? uri) => 'Can\'t find a page for:\n$uri';
const String goHome = 'Go Home';
