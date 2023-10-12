
import 'helpshift_wrapper_platform_interface.dart';

class HelpshiftWrapper {
  Future<String?> getPlatformVersion() {
    return HelpshiftWrapperPlatform.instance.getPlatformVersion();
  }
}
