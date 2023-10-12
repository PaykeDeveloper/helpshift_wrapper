import 'dart:io';

class Constants {
  static const helpShiftDomain = 'dev-1.helpshift.com';

  static helpShiftApiKey() {
    if (Platform.isAndroid) {
      return 'b3c36d1815354cc6055eb4c8e5098439';
    } else if (Platform.isIOS) {
      return "b3c36d1815354cc6055eb4c8e5098439";
    } else {
      return "";
    }
  }

  static helpShiftAppId() {
    if (Platform.isAndroid) {
      return 'dev-1_platform_20221007091607698-2f0a9b0bcaee4ea';
    } else if (Platform.isIOS) {
      return "dev-1_platform_20221007091607612-d89f65912f77ac9";
    } else {
      return "";
    }
  }
}
