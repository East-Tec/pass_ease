// Copyright (c) East-Tec <https://www.east-tec.com/>. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

/// URLs used in the app.
library;

const String _appId = 'passease';
const String _utmSource = 'passease';
const String _utmMedium = 'app';

/// The url of the East-Tec website, with UTM parameters, used in the East-Tec badge.
const String eastTecBadgeUrl =
    'https://www.east-tec.com/?utm_source=$_utmSource&utm_medium=$_utmMedium&utm_campaign=${_appId}_badge';

/// The URL where the user can try our products, used in the app drawer.
const String tryOurProductsUrl =
    'https://www.east-tec.com/?utm_source=$_utmSource&utm_medium=$_utmMedium&utm_campaign=${_appId}_keepitfree';

/// The URL for the app's help page.
const String help =
    'https://www.east-tec.com/passease/?utm_source=$_utmSource&utm_medium=$_utmMedium&utm_campaign=${_appId}_drawer';

/// The URL for the app's safety information page.
const String safety =
    'https://www.east-tec.com/passease/safety/?utm_source=$_utmSource&utm_medium=$_utmMedium&utm_campaign=${_appId}_drawer';
