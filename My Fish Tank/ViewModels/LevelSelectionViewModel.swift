//
//  LevelSelectionViewModel.swift
//  My Fish Tank
//
//  Created by Gino Preti on 10/12/20.
//

import Foundation
import SwiftUI

class LevelSelectionViewModel: ObservableObject
{
    @AppStorage(AppStorageKeys.isRegisteredUser.rawValue) var isRegisteredUser: Bool = false
    @AppStorage(AppStorageKeys.firstlaunch.rawValue) var firstlaunch: Bool = true
    @AppStorage(AppStorageKeys.notificationOnOff.rawValue) var notificationOnOff: Bool = true
    
    @ObservedObject var roundViewModel = RoundViewModel()
    @ObservedObject var firebaseListener = FirebaseListenerViewModel()
    
    @Published var set = "Round_1"
    
    @Published var viewType: ViewTypes? = nil
    @Published var alertMessage: String = ""
    @Published var twoButtonAlert: Bool = false
    @Published var activateBell: Bool = false
    @Published var closeAlert: Bool = false
    @Published var signOutAlert: Bool = false
    @Published var firstLauchAlert: Bool = false
    
    @Published var slideMenu: Bool = false
    
    func onFirstLaunchDisclaimer()
    {
        self.firstLauchAlert.toggle()
    }
        
    func onFirstButtonCloseAlert()
    {
        if twoButtonAlert
        {
            twoButtonAlert.toggle()
        }

        self.closeAlert.toggle()
    }
    
    func onFirstButtonTapSignOutAlert()
    {
        if twoButtonAlert
        {
            twoButtonAlert.toggle()
        }

        self.signOutAlert.toggle()
    }
    
    func onSecondButtonTapSignOutAlert()
    {
        FireBaseHelper.signoutUser() { result in
            
            if result
            {
                if self.twoButtonAlert
                {
                    self.twoButtonAlert.toggle()
                }
                
                self.signOutAlert.toggle()
                self.slideMenu.toggle()
            }
            else
            {
                if self.twoButtonAlert
                {
                    self.twoButtonAlert.toggle()
                }
                
                self.signOutAlert.toggle()
            }
        }
    }
    
    func OnFirstButtonTapNewRoundNotification()
    {
        self.twoButtonAlert.toggle()
        self.activateBell.toggle()
        
        self.firebaseListener.newRoundAdded = false
    }
    
    func OnSecondButtonTapNewRoundNotification()
    {
        self.twoButtonAlert.toggle()
        self.activateBell.toggle()
        
        FireBaseHelper.fetchNewRounds(completion: { result in
                                
            self.roundViewModel.getRounds(completion: {
                
                if result
                {
                    self.alertMessage = LocalizationManager.alert_new_level.localizedText
                    self.closeAlert.toggle()
                }
                else
                {
                    self.alertMessage = LocalizationManager.alert_level_uptodate.localizedText
                    self.closeAlert.toggle()
                }
            })
        })
        
        self.firebaseListener.newRoundAdded = false
    }
    
    func onViewAppear()
    {
        if isRegisteredUser
        {
            FireBaseHelper.fetchNewRounds(completion: { result in

                self.roundViewModel.getRounds(completion: {

                    if result
                    {
                        self.alertMessage = LocalizationManager.alert_new_level.localizedText
                        self.closeAlert.toggle()
                    }

                    self.firebaseListener.addListener()
                })
            })
        }
        else
        {
            FireBaseHelper.createUserCollection(isFirstLaunch: firstlaunch) { (result) in

                if result
                {
                    self.roundViewModel.getRounds()
                    
                    if self.firstlaunch
                    {
                        self.firstLauchAlert.toggle()
                        self.firstlaunch = false
                    }
                }
            }
        }
    }
    
    func onSignInView()
    {
        FireBaseHelper.fetchNewRounds(completion: { result in

            self.roundViewModel.getRounds(completion: {

                if result
                {
                    self.alertMessage = LocalizationManager.alert_new_level.localizedText
                    self.closeAlert.toggle()
                }

                self.firebaseListener.addListener()
            })
        })

    }
    
    func onSettingsTap()
    {
        if isRegisteredUser
        {
            if FireBaseHelper.isUserSignedIn()
            {
                self.slideMenu.toggle()
            }
            else
            {
                viewType = ViewTypes(vt: .signInView)
            }
        }
        else
        {
            viewType = ViewTypes(vt: .signUpView)
        }
    }
    
    func onNotificationTap()
    {
        self.alertMessage = LocalizationManager.alert_new_level_added.localizedText
        self.twoButtonAlert.toggle()
        self.activateBell.toggle()
    }
    
    func fetchNewRounds()
    {
        FireBaseHelper.fetchNewRounds(completion: { result in
                                
            self.roundViewModel.getRounds(completion: {
                
                if result
                {
                    self.alertMessage = LocalizationManager.alert_new_level.localizedText
                    self.closeAlert.toggle()
                }
                else
                {
                    self.alertMessage = LocalizationManager.alert_level_uptodate.localizedText
                    self.closeAlert.toggle()
                }
            })
        })
    }
    
    func setSet(index: Int)
    {
        self.set = roundViewModel.rounds[index].name!
    }
    
    func isRoundLoaded() -> Bool
    {
        return !roundViewModel.rounds.isEmpty
    }
    
    func roundCount() -> Int
    {
        return roundViewModel.rounds.count
    }
    
    func getRoundModel(index: Int) -> RoundModel
    {
        return roundViewModel.rounds[index]
    }
}
