package com.app.helpshift_wrapper_example

import com.app.helpshift_wrapper.HelpshiftWrapperPlugin
import io.flutter.app.FlutterApplication

class MainApplication : FlutterApplication() {
    override fun onCreate() {
        super.onCreate()

        // helpshift_wrapper
        HelpshiftWrapperPlugin.install(this, getString(R.string.help_shift_android_app_id), getString(R.string.help_shift_domain), mapOf(
            "enableLogging" to true,
//            "isForChina" to true,
        ))
    }
}