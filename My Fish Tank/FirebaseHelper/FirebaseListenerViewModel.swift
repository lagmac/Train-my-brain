//
//  FirebaseListenerViewModel.swift
//  My Fish Tank
//
//  Created by Gino Preti on 05/12/20.
//

import Foundation
import AVFoundation
import SwiftUI

class FirebaseListenerViewModel: ObservableObject
{
    @Published var newRoundAdded: Bool = false
    
    @AppStorage(AppStorageKeys.notificationOnOff.rawValue) var notificationOnOff: Bool = true
    @AppStorage(AppStorageKeys.newLevelAddedDefaultAlertSound.rawValue) var newLevelAddedDefaultAlertSound: Int = 1000
        
    func addListener()
    {
        FireBaseHelper.AddListener() { result in
            
            if self.notificationOnOff
            {
                if self.newRoundAdded == false
                {
                    self.newRoundAdded = result
                    let systemSoundID: SystemSoundID = UInt32(self.newLevelAddedDefaultAlertSound)
                    AudioServicesPlaySystemSound(systemSoundID)
                }
            }
        }
    }
}
