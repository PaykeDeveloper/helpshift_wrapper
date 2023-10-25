import UIKit
import Flutter
import HelpshiftX

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // helpshift_wrapper
    Helpshift.install(
      withPlatformId: Bundle.main.object(forInfoDictionaryKey: "HelpShiftIosAppId") as! String,
      domain: Bundle.main.object(forInfoDictionaryKey: "HelpShiftDomain") as! String,
      config: [
        "enableLogging": true,
//         "isForChina": true,
      ])
//     Helpshift.sharedInstance().delegate = self
//     Helpshift.sharedInstance().proactiveAPIConfigCollectorDelegate = self

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // helpshift_wrapper
  override func application(
    _ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    Helpshift.registerDeviceToken(deviceToken)
  }
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter, willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    if notification.request.content.userInfo["origin"] as? String == "helpshift" {
      Helpshift.handleNotification(
        withUserInfoDictionary: notification.request.content.userInfo, isAppLaunch: false,
        with: UIApplication.shared.rootViewController)
      completionHandler([])
    } else {
      super.userNotificationCenter(
        center, willPresent: notification, withCompletionHandler: completionHandler)
    }
  }
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    if response.notification.request.content.userInfo["origin"] as? String == "helpshift" {
      Helpshift.handleNotification(
        withUserInfoDictionary: response.notification.request.content.userInfo, isAppLaunch: true,
        with: UIApplication.shared.rootViewController)
      completionHandler()
    } else {
      super.userNotificationCenter(
        center, didReceive: response, withCompletionHandler: completionHandler)
    }
  }
}

extension UIApplication {
  var currentKeyWindow: UIWindow? {
    if #available(iOS 13.0, *) {
      return UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .first?.windows
        .filter { $0.isKeyWindow }
        .first
    } else {
      return nil
    }
  }

  var rootViewController: UIViewController {
    guard let vc = currentKeyWindow?.rootViewController else {
      fatalError("Root view controller is nil. This should never happen.")
    }
    return vc
  }
}
