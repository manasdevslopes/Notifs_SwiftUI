//
// PushNotificationSwiftUIApp.swift
// PushNotificationSwiftUI
//
// Created by MANAS VIJAYWARGIYA on 05/03/25.
// ------------------------------------------------------------------------
// 
// ------------------------------------------------------------------------
//
    
/*
 Notes: -
 1. First Add Firebase SPM and select Firebase Analytics and Firebase Messaging
 Link - https://github.com/firebase/firebase-ios-sdk.git
 2. Also Apple Developer Program should be enabled $99
 3. From the account (developer.apple.com/account), click on Certificates, Identifiers and Profile tab, and then navigate to Keys. Click on + sign and then add Key Name(any name). Then enable Apple Push Notification service (APNs). Remember we have only 2 APNs keys per Apple Developer Team.
 4. Then we can see download button to download it. Save it in secure place.
 5. Now we need to link this key to Firebase Cloud Messaging. To do this, go to Firebase log in -> Project Overview click on gear icon -> Click on Cloud Messaging -> Scroll down to iOS App Configuration -> We can add APNs Authentication key (new way) or APNs Certificate (Old way). To upload APNs Authentication key, click on it. Drag and drop the file with .p8 ext.
 6. Also add KeyID, find it in developer.apple.com/account -> Key -> click on it -> in detail u will find KeyID.
 7. Now for Team ID, go to developer.apple.com/account, click on Membership, we will find Team ID.
 8. Click on Upload
 9. Now go to Xcode -> Add the capability in the project. Click on Target -> goto Signing & Capabilities -> Click on capability -> search for Push Notification -> double click on it.
 10. Also search for background Modes in Capability -> now check Background Fetch and Remote Notification.
 11. Now go to Root file. And add all the codes as shown below including commented one.
 */

import SwiftUI
// import Firebase
import UserNotifications

@main
struct PushNotificationSwiftUIApp: App {
  @UIApplicationDelegateAdaptor(AppDelete.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

class AppDelete: NSObject, UIApplicationDelegate {
  let gcmMessageIDKey = "gcm.message_id"
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    // FirebaseApp.configure()
    
    // Messaging.messaging().delegate = self
    
    if #available(iOS 10.0, *) {
      // For iOS 10.0 display Notification (send via Apple APNs)
      UNUserNotificationCenter.current().delegate = self
      
      let authOption: UNAuthorizationOptions = [.alert, .badge, .sound]
      UNUserNotificationCenter.current().requestAuthorization(options: authOption) { (_, _) in }
    } else {
      let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
      application.registerUserNotificationSettings(settings)
    }
    
    application.registerForRemoteNotifications()
    return true
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
    
    print(userInfo)
    
    completionHandler(UIBackgroundFetchResult.newData)
  }
}

//extension AppDelete: MessagingDelegate {
//  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//    let deviceToken: [String: String] = ["token": fcmToken ?? ""]
//    print("Device_Token---------> \(deviceToken)") // This token can be used for testing notification on FCM
//  }
//}

@available(iOS 10.0, *)
extension AppDelete: UNUserNotificationCenterDelegate {
  // Receive displayed Notifications for iOS 10.0 devices
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo
    
    if let messageID = userInfo[gcmMessageIDKey] {
      print("MessageID: ----------> \(messageID)")
    }
    
    print(userInfo)
    
    completionHandler([[.banner, .badge, .sound]])
  }
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) { }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: any Error) { }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    
    if let messageID = userInfo[gcmMessageIDKey] {
      print("MessageID from userNotificationCenter didReceive: ----------> \(messageID)")
    }
  }
}

/*
 To test Push Notification from FCM : -
 1. Goto Firebase, click on Cloud Messaging -> Sned your first messge button. From console copy the device token.
 2. Then write some title, description, image (optional), also paste the token while sending notification. Test this in foreground, background and terminated app stages( All three).
 
 Before release of the application, need to click on entitlement files here, and for APNs environment, change form development to production. This entitlement files automatically be generated when we enable Push notificaiton from capabilities. And as by default it is development. But in production, u want env. to be in production, so change it manually to production. As per Apple's documentations.
 
 Now test in from Compose Notification: -
 1. Write some title, description, image (optional) -> Click next -> in Target either select User Segment or Topic -> For this example -> select User Segment -> select all users by selecting an App from dropdown. -> click next -> In Scheduling, we can schedule or send it now.
 2. Click next -> Conversion events (Optional) this is basically for sending any kind of Analytics events -> click next -> in Additional options, if u want to send any key-value pair , some sort of dictionary Objects/data. Also enable/disable sound, iOS Badge also select expiry date of notification -> click on Review button. Then click on Publish button.
 It will take some time and it will send the notification to the device.
 
 */

/*
 Sources: -
 1. SwiftUI Push Notifications Crash Course by DesignCode.io - https://www.youtube.com/watch?v=TGOF8MqcAzY
 2. DesignCode.io 3 part series for Push Notification in iOS with Firebase - https://designcode.io/swiftui-advanced-handbook-push-notifications-part-1
 */

/*
 Other links for Push Notification: -
 1. Quickly test alert notifications with the iOS simulator in your Swiftui - https://www.linkedin.com/posts/amosgyamfi_ios-swiftui-uikit-ugcPost-7133715992790089728-COej/?utm_source=combined_share_message&utm_medium=member_ios
    And https://getstream.io/blog/test-ios-push-notifications/
 
 2. Stop Guessing! Master Push Notifications Locally in Just Minutes! By Rebeloper - Rebel Developer - https://www.youtube.com/watch?v=AUyq-pOaRIY
 3. Notification Deep Linking | Open Specific View From Push Notifications | SwiftUI By Kavsoft - https://www.youtube.com/watch?v=6Y9KDTjmpLA
 4. SwiftUI - Firebase Push Notifications Without Backend Servers - Xcode 13 - Firebase Cloud Messaging By Kavsoft - https://www.youtube.com/watch?v=DoITpssj-jk
 5.【SwiftUI】Firebase Cloud Messaging to Send Push Notification By kenmaro's prototyping - https://www.youtube.com/watch?v=6LAQBbLC_qE
 6. SwiftUI 2.0 Push Notifications - Firebase Cloud Messaging - SwiftUI Tutorials By Kavsoft - https://www.youtube.com/watch?v=3rRdXvXAsFs
 */
