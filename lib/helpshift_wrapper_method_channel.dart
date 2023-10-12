import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'helpshift_wrapper_platform_interface.dart';

/// An implementation of [HelpshiftWrapperPlatform] that uses method channels.
class MethodChannelHelpshiftWrapper extends HelpshiftWrapperPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('helpshift_wrapper');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
