// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'helpshift_wrapper_platform_interface.dart';

/// A web implementation of the HelpshiftWrapperPlatform of the HelpshiftWrapper plugin.
class HelpshiftWrapperWeb extends HelpshiftWrapperPlatform {
  /// Constructs a HelpshiftWrapperWeb
  HelpshiftWrapperWeb();

  static void registerWith(Registrar registrar) {
    HelpshiftWrapperPlatform.instance = HelpshiftWrapperWeb();
  }

  @override
  Future<bool> loginUser(
      {required String userName,
      required String userId,
      required String email}) {
    // TODO: implement loginUser
    throw UnimplementedError();
  }

  @override
  Future<bool> logoutUser() {
    // TODO: implement logoutUser
    throw UnimplementedError();
  }

  @override
  Future<void> openFAQsScreen({Map<String, dynamic>? configMap}) {
    // TODO: implement openFAQsScreen
    throw UnimplementedError();
  }

  @override
  Future<void> openSingleFAQScreen(
      {required String sectionId, Map<String, dynamic>? configMap}) {
    // TODO: implement openSingleFAQScreen
    throw UnimplementedError();
  }

  @override
  Future<void> openSinglePublishedFAQDetail(
      {required String publishId, Map<String, dynamic>? configMap}) {
    // TODO: implement openSinglePublishedFAQDetail
    throw UnimplementedError();
  }

  @override
  Future<bool> setLanguage({required String language}) {
    // TODO: implement setLanguage
    throw UnimplementedError();
  }

  @override
  Future<String> setUpHelpShiftSDK(
      {required String helpShiftApiKey,
      required String helpShiftAppId,
      required String helpShiftDomain}) {
    // TODO: implement setUpHelpShiftSDK
    throw UnimplementedError();
  }

  @override
  Future<void> showAllConversation({Map<String, dynamic>? configMap}) {
    // TODO: implement showAllConversation
    throw UnimplementedError();
  }

  @override
  Future<bool> clearAnonymousUserOnLogin({required bool clearAnonymousUser}) {
    // TODO: implement clearAnonymousUserOnLogin
    throw UnimplementedError();
  }

  @override
  Future<bool> handleProactiveLink({required String proactiveLink}) {
    // TODO: implement handleProactiveLink
    throw UnimplementedError();
  }

  @override
  Future<bool> handlePush({required Map<String, String> data}) {
    // TODO: implement handlePush
    throw UnimplementedError();
  }

  @override
  Future<bool> requestUnreadMessageCount(
      {required bool shouldFetchFromServer}) {
    // TODO: implement requestUnreadMessageCount
    throw UnimplementedError();
  }
}
