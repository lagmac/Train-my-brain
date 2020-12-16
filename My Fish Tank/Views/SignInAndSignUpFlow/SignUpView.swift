//
//  SignInView.swift
//  My Fish Tank
//
//  Created by Gino Preti on 02/12/20.
//

import SwiftUI

struct SignUpView: View
{
    @ObservedObject var viewModel = SignUpViewModel()
    @ObservedObject var fireBaseListener: FirebaseListenerViewModel
    
    @State var showPassword = false

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View
    {
        ZStack
        {
            VStack
            {
                Text(LocalizationManager.sign_up_page_title.localizedText)
                    .font(.custom("BrandonText-Bold", size: 42))
                    .foregroundColor(Color("title_brown"))
                
                HStack {
                    Text(LocalizationManager.sing_up_email_title.localizedText)
                        .font(.custom("BrandonText-Bold", size: 18))
                        .foregroundColor(Color("title_brown"))
                        .padding(.leading, 16)

                    Spacer()
                }
                .padding(.top, 10)
                
                HStack {
                    TextField(LocalizationManager.sign_up_email_hint.localizedText, text: $viewModel.email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .font(.custom("BrandonText-regular", size: 18))
                        .foregroundColor(Color("title_brown"))
                        .padding(.leading, 10)
                        .padding(.vertical, 16)
                        .onChange(of: viewModel.email, perform: { value in
                            
                            viewModel.validateInput()
                        })
                    
                    Spacer()
                }
                .background(Color("title_yellow"))
                .cornerRadius(10)
                .padding(.horizontal, 16)

                HStack {
                    Text(LocalizationManager.sign_up_password_title.localizedText)
                        .font(.custom("BrandonText-Bold", size: 18))
                        .foregroundColor(Color("title_brown"))
                        .padding(.leading, 16)
                    
                    Spacer()
                }
                .padding(.top, 15)
                
                ZStack
                {
                    HStack {
                        
                        if self.showPassword
                        {
                            TextField(LocalizationManager.sign_up_password_hint.localizedText, text: $viewModel.password)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .font(.custom("BrandonText-regular", size: 18))
                                .foregroundColor(Color("title_brown"))
                                .padding(.leading, 10)
                                .padding(.vertical, 16)
                                .onChange(of: viewModel.password, perform: { value in
                                    
                                    viewModel.validateInput()
                                })
                        }
                        else
                        {
                            SecureField(LocalizationManager.sign_up_password_hint.localizedText, text: $viewModel.password)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .font(.custom("BrandonText-regular", size: 18))
                                .foregroundColor(Color("title_brown"))
                                .padding(.leading, 10)
                                .padding(.vertical, 16)
                                .onChange(of: viewModel.password, perform: { value in
                                    
                                    viewModel.validateInput()
                                })
                        }

                        Spacer()
                        
                        Button(action: {
                            self.showPassword.toggle()
                        }, label: {
                            
                            Image(systemName: self.showPassword ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(Color("title_brown"))
                        })
                        .padding(.trailing, 10)
                    }
                    .background(Color("title_yellow"))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    
                }

                HStack
                {
                    Button(action: {
                        
                        viewModel.migrateToRegisterUser() { response in
                            
                            if response
                            {
                                self.fireBaseListener.addListener()
                            }
                        }

                    }, label: {
                        Text(LocalizationManager.btn_signup_title.localizedText)
                            .font(.custom("BrandonText-Bold", size: 38))
                            .foregroundColor(Color("title_yellow"))
                            .padding(.vertical, 4)
                            .frame(maxWidth: .infinity)
                            .background(Color("title_brown"))
                            .cornerRadius(15)
                    })
                    .disabled(!viewModel.isButtonEnabled())
                    .opacity(viewModel.isButtonEnabled() ? 1.0 : 0.7)
                }
                .padding(.top, 15)
                .padding(.horizontal, 50)
                
                HStack
                {
                    Image(systemName: viewModel.termsAndConditionsRead ? "checkmark.square" : "square")
                        .font(.title)
                        .foregroundColor(Color("title_yellow"))
                        .onTapGesture {

                            viewModel.termsAndConditionsRead.toggle()
                        }
                                        
                    Text(LocalizationManager.sign_up_terms_and_conditions_label_title.localizedText)
                        .font(.custom("BrandonText-Bold", size: 14))
                        .foregroundColor(Color.blue)
                        .padding(.vertical, 20)
                        .onTapGesture {
                            
                            self.viewModel.termsAndConditionsOpen.toggle()
                        }
                    
                    Spacer()
                    
                    Image(systemName: viewModel.privacyPolicyRead ? "checkmark.square" : "square")
                        .font(.title)
                        .foregroundColor(Color("title_yellow"))
                        .onTapGesture {

                            viewModel.privacyPolicyRead.toggle()
                        }
                                        
                    Text(LocalizationManager.sign_up_privacy_policy_label_title.localizedText)
                        .font(.custom("BrandonText-Bold", size: 14))
                        .foregroundColor(Color.blue)
                        .padding(.vertical, 20)
                        .onTapGesture {
                            
                            self.viewModel.pricavyPolicyOpen.toggle()
                        }
                }
                .padding(.horizontal, 16)
                
                Text(LocalizationManager.sign_up_page_disclaimer.localizedText)
                    .font(.custom("BrandonText-Bold", size: 14))
                    .foregroundColor(Color("title_brown"))
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                
                Spacer()
            }
            .padding(.top, 20)
            .background(Color.black.opacity(0.05).ignoresSafeArea())
            
            if self.viewModel.alertPresented
            {
                CustomAlert(message: viewModel.message, onFirstButtonTap: {
                    
                    self.viewModel.alertPresented.toggle()
                    presentationMode.wrappedValue.dismiss()
                })
            }
            
            if self.viewModel.termsAndConditionsOpen
            {
                TermsAndConditionsView(accepted: $viewModel.termsAndConditionsRead, termsAndConditionsOpen: $viewModel.termsAndConditionsOpen)
            }
            
            if self.viewModel.pricavyPolicyOpen
            {
                PrivacyPolicyView(accepted: $viewModel.privacyPolicyRead, pricavyPolicyOpen: $viewModel.pricavyPolicyOpen)
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(fireBaseListener: FirebaseListenerViewModel())
    }
}
