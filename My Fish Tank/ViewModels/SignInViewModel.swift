//
//  SignInViewModel.swift
//  My Fish Tank
//
//  Created by Gino Preti on 10/12/20.
//

import Foundation
import SwiftUI

class SignInViewModel: ObservableObject
{
    @AppStorage(AppStorageKeys.isRegisteredUser.rawValue) var isRegisteredUser: Bool = false
    
    @Published var message: String = ""
    @Published var isValidInput: Bool = false
    
    @Published var email = ""
    @Published var password = ""
    @Published var onForgotPassword: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    func validateInput()
    {
        var v1: Bool = false
        var v2: Bool = false
        
        if email.isEmpty == false
        {
            if Validations.isValidEmail(email)
            {
                v1 = true
            }
            else
            {
                v1 = false
            }
        }
        
        if password.isEmpty == false
        {
            if Validations.isValidPassword(password)
            {
                v2 = true
            }
            else
            {
                v2 = false
            }
        }
        
        isValidInput = v1 && v2
    }
    
    func signin(_ completion: @escaping ((Bool)->Void))
    {
        FireBaseHelper.signInUser(withEmail: email, password: password) { (result) in
            
            if result
            {
                completion(true)
            }
            else
            {
                completion(false)
            }
        }
    }
    
    func forgotPassword() //_ completion: @escaping ((Bool)->Void))
    {
        FireBaseHelper.forgotPassword(email: email, completion: { result in
            
            if result
            {
                //completion(true)
                print("EMAIL SENT !!!")
            }
            else
            {
                //completion(false)
                print("ERROR SENDING EMAIL !!!!")
            }
            
            self.email = ""
            
            self.onForgotPassword.toggle()
        })
    }
}
