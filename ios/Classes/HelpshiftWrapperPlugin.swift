import Flutter
import UIKit
import HelpshiftX
import Foundation

public class HelpshiftWrapperPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "helpshift_wrapper", binaryMessenger: registrar.messenger())
    let instance = HelpshiftWrapperPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case Constant.methodConfigureSdk:
      do {
        self.configureHelpShiftSdk(call.arguments as! [String: Any])
        result("iOS Setup Completed")
      }
    case Constant.allConversation:
      do {
        let viewController1: UIViewController =
          (UIApplication.shared.delegate?.window??.rootViewController)!
        //          let tags = ["Hello", "iOS"]
        //          let config = ["tags":tags]
        let map = call.arguments as! [String: Any]
        let configMap = (map["configMap"])! as! [String: Any]
        self.showAllConversation(viewController1, configMap)
      }
    case Constant.allFAQs:
      do {
        let viewController1: UIViewController =
          (UIApplication.shared.delegate?.window??.rootViewController)!
        let map = call.arguments as! [String: Any]
        let configMap = (map["configMap"])! as! [String: Any]
        self.showAllFaqs(viewController1, configMap)
      }
    case Constant.methodSingleFAQsSection:
      do {
        let map = call.arguments as! [String: Any]
        let sectionId = (map["sectionId"] ?? "")! as! String

        let configMap = (map["configMap"])! as! [String: Any]
        self.showSingleFaqScreen(sectionId, configMap)
      }
    case Constant.methodSingleFAQDetail:
      do {
        let map = call.arguments as! [String: Any]
        let publishId = (map["publishId"])! as! String
        let configMap = (map["configMap"])! as! [String: Any]
        self.showSingleFAqDetail(publishId, configMap)
      }

    case Constant.methodLogin:
      do {
        let map = call.arguments as! [String: String]
        self.loginUser(map)
        result(true)
      }

    case Constant.methodLogout:
      do {
        self.logoutUser()
        result(true)
      }

    case Constant.methodSetLanguage:
      do {
        let map = call.arguments as! [String: Any]
        let language = (map["language"])! as! String
        self.setLanguage(language)
        result(true)
      }

    case Constant.methodHandleProactiveLink:
      do {
        let map = call.arguments as! [String: Any]
        let proactiveLink = (map["proactiveLink"])! as! String
        self.handleProactiveLink(proactiveLink)
        result(true)
      }

    case Constant.methodHandlePush:
      do {
        let map = call.arguments as! [String: Any]
        let data = (map["data"])! as! [String: String]
        self.handlePush(data)
        result(true)
      }

    case Constant.methodClearAnonymousUserOnLogin:
      do {
        let map = call.arguments as! [String: Any]
        let clearAnonymousUser = (map["clearAnonymousUser"])! as! Bool
        self.clearAnonymousUserOnLogin(clearAnonymousUser)
        result(true)
      }

    case Constant.methodRequestUnreadMessageCount:
      do {
        let map = call.arguments as! [String: Any]
        let shouldFetchFromServer = (map["shouldFetchFromServer"])! as! Bool
        self.requestUnreadMessageCount(shouldFetchFromServer)
        result(true)
      }

    default:
      do {

      }
      break

    }
    result("iOS " + UIDevice.current.systemVersion)
  }

  func configureHelpShiftSdk(_ map: [String: Any]) {
//    let apiKey = (map["helpShiftApiKey"])! as! String
    let domainName = (map["helpShiftDomain"])! as! String
    let appId = (map["helpShiftAppId"])! as! String

    let config = (map["configMap"])! as! [String: Any]

    Helpshift.install(withPlatformId: appId, domain: domainName, config: config)

    //        HelpshiftCore.initialize(with: HelpshiftSupport.sharedInstance())
    //        HelpshiftCore.install(forApiKey:apiKey, domainName: domainName, appID: appId)

  }

  func showAllConversation(_ type: UIViewController, _ configMap: [String: Any]) {

    Helpshift.showConversation(with: type, config: configMap)
    //  HelpshiftSupport.showConversation(type, config: configMap)
  }

  func showAllFaqs(_ type: UIViewController, _ configMap: [String: Any]) {
    Helpshift.showFAQs(with: type, config: configMap)
  }

  func showSingleFaqScreen(_ sectionId: String, _ configMap: [String: Any]) {

    let viewController: UIViewController =
      (UIApplication.shared.delegate?.window??.rootViewController)!
    Helpshift.showFAQSection(sectionId, with: viewController, config: configMap)
  }

  func showSingleFAqDetail(_ publishId: String, _ configMap: [String: Any]) {
    let viewController: UIViewController =
      (UIApplication.shared.delegate?.window??.rootViewController)!
    Helpshift.showSingleFAQ(publishId, with: viewController, config: configMap)
  }

  func loginUser(_ userDetail: [String: String]) {
    Helpshift.loginUser(userDetail)
  }

  func logoutUser() {
    Helpshift.logout()
  }

  func setLanguage(_ language: String) {
    Helpshift.setLanguage(language)
  }
    
  func handleProactiveLink(_ proactiveLink: String) {
    Helpshift.handleProactiveLink(proactiveLink)
  }

  func handlePush(_ data: [String: String]) {
      let viewController: UIViewController =
        (UIApplication.shared.delegate?.window??.rootViewController)!
    Helpshift.handleNotification(withUserInfoDictionary: data, isAppLaunch: true, with: viewController)
  }

  func clearAnonymousUserOnLogin(_ clearAnonymousUser: Bool) {
    Helpshift.clearAnonymousUser(onLogin: clearAnonymousUser)
  }

  func requestUnreadMessageCount(_ shouldFetchFromServer: Bool) {
    Helpshift.requestUnreadMessageCount(shouldFetchFromServer)
  }
}
