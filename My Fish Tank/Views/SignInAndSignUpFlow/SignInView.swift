//
//  SignInView.swift
//  My Fish Tank
//
//  Created by Gino Preti on 10/12/20.
//

import SwiftUI

struct SignInView: View
{
    @ObservedObject var viewModel = SignInViewModel()
    
    @State var showPassword = false
    
    var onSignIn: () -> (Void) = {}
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View
    {
        ZStack
        {
            VStack
            {
                Text(LocalizationManager.sign_in_page_title.localizedText)
                    .font(.custom("BrandonText-Bold", size: 42))
                    .foregroundColor(Color("title_brown"))
                
                HStack {
                    Text(LocalizationManager.sing_up_email_title.localizedText)
                        .font(.custom("BrandonText-Bold", size: 18))
                        .foregroundColor(Color("title_brown"))
                        .padding(.leading, 16)

                    Spacer()
                }
                .padding(.top, 30)
                
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
                .padding(.top, 30)
                
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

                HStack
                {
                    Button(action: {
                        
                        viewModel.signin() { result in

                            if result
                            {
                                onSignIn()
                                presentationMode.wrappedValue.dismiss()
                            }
                            else
                            {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                        
                    }, label: {
                        Text(LocalizationManager.btn_signin_title.localizedText)
                            .font(.custom("BrandonText-Bold", size: 38))
                            .foregroundColor(Color("title_yellow"))
                            .padding(.vertical, 4)
                            .frame(maxWidth: .infinity)
                            .background(Color("title_brown"))
                            .cornerRadius(15)
                    })
                    .disabled(viewModel.isValidInput ? false : true)
                    .opacity(viewModel.isValidInput ? 1.0 : 0.7)
                }
                .padding(.top, 15)
                .padding(.horizontal, 50)
                
                Spacer()
                
                Text(LocalizationManager.sign_in_forgot_password_label_title.localizedText)
                    .font(.custom("BrandonText-Bold", size: 18))
                    .foregroundColor(Color("title_brown"))
                    .onTapGesture {
                        
                        viewModel.onForgotPassword.toggle()
                    }
            }
            .padding(.top, 20)
            .background(Color.black.opacity(0.05).ignoresSafeArea())
            
            if self.viewModel.onForgotPassword
            {                
                ForgotPasswordAlert(email: $viewModel.email,
                                    forgotPasswordOpen: $viewModel.onForgotPassword) { email in

                    viewModel.forgotPassword()
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
