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

  @override
  Future<String> setUpHelpShiftSDK({
    required String helpShiftApiKey,
    required String helpShiftAppId,
    required String helpShiftDomain,
    Map<String, dynamic>? configMap,
  }) =>
      Future.value('test');

  @override
  Future<void> showAllConversation({required Map<String, dynamic> configMap}) =>
      Future.value(null);
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
