import UIKit
import Flutter
import HelpshiftX

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(
    _ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    Helpshift.registerDeviceToken(deviceToken)
  }

//   override func userNotificationCenter(
//     _ center: UNUserNotificationCenter,
//     willPresent notification: UNNotification
//   ) async -> UNNotificationPresentationOptions {
//     super.userNotificationCenter(center, willPresent: notification)
//
//     let options = super.userNotificationCenter(center, didReceive: response)
//
//     let userInfo = notification.request.content.userInfo
//     if let origin = userInfo["origin"] as? String, origin == "helpshift" {
//       print("userNotificationCenter:willPresentNotification for helpshift origin.")
//       Helpshift.handleNotification(
//         withUserInfoDictionary: userInfo,
//         isAppLaunch: false,
//         with: UIApplication.shared.rootViewController)
//       return []
//     } else if let proactiveLink = userInfo["helpshift_proactive_link"] as? String {
//       Helpshift.handleProactiveLink(proactiveLink)
//     }
//     return [.banner, .sound]
//   }
//
//   override func userNotificationCenter(
//     _ center: UNUserNotificationCenter,
//     didReceive response: UNNotificationResponse
//   ) async {
//     super.userNotificationCenter(center, didReceive: response)
//
//     let userInfo = response.notification.request.content.userInfo
//     if let origin = userInfo["origin"] as? String, origin == "helpshift" {
//       print("userNotificationCenter:didReceiveResponse for helpshift origin.")
//       Helpshift.handleNotification(
//         withUserInfoDictionary: userInfo,
//         isAppLaunch: true,
//         with: UIApplication.shared.rootViewController)
//     } else if let proactiveLink = userInfo["helpshift_proactive_link"] as? String {
//       Helpshift.handleProactiveLink(proactiveLink)
//     }
//   }
}
