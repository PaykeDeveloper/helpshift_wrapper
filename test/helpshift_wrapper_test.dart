import 'package:flutter_test/flutter_test.dart';
import 'package:helpshift_wrapper/helpshift_wrapper.dart';
import 'package:helpshift_wrapper/helpshift_wrapper_platform_interface.dart';
import 'package:helpshift_wrapper/helpshift_wrapper_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHelpshiftWrapperPlatform
    with MockPlatformInterfaceMixin
    implements HelpshiftWrapperPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final HelpshiftWrapperPlatform initialPlatform = HelpshiftWrapperPlatform.instance;

  test('$MethodChannelHelpshiftWrapper is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHelpshiftWrapper>());
  });

  test('getPlatformVersion', () async {
    HelpshiftWrapper helpshiftWrapperPlugin = HelpshiftWrapper();
    MockHelpshiftWrapperPlatform fakePlatform = MockHelpshiftWrapperPlatform();
    HelpshiftWrapperPlatform.instance = fakePlatform;

    expect(await helpshiftWrapperPlugin.getPlatformVersion(), '42');
  });
}
