import 'helpshift_wrapper_platform_interface.dart';

const Map<String, dynamic> defaultMap = {};

class HelpshiftWrapper {
  static Future setUpHelpShiftSDK({
    required String helpShiftApiKey,
    required String helpShiftAppId,
    required String helpShiftDomain,
    Map<String, dynamic> configMap = defaultMap,
  }) async =>
      HelpshiftWrapperPlatform.instance.setUpHelpShiftSDK(
        helpShiftApiKey: helpShiftApiKey,
        helpShiftAppId: helpShiftAppId,
        helpShiftDomain: helpShiftDomain,
        configMap: configMap,
      );

  static Future showAllConversation({
    Map<String, dynamic> configMap = defaultMap,
  }) async =>
      HelpshiftWrapperPlatform.instance.showAllConversation(
        configMap: configMap,
      );

  static Future openFAQsScreen({
    Map<String, dynamic> configMap = defaultMap,
  }) async =>
      HelpshiftWrapperPlatform.instance.openFAQsScreen(
        configMap: configMap,
      );

  static Future openSingleFAQScreen({
    required String sectionId,
    Map<String, dynamic> configMap = defaultMap,
  }) async =>
      HelpshiftWrapperPlatform.instance.openSingleFAQScreen(
        sectionId: sectionId,
        configMap: configMap,
      );

  static Future openSinglePublishedFAQDetail({
    required String publishId,
    Map<String, dynamic> configMap = defaultMap,
  }) async =>
      HelpshiftWrapperPlatform.instance.openSinglePublishedFAQDetail(
        publishId: publishId,
        configMap: configMap,
      );

  static Future<bool> loginUser({
    String? userName,
    String? userId,
    String? email,
  }) async =>
      HelpshiftWrapperPlatform.instance.loginUser(
        userName: userName,
        userId: userId,
        email: email,
      );

  static Future<bool> logoutUser() async =>
      HelpshiftWrapperPlatform.instance.logoutUser();

  static Future<bool> setLanguage({required String language}) async =>
      HelpshiftWrapperPlatform.instance.setLanguage(language: language);
}
