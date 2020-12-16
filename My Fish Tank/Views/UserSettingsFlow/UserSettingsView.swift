//
//  UserSettingsView.swift
//  My Fish Tank
//
//  Created by Gino Preti on 04/12/20.
//

import SwiftUI

struct UserSettingsView: View
{
    @ObservedObject var usvm = UserSettingsViewModel()
    
    @ObservedObject var roundViewModel: RoundViewModel
    
    @State var newUserName = ""
    @State var isEditingName: Bool = false
    @State var confirmDialog: Bool = false
    @State var selectSound: Bool = false
    @State var resetScore: Bool = false
    @State var deleteAccount: Bool = false
    @State var changePssowrd: Bool = false
    
    @State var selectedSound = 0
    
    //@AppStorage(AppStorageKeys.notificationOnOff.rawValue) var notificationOnOff: Bool = true
    
    var body: some View
    {
        ZStack
        {
            VStack
            {
                HStack {
                    Spacer()

                    Text(LocalizationManager.settings_view_title.localizedText)
                        .font(.custom("BrandonText-Bold", size: 42))
                        .foregroundColor(Color("title_brown"))

                    Spacer()
                }
                // Edit name section
                Group
                {
                    HStack
                    {
                        Text(LocalizationManager.settings_name_label_title.localizedText)
                            .font(.custom("BrandonText-Regular", size: 18))
                            .foregroundColor(Color("title_brown"))

                        if isEditingName
                        {
                            HStack {
                                TextField(LocalizationManager.settings_name_edit_placeholder.localizedText, text: $newUserName, onCommit: {
                                    self.confirmDialog.toggle()
                                })
                                .font(.custom("BrandonText-Regular", size: 18))
                                .foregroundColor(Color("title_brown"))
                                .padding(.leading, 10)
                                .padding(.vertical, 8)

                                Spacer()
                            }
                            .background(Color("title_yellow"))
                            .cornerRadius(10)
                        }
                        else
                        {
                            HStack {
                                Text(usvm.userName)
                                    .font(.custom("BrandonText-Regular", size: 16))
                                    .foregroundColor(Color("title_brown"))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 8)

                                Spacer()
                            }
                            .background(Color("title_yellow"))
                            .cornerRadius(10)
                        }

                        Spacer()

                        Image(systemName: "pencil.circle")
                            .font(.title)
                            .foregroundColor(Color("title_yellow"))
                            .onTapGesture {

                                self.isEditingName.toggle()
                            }
                    }
                    .padding(.top, 6)

                    HStack
                    {
                        Text(LocalizationManager.settings_email_label_title.localizedText)
                            .font(.custom("BrandonText-Regular", size: 18))
                            .foregroundColor(Color("title_brown"))

                        HStack {
                            Text(usvm.userEmail)
                                .font(.custom("BrandonText-Regular", size: 16))
                                .foregroundColor(Color("title_brown"))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 8)
                        }
                        .background(Color("title_yellow"))
                        .cornerRadius(10)
                        .offset(x: 4.0)

                        Spacer()
                    }
                    .padding(.top, 6)

                    HStack
                    {
                        Text(LocalizationManager.settings_uid_label_title.localizedText)
                            .font(.custom("BrandonText-Regular", size: 18))
                            .foregroundColor(Color("title_brown"))

                        HStack {
                            Text(usvm.uid)
                                .font(.custom("BrandonText-Regular", size: 16))
                                .foregroundColor(Color("title_brown"))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 8)
                        }
                        .background(Color("title_yellow"))
                        .cornerRadius(10)
                        .offset(x: 13.0)

                        Spacer()
                    }
                    .padding(.top, 6)
                }
                
