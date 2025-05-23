import Firebase
import Flutter
import SmartPush
import Smartech
import SmartechNudges
import UIKit
import smartech_base

@main
@objc class AppDelegate: FlutterAppDelegate, SmartechDelegate//HanselActionListener
{
    //    func onActionPerformed(action: String!) {
    //        <#code#>
    //    }

    override func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        Smartech.sharedInstance().initSDK(with: self, withLaunchOptions: launchOptions)

        Hansel.enableDebugLogs()  // TODO: Disable debug logs for production

        Smartech.sharedInstance().trackAppInstallUpdateBySmartech()

        Smartech.sharedInstance().setDebugLevel(.verbose)  // TODO: Set appropriate debug level

        SmartPush.sharedInstance().registerForPushNotificationWithDefaultAuthorizationOptions()

        UNUserNotificationCenter.current().delegate = self

        print(launchOptions as Any)
        FirebaseApp.configure()
        GeneratedPluginRegistrant.register(with: self)
        onClick()
        //        Hansel.registerHanselActionListener(action: String, listener: any HanselActionListener)
        return super.application(application,didFinishLaunchingWithOptions: launchOptions)
        //      return true
    }

    override func application( _ application: UIApplication,didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {

        SmartPush.sharedInstance().didRegisterForRemoteNotifications(withDeviceToken: deviceToken)

        Messaging.messaging().apnsToken = deviceToken

    }

    override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {

        SmartPush.sharedInstance().didFailToRegisterForRemoteNotificationsWithError(error)
    }

    //MARK:- UNUserNotificationCenterDelegate Methods
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) ->Void
    ) {

        SmartPush.sharedInstance().willPresentForegroundNotification(notification)

        completionHandler([.alert, .badge, .sound])
    }

    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        
        // MARK: Adding the delay of 5ms in didReceive response class will give the pn_clicked event in Terminated state also. Replace existing code with the below lines.
       DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            SmartPush.sharedInstance().didReceive(response)
            completionHandler()
        }
    }

    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {

        var handleBySmartech = Smartech.sharedInstance().application(app, open: url, options: options)
        if !handleBySmartech {

        }
        return true

    }

    // handle the url by the app

    func onLaunchURL(URLString: String!) {

    }

    func onClick() {
        //https://cedocs.netcorecloud.com/docs/universal-links-for-email-engagement#implementing-link-resolution

        //    https://elink.savmoney.me/vtrack?
        //                let netcoreURL = URL(string: "https://elink.savmoney.me/vtrack?clientid=170681&ul=BgVRBlNEBR5TX15DB154R1VASw4KWVYdTx4=&ml=BA9VSFJEA1MESw==&sl=dUolSDdrSTF9Y0tUClBWXxpFBBUIWF0BSkwLU0xQ&pp=0&c=0000&fl=X0ISRBECGk1DVkFQFkkWVURGSw8MWVhLew88UHkiXFZrI1M=&ext=")!
        //
        ////             if let referralURL = userActivity?.webpageURL, let netcoreURL = URL(string: String(describing: referralURL)) {
        //             if  let netcoreURL = URL(string: String(describing: netcoreURL)) {
        //            print("URL: \(netcoreURL)")
        //
        //            let task = URLSession.shared.dataTask(with: netcoreURL) { data, response, error in
        //                guard error == nil else {
        //                    print("Universal Error resolving link: \(error!)")
        //                    return
        //                }
        //
        //                if let httpResponse = response as? HTTPURLResponse {
        //                    if let originalURL = httpResponse.url {
        //                        let responseValue = originalURL.absoluteString // Convert the URL to a string
        //                        print("Response URL: \(responseValue)")
        //                    } else {
        //                        print("HTTP response was not successful: \(httpResponse.statusCode)")
        //                    }
        //                } else if response == nil {
        //                    print("Response is nil")
        //                } else {
        //                    print("Invalid sor unsuccessful HTTP response")
        //                }
        //
        //            }
        let netcoreURL = URL(
            string:
                "https://elink.savmoney.me/vtrack?clientid=170681&ul=BgVRBlNEBR5TX15DB154R1VASw4KWVYdTx4=&ml=BA9VSFJEA1MESw==&sl=dUolSDdrSTF9Y0tUClBWXxpFBBUIWF0BSkwLU0xQ&pp=0&c=0000&fl=X0ISRBECGk1DVkFQFkkWVURGSw8MWVhLew88UHkiXFZrI1M=&ext="
        )!
        let task = URLSession.shared.dataTask(with: netcoreURL) { data, response, error in
            guard error == nil else {
                print("Error resolving link: \(error!)")
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                // Successfully resolved the link
                if let originalURL = httpResponse.url {
                    // Trigger the click event and navigate to the correct part of your app
                    print("Original URL: \(originalURL)")
                }
            }
        }
        task.resume()
        //        }

        //        else {
        //            print("Invalid referral URL")
        //
        //        }

        //        return responseValue
    }

    func handleDeeplinkAction(withURLString deeplinkURLString: String,andNotificationPayload notificationPayload: [AnyHashable: Any]?
    ) {
        NSLog("SMTL deeplink Native---> \(deeplinkURLString)")
        SmartechBasePlugin.handleDeeplinkAction(deeplinkURLString, andCustomPayload: notificationPayload)
    }
}
