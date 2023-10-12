import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'helpshift_wrapper_method_channel.dart';

abstract class HelpshiftWrapperPlatform extends PlatformInterface {
  /// Constructs a HelpshiftWrapperPlatform.
  HelpshiftWrapperPlatform() : super(token: _token);

  static final Object _token = Object();

  static HelpshiftWrapperPlatform _instance = MethodChannelHelpshiftWrapper();

  /// The default instance of [HelpshiftWrapperPlatform] to use.
  ///
  /// Defaults to [MethodChannelHelpshiftWrapper].
  static HelpshiftWrapperPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HelpshiftWrapperPlatform] when
  /// they register themselves.
  static set instance(HelpshiftWrapperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
