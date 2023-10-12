# HelpShift Community Wrapper

## A plugin to use helpshift sdk into your flutter app within few steps:

##### just replace the below parameters in example/lib/src/constants.dart with your domain, and api_key  and   app_id from your helpshift dashboard.

```sh

import 'dart:io';
class Constants {
  static const helpShiftDomain = 'your_helpshift_domain';
  static helpShiftApiKey() {
    if (Platform.isAndroid) {
      return 'your_api_key_for_android';
    } else if (Platform.isIOS) {
      return "your_api_key_for_iOS";
    } else {
      return "";
    }
  }

  static helpShiftAppId() {
    if (Platform.isAndroid) {
      return 'your_app_id_for_android';
    } else if (Platform.isIOS) {
      return "your_app_id_for_iOS";
    } else {
      return "";
    }
  }
}
```