import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:helpshift_wrapper/native_method_constants.dart';

import 'helpshift_wrapper_platform_interface.dart';

/// An implementation of [HelpshiftWrapperPlatform] that uses method channels.
class MethodChannelHelpshiftWrapper extends HelpshiftWrapperPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('helpshift_wrapper');

  /// call this method to setup HelpShift SDK in Native Platform
  /// with arguments [helpShiftApiKey],[helpShiftDomain] and [helpShiftAppId] you will
  /// get in your HelpShift Account Dashboard
  @override
  Future<String> setUpHelpShiftSDK(
      {required helpShiftApiKey,
      required helpShiftAppId,
      required helpShiftDomain}) async {
    var status = await methodChannel.invokeMethod(
      Methods.methodConfigureSdk,
      {
        'helpShiftApiKey': helpShiftApiKey,
        'helpShiftAppId': helpShiftAppId,
        'helpShiftDomain': helpShiftDomain
      },
    );
    if (kDebugMode) {
      print("configuration status: $status");
    }
    return status;
  }

  /// method which will invoke the contact_us function implemented in Native Platform
  /// with an argument [configMap], it will open all the conversation listing from HelpShift SDK Support and user
  @override
  Future<void> showAllConversation({configMap}) async {
    await methodChannel.invokeMethod(
      Methods.allConversation,
      {'configMap': configMap},
    );
  }

  /// method which will invoke the faq_s function implemented in Native Platform
  /// with an argument [configMap] , it will open the native HelpShift SDK's all FAQ screen in a web_view
  @override
  Future<void> openFAQsScreen({configMap}) async {
    await methodChannel.invokeMethod(
      Methods.allFAQs,
      {'configMap': configMap},
    );
  }

  /// method which will invoke the single_faq_s function implemented in Native Platform
  /// with an argument [sectionId] and [configMap], it will open any particular FAQ from HelpShift SDK in a
  /// web_view format
  @override
  Future<void> openSingleFAQScreen({required sectionId, configMap}) async {
    await methodChannel.invokeMethod(
      Methods.methodSingleFAQsSection,
      {'sectionId': sectionId, 'configMap': configMap},
    );
  }

  /// method which will invoke the single_faq_s function implemented in Native Platform
  /// with an argument [sectionId] and [configMap], it will open any particular FAQ from HelpShift SDK in a
  /// web_view format
  @override
  Future<void> openSinglePublishedFAQDetail(
      {required publishId, configMap}) async {
    await methodChannel.invokeMethod(
      Methods.methodSingleFAQDetail,
      {'publishId': publishId, 'configMap': configMap},
    );
  }

  /// method to login in helpshift sdk with an arguments [userName],[userId] and [email]
  @override
  Future<bool> loginUser({
    required userName,
    required userId,
    required email,
  }) async {
    return await methodChannel.invokeMethod(Methods.methodLogin,
        {'userId': userId, 'userName': userName, 'userEmail': email});
  }

  /// method to logout user from helpshift sdk
  @override
  Future<bool> logoutUser() async {
    return await methodChannel.invokeMethod(Methods.methodLogout);
  }

  @override
  Future<bool> setLanguage({required language}) async {
    return await methodChannel.invokeMethod(
      Methods.methodSetLanguage,
      {'language': language},
    );
  }

  @override
  Future<bool> clearAnonymousUserOnLogin(
      {required bool clearAnonymousUser}) async {
    return await methodChannel.invokeMethod(
      Methods.methodClearAnonymousUserOnLogin,
      {'clearAnonymousUser': clearAnonymousUser},
    );
  }

  @override
  Future<bool> handleProactiveLink({required String proactiveLink}) async {
    return await methodChannel.invokeMethod(
      Methods.methodHandleProactiveLink,
      {'proactiveLink': proactiveLink},
    );
  }

  @override
  Future<bool> handlePush({required Map<String, String> data}) async {
    return await methodChannel.invokeMethod(
      Methods.methodHandlePush,
      {'data': data},
    );
  }

  @override
  Future<bool> requestUnreadMessageCount(
      {required bool shouldFetchFromServer}) async {
    return await methodChannel.invokeMethod(
      Methods.methodRequestUnreadMessageCount,
      {'shouldFetchFromServer': shouldFetchFromServer},
    );
  }
}
