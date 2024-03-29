import 'package:flutter/services.dart';
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

  // Future<String> setUpHelpShiftSDK({
  //   required String helpShiftApiKey,
  //   required String helpShiftAppId,
  //   required String helpShiftDomain,
  //   required Map<String, dynamic> configMap,
  // });

  Future<void> showAllConversation({required Map<String, dynamic> configMap});

  Future<void> openFAQsScreen({required Map<String, dynamic> configMap});

  Future<void> openSingleFAQScreen({
    required String sectionId,
    required Map<String, dynamic> configMap,
  });

  Future<void> openSinglePublishedFAQDetail({
    required String publishId,
    required Map<String, dynamic> configMap,
  });

  Future<bool> loginUser({
    String? userName,
    String? userId,
    String? email,
  });

  Future<bool> logoutUser();

  Future<bool> setLanguage({required String language});

  Future<bool> handleProactiveLink({required String proactiveLink});

  Future<bool> handlePush({required Map<String, String> data});

  Future<bool> clearAnonymousUserOnLogin({required bool clearAnonymousUser});

  Future<bool> requestUnreadMessageCount({required bool shouldFetchFromServer});

  Future<void> setMethodCallHandler({
    required Future<dynamic> Function(MethodCall call)? handler,
  });
}
