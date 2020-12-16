//
//  ChangePasswordAlert.swift
//  My Fish Tank
//
//  Created by Gino Preti on 10/12/20.
//

import SwiftUI

struct ChangePasswordAlert: View
{
    @State var currentPassword: String = ""
    @State var newPassword = ""
    @State var confirmPassword = ""
    
    @State var showCurrentPassword = false
    @State var showNewPassword = false
    @State var showConfirmPassword = false
    
    @Binding var changePasswordOpen: Bool
    
    @StateObject var viewModel = ChangePasswordAlertViewModel()
    
    var onButtonTap: (String) -> (Void) = {_ in }
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                VStack(spacing: 20)
                {
                    HStack
                    {
                        Text(LocalizationManager.settings_change_password_alert_title.localizedText)
                            .font(.custom("BrandonText-Bold", size: 28))
                            .foregroundColor(Color("title_brown"))
                    }
                    .padding(.horizontal, 50)
                    .padding(.vertical, 10)
                    
                    HStack {
                        
                        if showCurrentPassword
                        {
                            TextField(LocalizationManager.settings_change_password_current_password_hint.localizedText, text: $currentPassword)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .font(.custom("BrandonText-regular", size: 18))
                                .foregroundColor(Color("title_brown"))
                                .padding(.leading, 10)
                                .padding(.vertical, 16)
                                .onChange(of: currentPassword, perform: { value in
                                    
                                    self.viewModel.validate(currentPassword, newPwd: newPassword, confirmPwd: confirmPassword)
                                })
                        }
                        else
                        {
                            SecureField(LocalizationManager.settings_change_password_current_password_hint.localizedText, text: $currentPassword)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .font(.custom("BrandonText-regular", size: 18))
                                .foregroundColor(Color("title_brown"))
                                .padding(.leading, 10)
                                .padding(.vertical, 16)
                                .onChange(of: currentPassword, perform: { value in
                                    
                                    self.viewModel.validate(currentPassword, newPwd: newPassword, confirmPwd: confirmPassword)
                                })
                        }
                        
                        Button(action: {
                            self.showCurrentPassword.toggle()
                        }, label: {
                            
                            Image(systemName: self.showCurrentPassword ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(Color("title_brown"))
                        })
                        .padding(.trailing, 10)
                        
                        Spacer()
                    }
                    .background(Color("title_yellow"))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    
                    HStack {
                        
                        if self.showNewPassword
                        {
                            TextField(LocalizationManager.settings_change_password_new_password_hint.localizedText, text: $newPassword)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .font(.custom("BrandonText-regular", size: 18))
                                .foregroundColor(Color("title_brown"))
                                .padding(.leading, 10)
                                .padding(.vertical, 16)
                                .onChange(of: newPassword, perform: { value in
                                    
                                    self.viewModel.validate(currentPassword, newPwd: newPassword, confirmPwd: confirmPassword)
                                })
                        }
                        else
                        {
                            SecureField(LocalizationManager.settings_change_password_new_password_hint.localizedText, text: $newPassword)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .font(.custom("BrandonText-regular", size: 18))
                                .foregroundColor(Color("title_brown"))
                                .padding(.leading, 10)
                                .padding(.vertical, 16)
                                .onChange(of: newPassword, perform: { value in
                                    
                                    self.viewModel.validate(currentPassword, newPwd: newPassword, confirmPwd: confirmPassword)
                                })
                        }
                        
                        Button(action: {
                            self.showNewPassword.toggle()
                        }, label: {
                            
                            Image(systemName: self.showNewPassword ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(Color("title_brown"))
                        })
                        .padding(.trailing, 10)
                        
                        Spacer()
                    }
                    .background(Color("title_yellow"))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    
                    HStack {
                        
                        if self.showConfirmPassword
                        {
                            TextField(LocalizationManager.settings_change_password_confirm_password_hint.localizedText, text: $confirmPassword)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .font(.custom("BrandonText-regular", size: 18))
                                .foregroundColor(Color("title_brown"))
                                .padding(.leading, 10)
                                .padding(.vertical, 16)
                                .onChange(of: confirmPassword, perform: { value in
                                    
                                    self.viewModel.validate(currentPassword, newPwd: newPassword, confirmPwd: confirmPassword)
                                })
                        }
                        else
                        {
                            SecureField(LocalizationManager.settings_change_password_confirm_password_hint.localizedText, text: $confirmPassword)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .font(.custom("BrandonText-regular", size: 18))
                                .foregroundColor(Color("title_brown"))
                                .padding(.leading, 10)
                                .padding(.vertical, 16)
                                .onChange(of: confirmPassword, perform: { value in
                                    
                                    self.viewModel.validate(currentPassword, newPwd: newPassword, confirmPwd: confirmPassword)
                                })
                        }
                        
                        Button(action: {
                            self.showConfirmPassword.toggle()
                        }, label: {
                            
                            Image(systemName: self.showConfirmPassword ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(Color("title_brown"))
                        })
                        .padding(.trailing, 10)
                        
                        Spacer()
                    }
                    .background(Color("title_yellow"))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    
                    HStack {
                        Text(LocalizationManager.settings_change_password_alert_disclaimer.localizedText)
                            .multilineTextAlignment(.center)
                            .font(.custom("BrandonText-Regular", size: 18))
                            .foregroundColor(Color("title_brown"))
                    }
                    .padding(.horizontal, 10)
                    
                    HStack(spacing: 20)
                    {
                        Button(action: {
                                                
                            self.changePasswordOpen.toggle()
                            
                        }, label: {
                            Text(LocalizationManager.btn_close_title.localizedText)
                                .font(.custom("BrandonText-Bold", size: 22))
                                .foregroundColor(Color("title_yellow"))
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color("title_brown"))
                                .cornerRadius(15)
                        })
                                                
                        Button(action: {
                                                
                            viewModel.sendChangePasswordRequest(password: newPassword)
                            self.changePasswordOpen.toggle()
                            
                        }, label: {
                            Text(LocalizationManager.btn_send_title.localizedText)
                                .font(.custom("BrandonText-Bold", size: 22))
                                .foregroundColor(Color("title_yellow"))
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.red)
                                .cornerRadius(15)
                        })
                        .disabled(viewModel.isInputValid ? false : true)
                        .opacity(viewModel.isInputValid ? 1.0: 0.5)
                    }
                    .padding(.vertical, 30)
                    .padding(.horizontal, 30)
                }
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 10)
            }
            .padding(.horizontal, 15)
            
            Spacer()
        }
    }
}

struct ChangePasswordAlert_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordAlert(changePasswordOpen: .constant(true))
    }
}
