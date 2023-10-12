import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helpshift_wrapper/helpshift_wrapper_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelHelpshiftWrapper platform = MethodChannelHelpshiftWrapper();
  const MethodChannel channel = MethodChannel('helpshift_wrapper');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return true;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.setLanguage(language: 'ja'), true);
  });
}
