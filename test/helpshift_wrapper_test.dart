import 'package:flutter/src/services/message_codec.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helpshift_wrapper/helpshift_wrapper.dart';
import 'package:helpshift_wrapper/helpshift_wrapper_method_channel.dart';
import 'package:helpshift_wrapper/helpshift_wrapper_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHelpshiftWrapperPlatform
    with MockPlatformInterfaceMixin
    implements HelpshiftWrapperPlatform {
  @override
  Future<bool> loginUser({String? userName, String? userId, String? email}) =>
      Future.value(true);

  @override
  Future<bool> logoutUser() => Future.value(true);

  @override
  Future<void> openFAQsScreen({Map<String, dynamic>? configMap}) =>
      Future.value(null);

  @override
  Future<void> openSingleFAQScreen(
          {required String sectionId, Map<String, dynamic>? configMap}) =>
      Future.value(null);

  @override
  Future<void> openSinglePublishedFAQDetail(
          {required String publishId, Map<String, dynamic>? configMap}) =>
      Future.value(null);

  @override
  Future<bool> setLanguage({required String language}) => Future.value(true);

  // @override
  // Future<String> setUpHelpShiftSDK({
  //   required String helpShiftApiKey,
  //   required String helpShiftAppId,
  //   required String helpShiftDomain,
  //   Map<String, dynamic>? configMap,
  // }) =>
  //     Future.value('test');

  @override
  Future<void> showAllConversation({required Map<String, dynamic> configMap}) =>
      Future.value(null);

  @override
  Future<bool> clearAnonymousUserOnLogin({required bool clearAnonymousUser}) =>
      Future.value(true);

  @override
  Future<bool> handleProactiveLink({required String proactiveLink}) =>
      Future.value(true);

  @override
  Future<bool> handlePush({required Map<String, String> data}) =>
      Future.value(true);

  @override
  Future<bool> requestUnreadMessageCount(
      {required bool shouldFetchFromServer}) {
    // TODO: implement requestUnreadMessageCount
    throw UnimplementedError();
  }

  @override
  Future<void> setMethodCallHandler({
    required Future Function(MethodCall call)? handler,
  }) {
    // TODO: implement setMethodCallHandler
    throw UnimplementedError();
  }
}

void main() {
  final HelpshiftWrapperPlatform initialPlatform =
      HelpshiftWrapperPlatform.instance;

  test('$MethodChannelHelpshiftWrapper is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHelpshiftWrapper>());
  });

  test('getPlatformVersion', () async {
    MockHelpshiftWrapperPlatform fakePlatform = MockHelpshiftWrapperPlatform();
    HelpshiftWrapperPlatform.instance = fakePlatform;

    expect(await HelpshiftWrapper.setLanguage(language: 'ja'), true);
  });
}
