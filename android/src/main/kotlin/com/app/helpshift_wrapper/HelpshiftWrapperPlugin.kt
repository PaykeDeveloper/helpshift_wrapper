package com.app.helpshift_wrapper

import android.app.Activity
import com.helpshift.Helpshift
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

/** HelpshiftWrapperPlugin */
class HelpshiftWrapperPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "helpshift_wrapper")
        channel.setMethodCallHandler(this)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onMethodCall(call: MethodCall, result: Result) {

//        var status = await _channel.invokeListMethod("configure_sdk",
//        {'secret': helpShiftSecretKey, 'publishKey': helpShiftPublishableKey});
        when (call.method) {
            Constants.methodConfigureSdk -> {
                // configure and setup your sdk here
                val map = call.arguments as Map<String, String>
                configureHelpShiftSDK(map)
                result.success("SDK CONFIGURED")
            }

            Constants.allConversation -> {
                val map = call.arguments as Map<String, Any>
                val configMap = map["configMap"] as Map<String, Any>
                showAllConversation(configMap)
            }

            Constants.allFAQs -> {
                val map = call.arguments as Map<String, Any>
                val configMap = map["configMap"] as Map<String, Any>
                showAllFAQs(configMap)
            }

            Constants.methodSingleFAQsSection -> {
                val map = call.arguments as Map<String, Any>
                val sectionId = map["sectionId"] as String
                val configMap = map["configMap"] as Map<String, Any>
                openSingleFAQSectionScreen(sectionId, configMap)
            }

            Constants.methodSingleFAQDetail -> {
                val map = call.arguments as Map<String, String>
                val publishId = map["publishId"] as String
                val configMap = map["configMap"] as Map<String, Any>
                showSinglePublishedFAQ(publishId, configMap)
            }

            Constants.methodLogin -> {
                val map = call.arguments as Map<String, String>

                CoroutineScope(Dispatchers.Main).launch {
                    loginUser(map)
                    result.success(true)
                }
            }

            Constants.methodLogout -> {
                try {
                    logoutUser()
                    result.success(true)
                } catch (e: Exception) {
                    result.success(false)
                }
            }

            Constants.methodSetLanguage -> {
                val map = call.arguments as Map<String, Any>
                val language = map["language"] as String
                setLanguage(language)
                result.success(true)
            }

            Constants.methodHandleProactiveLink -> {
                val map = call.arguments as Map<String, Any>
                val proactiveLink = map["proactiveLink"] as String
                handleProactiveLink(proactiveLink)
                result.success(true)
            }

            Constants.methodHandlePush -> {
                val map = call.arguments as Map<String, Any>
                val data = map["data"] as Map<String, String>
                handlePush(data)
                result.success(true)
            }

            Constants.methodClearAnonymousUserOnLogin -> {
                val map = call.arguments as Map<String, Any>
                val clearAnonymousUser = map["clearAnonymousUser"] as Boolean
                clearAnonymousUserOnLogin(clearAnonymousUser)
                result.success(true)
            }

            Constants.methodRequestUnreadMessageCount -> {
                val map = call.arguments as Map<String, Any>
                val shouldFetchFromServer = map["shouldFetchFromServer"] as Boolean
                requestUnreadMessageCount(shouldFetchFromServer)
                result.success(true)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun configureHelpShiftSDK(args: Map<String, String>) {

        val configurations: HashMap<String, Any> = HashMap()
        configurations["enableInAppNotification"] = true
        configurations["enableLogging"] = true
        configurations["notificationChannelId"] = "HelpShift Notifications"
        configurations["notificationChannelId"] = "HelpShift Notifications"

        try {
            Helpshift.install(
                    activity!!.application,
                    args["helpShiftAppId"].toString(),
                    args["helpShiftDomain"].toString(),
                    configurations,
            )
        } catch (e: Exception) {
            e.printStackTrace()
        } finally {

        }
    }

    private fun showAllConversation(configMap: Map<String, Any>) {
        Helpshift.showConversation(activity!!, configMap)
    }

    private fun showAllFAQs(configMap: Map<String, Any>) {
        Helpshift.showFAQs(activity!!, configMap)
    }

    private fun openSingleFAQSectionScreen(sectionId: String, configMap: Map<String, Any>) {
        Helpshift.showFAQSection(activity!!, sectionId, configMap)
    }

    private fun showSinglePublishedFAQ(publishId: String, configMap: Map<String, Any>) {
        Helpshift.showSingleFAQ(activity!!, publishId, configMap)
    }

    private fun loginUser(user: Map<String, String>) {
        Helpshift.login(user)
    }

    private fun logoutUser() {
        Helpshift.logout()
    }

    private fun setLanguage(language: String) {
        Helpshift.setLanguage(language)
    }

    private fun handleProactiveLink(proactiveLink: String) {
        Helpshift.handleProactiveLink(proactiveLink)
    }

    private fun handlePush(data: Map<String, String>) {
        Helpshift.handlePush(data)
    }

    private fun clearAnonymousUserOnLogin(clearAnonymousUser: Boolean) {
        Helpshift.clearAnonymousUserOnLogin(clearAnonymousUser)
    }

    private fun requestUnreadMessageCount(shouldFetchFromServer: Boolean) {
        Helpshift.requestUnreadMessageCount(shouldFetchFromServer)
    }
}
