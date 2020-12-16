//
//  ForgotPasswordAlert.swift
//  My Fish Tank
//
//  Created by Gino Preti on 10/12/20.
//

import SwiftUI

struct ForgotPasswordAlert: View
{    
    @Binding var email: String
    
    @Binding var forgotPasswordOpen: Bool
    
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
                        Text(LocalizationManager.sign_in_forgot_password_alert_title.localizedText)
                            .font(.custom("BrandonText-Bold", size: 28))
                            .foregroundColor(Color("title_brown"))
                    }
                    .padding(.horizontal, 50)
                    .padding(.vertical, 10)
                    
                    HStack {
                        TextField(LocalizationManager.sign_up_email_hint.localizedText, text: $email)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .font(.custom("BrandonText-regular", size: 18))
                            .foregroundColor(Color("title_brown"))
                            .padding(.leading, 10)
                            .padding(.vertical, 16)
                        
                        Spacer()
                    }
                    .background(Color("title_yellow"))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    
                    HStack {
                        Text(LocalizationManager.sign_in_forgot_password_alert_message.localizedText)
                            .multilineTextAlignment(.center)
                            .font(.custom("BrandonText-Regular", size: 18))
                            .foregroundColor(Color("title_brown"))
                    }
                    .padding(.horizontal, 10)
                    
                    HStack(spacing: 20)
                    {
                        Button(action: {
                                                
                            self.forgotPasswordOpen.toggle()
                            
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
                                                
                            onButtonTap(email)
                            
                        }, label: {
                            Text(LocalizationManager.btn_send_title.localizedText)
                                .font(.custom("BrandonText-Bold", size: 22))
                                .foregroundColor(Color("title_yellow"))
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.red)
                                .cornerRadius(15)
                        })
                        .disabled(Validations.isValidEmail(email) ? false : true)
                        .opacity(Validations.isValidEmail(email) ? 1.0 : 0.5)
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

struct ForgotPasswordAlert_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordAlert(email: .constant(""), forgotPasswordOpen: .constant(true))
    }
}