                HStack()
                {
                    Capsule()
                        .frame(height: 1)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
                
                // Notification sound settings
                Group
                {
                    Toggle(LocalizationManager.settings_notification_toggle_title.localizedText,
                           isOn: $usvm.notificationOnOff)
                        .toggleStyle(SwitchToggleStyle(tint: Color("title_yellow")))
                        .font(.custom("BrandonText-Regular", size: 18))
                        .foregroundColor(Color("title_brown"))
                    
                    HStack
                    {
                        VStack
                        {
                            HStack
                            {
                                Text(LocalizationManager.settings_notification_sound_title.localizedText)
                                    .font(.custom("BrandonText-Regular", size: 18))
                                    .foregroundColor(Color("title_brown"))
                                
                                Spacer()
                                
                                Text("\((usvm.sounds[selectedSound] as NotificationSoundModel).name!)")
                                    .font(.custom("BrandonText-Bold", size: 18))
                                    .foregroundColor(Color("title_brown"))
                                    .padding(.trailing, 4)
                                
                                Image(systemName: "chevron.right.circle")
                                    .font(.title)
                                    .foregroundColor(Color("title_yellow"))
                                    .onTapGesture {

                                        if self.selectSound
                                        {
                                            usvm.notificationSound = selectedSound
                                            usvm.setNotificationSound()
                                        }
                                        
                                        self.selectSound.toggle()
                                    }
                            }
                            
                            if self.selectSound
                            {
                                Picker(selection: $selectedSound, label: Text(""), content: {

                                    ForEach(0..<usvm.sounds.count)
                                    {
                                        let s: NotificationSoundModel = usvm.sounds[$0]
                                        
                                        Text(s.name!).tag($0)
                                    }
                                })
                                .onChange(of: selectedSound, perform: { value in
                                    
                                    usvm.playSound(soundIndex: value)
                                })
                            }
                        }
                    }
                    .padding(.top, 6)
                }

                HStack()
                {
                    Capsule()
                        .frame(height: 1)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
                
                Group
                {
                    VStack
                    {
                        HStack
                        {
                            Text(LocalizationManager.settings_reset_score_label_title.localizedText)
                                .font(.custom("BrandonText-Regular", size: 18))
                                .foregroundColor(Color("title_brown"))
                            
                            Spacer()
                            
                            Button(action: {
                                
                                self.resetScore.toggle()
                                
                            }, label: {
                                Text(LocalizationManager.settings_reset_score_button_title.localizedText)
                                    .font(.custom("BrandonText-Bold", size: 18))
                                    .foregroundColor(Color("title_yellow"))
                                    .frame(width: 100)
                                    .padding(.vertical, 6)
                                    .background(Color.red)
                                    .cornerRadius(15)
                            })
                        }
                        
                        HStack
                        {
                            Text(LocalizationManager.settings_delete_account_label_title.localizedText)
                                .font(.custom("BrandonText-Regular", size: 18))
                                .foregroundColor(Color("title_brown"))
                            
                            Spacer()
                            
                            Button(action: {
                                
                                self.deleteAccount.toggle()
                                
                            }, label: {
                                Text(LocalizationManager.settings_delete_account_button_title.localizedText)
                                    .font(.custom("BrandonText-Bold", size: 18))
                                    .foregroundColor(Color("title_yellow"))
                                    .frame(width: 100)
                                    .padding(.vertical, 6)
                                    .background(Color.red)
                                    .cornerRadius(15)
                                    
                            })
                        }
                        .padding(.top, 10)
                        
                        HStack
                        {
                            Text(LocalizationManager.settings_change_password_label_title.localizedText)
                                .font(.custom("BrandonText-Regular", size: 18))
                                .foregroundColor(Color("title_brown"))
                            
                            Spacer()
                            
                            Button(action: {
                                
                                self.changePssowrd.toggle()
                                
                            }, label: {
                                Text(LocalizationManager.settings_change_password_button_title.localizedText)
                                    .font(.custom("BrandonText-Bold", size: 18))
                                    .foregroundColor(Color("title_yellow"))
                                    .frame(width: 100)
                                    .padding(.vertical, 6)
                                    .background(Color.red)
                                    .cornerRadius(15)
                            })
                        }
                        .padding(.top, 10)
                    }
                }
                
                HStack()
                {
                    Capsule()
                        .frame(height: 1)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding(.top, 20)

            if confirmDialog
            {
                CustomAlert(message: LocalizationManager.alert_update_user_name_confirmation.localizedText,
                            hasTowButton: true,
                            leftButtonTitle: LocalizationManager.btn_close_title.localizedText,
                            rightButtonTitle: LocalizationManager.btn_confirm_title.localizedText,
                            isFirstButtondestructive: false,
                            isSecondButtondestructive: true,
                            onFirstButtonTap: {
                                self.newUserName = ""
                                self.isEditingName.toggle()
                                self.confirmDialog.toggle()
                            }, onSecondButtonTap: {
                                usvm.updateUserName(withName: newUserName)
                                self.confirmDialog.toggle()
                            })
            }
            
            if usvm.updateNameEnded
            {
                CustomAlert(message: usvm.updateNameSuccess ?
                                LocalizationManager.alert_update_user_name_success.localizedText : LocalizationManager.alert_update_user_name_failed.localizedText,
                            hasTowButton: false,
                            rightButtonTitle: LocalizationManager.btn_close_title.localizedText,
                            onFirstButtonTap: {
                                self.newUserName = ""
                                self.isEditingName.toggle()
                                self.usvm.updateNameEnded = false
                            })
            }
            
            if resetScore
            {
                CustomAlert(message: LocalizationManager.alert_reset_score.localizedText,
                            hasTowButton: true,
                            leftButtonTitle: LocalizationManager.btn_close_title.localizedText,
                            rightButtonTitle: LocalizationManager.btn_confirm_title.localizedText,
                            isFirstButtondestructive: false,
                            isSecondButtondestructive: true,
                            onFirstButtonTap: {

                                self.resetScore.toggle()
                            }, onSecondButtonTap: {
                                usvm.resetScore { result in
                                    
                                    roundViewModel.getRounds(completion: {
                                        
                                        self.resetScore.toggle()
                                    })
                                }
                            })
            }
            
            if deleteAccount
            {
                CustomAlert(message: LocalizationManager.alert_delete_account.localizedText,
                            hasTowButton: true,
                            leftButtonTitle: LocalizationManager.btn_close_title.localizedText,
                            rightButtonTitle: LocalizationManager.btn_confirm_title.localizedText,
                            isFirstButtondestructive: false,
                            isSecondButtondestructive: true,
                            onFirstButtonTap: {

                                self.deleteAccount.toggle()
                            }, onSecondButtonTap: {
                                
                                self.deleteAccount.toggle()
                            })
            }
            
            if changePssowrd
            {
                ChangePasswordAlert(changePasswordOpen: $changePssowrd)
            }
        }
        .padding(.horizontal,20)
        .onAppear(perform: {
            
            usvm.getUserInfo()
            
            self.selectedSound = usvm.getNotificationSound()
            
            //notificationOnOff = UserDefaults.standard.bool(forKey: "notificationOnOff")
        })
    }
}

struct UserSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingsView(roundViewModel: RoundViewModel())
    }
}
