//
//  My_Fish_TankApp.swift
//  My Fish Tank
//
//  Created by Gino Preti on 18/11/20.
//

import SwiftUI
import Firebase
import AVFoundation

@main
struct My_Fish_TankApp: App
{
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    
    var body: some Scene
    {
        WindowGroup {
            ContentView()
        }
    }
}

class Delegate : NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate
{    
    @AppStorage(AppStorageKeys.newLevelAddedDefaultAlertSound.rawValue) var newLevelAddedDefaultAlertSound: Int = 1000
    @AppStorage(AppStorageKeys.isRegisteredUser.rawValue) var isRegisteredUser: Bool = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool
    {
        initializeFireBase()
        
        if isRegisteredUser
        {
            subscribeToPushNotifications(application)
            
            Messaging.messaging().delegate = self

            Messaging.messaging().token { token, error in

              if let error = error
              {
                print("Error fetching FCM registration token: \(error)")
              }
              else if let token = token
              {
                print("FCM registration token: \(token)")
              }
            }
        }
                                
        return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?)
    {
        print("Firebase registration token: \(String(describing: fcmToken))")

          let dataDict:[String: String] = ["token": fcmToken ?? ""]
          NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
          // TODO: If necessary send token to application server.
          // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
      Messaging.messaging().apnsToken = deviceToken
    }
    
    private func initializeFireBase()
    {
        FirebaseApp.configure()
    }
    
    private func subscribeToPushNotifications(_ application: UIApplication)
    {
        if #available(iOS 10.0, *)
        {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        }
        else
        {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
    }
}
