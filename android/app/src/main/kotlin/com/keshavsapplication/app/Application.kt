package com.keshavsapplication.app

import android.util.Log
import com.netcore.android.Smartech
import com.netcore.android.smartechpush.SmartPush
import com.netcore.android.smartechpush.notification.SMTNotificationOptions
import com.netcore.smartech_appinbox.SmartechAppinboxPlugin
import com.netcore.smartech_base.SmartechBasePlugin
import com.netcore.smartech_push.SmartechPushPlugin
import io.flutter.app.FlutterApplication
import io.hansel.core.logger.HSLLogLevel
import java.lang.ref.WeakReference

class Application: FlutterApplication() {
    override fun onCreate() {
        super.onCreate()

        // Initialize Smartech Sdk
        Smartech.getInstance(WeakReference(applicationContext)).initializeSdk(this)
        // Add the below line for debugging logs
        Smartech.getInstance(WeakReference(applicationContext)).setDebugLevel(9)
        // Add the below line to track app install and update by smartech
        Smartech.getInstance(WeakReference(applicationContext)).trackAppInstallUpdateBySmartech()

        HSLLogLevel.all.setEnabled(true);
        HSLLogLevel.mid.setEnabled(true);
        HSLLogLevel.debug.setEnabled(true);
        HSLLogLevel.min.setEnabled(true);

        // Initialize Flutter Smartech Base Plugin
        SmartechBasePlugin.initializePlugin(this)

        // Initialize Flutter Smartech Push Plugin
        SmartechPushPlugin.initializePlugin(this)

        SmartechAppinboxPlugin.initializePlugin(this)

        val options = SMTNotificationOptions(this)
        options.brandLogo = "@drawable/ic_notification"//e.g.logo is sample name for brand logo
        options.largeIcon = "@drawable/ic_notification"//e.g.ic_notification is sample name for large icon
        options.smallIcon = "@drawable/ic_notification"//e.g.ic_action_play is sample name for icon
        options.smallIconTransparent = "@drawable/ic_notification"//e.g.ic_action_play is sample name for transparent small icon
        options.transparentIconBgColor = "#88568C"
        options.placeHolderIcon = "@drawable/ic_notification"//e.g.ic_notification is sample name for placeholder icon
        SmartPush.getInstance(WeakReference(applicationContext)).setNotificationOptions(options)
    }

    override fun onTerminate() {
        super.onTerminate()
        Log.d("onTerminate", "onTerminate")
    }
}