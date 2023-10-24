import 'dart:io';

class Constants {
  static const helpShiftDomain = String.fromEnvironment("HELP_SHIFT_DOMAIN");

  static helpShiftApiKey() {
    return const String.fromEnvironment("HELP_SHIFT_API_KEY");
  }

  static helpShiftAppId() {
    if (Platform.isAndroid) {
      return const String.fromEnvironment("HELP_SHIFT_ANDROID_APP_ID");
    } else if (Platform.isIOS) {
      return const String.fromEnvironment("HELP_SHIFT_IOS_APP_ID");
    } else {
      return "";
    }
  }
}
