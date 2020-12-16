//
//  UserSettingsViewModel.swift
//  My Fish Tank
//
//  Created by Gino Preti on 07/12/20.
//

import Foundation
import AVFoundation
import SwiftUI

class UserSettingsViewModel: ObservableObject
{
    @Published var userName: String = ""
    @Published var userEmail: String = ""
    @Published var uid: String = ""
    
    @Published var updateNameEnded: Bool = false
    @Published var updateNameSuccess: Bool = false
    
    @Published var notificationSound: Int = 0
    
    @AppStorage(AppStorageKeys.notificationOnOff.rawValue) var notificationOnOff: Bool = true
    @AppStorage(AppStorageKeys.newLevelAddedDefaultAlertSound.rawValue) var newLevelAddedDefaultAlertSound: Int = 1000
    @AppStorage(AppStorageKeys.lastScore.rawValue) var lastScore: Int = 0

    var sounds = NotificationSoundsList.getSounsNotificationList()
    
    func getUserInfo()
    {
        if let userModel = FireBaseHelper.getUserInfo()
        {
            userName = userModel.displayName != nil ? userModel.displayName! : LocalizationManager.settings_anonymous_username_title.localizedText
            userEmail = userModel.email!
            uid = userModel.uid!
        }
    }
    
    func updateUserName(withName name: String)
    {
        FireBaseHelper.updateUserName(withName: name) { result in
            
            if result
            {
                self.userName = name
            }
            
            self.updateNameEnded = true
            self.updateNameSuccess = result
        }
    }
    
    func setNotifications(active: Bool)
    {
        notificationOnOff = active
    }
    
    func setNotificationSound()
    {
        newLevelAddedDefaultAlertSound = sounds[notificationSound].id!
    }
    
    func getNotificationSound() -> Int
    {        
        var counter = 0
        
        for s in sounds
        {
            if s.id! == newLevelAddedDefaultAlertSound
            {
                break
            }
            
            counter += 1
        }
        
        return counter
    }
    
    func playSound(soundIndex: Int)
    {
        let soundId = sounds[soundIndex].id!
        
        let systemSoundID: SystemSoundID = UInt32(soundId)
        AudioServicesPlaySystemSound(systemSoundID)
    }
    
    func resetScore(completion: @escaping ((Bool)->Void))
    {
        // 1 - remove record from leaderboard
        FireBaseHelper.removeScoreFromLeaderboard(completion: { (leaderboardResult) in
            
            if leaderboardResult
            {
                // 2 - reset all rounds by setting correctAnswer = 0, wrongAnswer = 0, completed = false, enable = false except for the Round_1
                FireBaseHelper.resetAllRounds { (resetRoundResult) in
                    
                    // 3 - reset user default score
                    if resetRoundResult
                    {
                        self.lastScore = 0
                        completion(true)
                    }
                    else
                    {
                        print("RESET ROUNDS ERROR !!!")
                        completion(false)
                    }
                }
            }
            else
            {
                print("REMOVE SCORE FROM LEADERBOARD ERROR !!!")
                completion(false)
            }
        })
    }
}

