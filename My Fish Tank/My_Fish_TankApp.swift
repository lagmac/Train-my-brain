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

class Delegate : NSObject, UIApplicationDelegate
{    
    @AppStorage(AppStorageKeys.newLevelAddedDefaultAlertSound.rawValue) var newLevelAddedDefaultAlertSound: Int = 1000
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool
    {
        initializeFireBase()
                        
        return true
    }
    
    private func initializeFireBase()
    {
        FirebaseApp.configure()
    }
}
