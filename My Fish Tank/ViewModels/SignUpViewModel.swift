//
//  SignInViewModel.swift
//  My Fish Tank
//
//  Created by Gino Preti on 10/12/20.
//

import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject
{
    @AppStorage(AppStorageKeys.isRegisteredUser.rawValue) var isRegisteredUser: Bool = false
    
    @Published var message: String = ""
    
    @Published var alertPresented: Bool = false
    @Published var termsAndConditionsOpen: Bool = false
    @Published var pricavyPolicyOpen: Bool = false
    
    @Published var termsAndConditionsRead: Bool = false
    @Published var privacyPolicyRead: Bool = false
    
    @Published var email = ""
    @Published var password = ""
    
    private var isValidInput: Bool = false
        
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
    
    func isButtonEnabled() -> Bool
    {
        return isValidInput && termsAndConditionsRead && privacyPolicyRead
    }
    
    func migrateToRegisterUser(_ completion: @escaping ((Bool)->Void))
    {
        FireBaseHelper.migrateToRegisterUser(withUserName: email,
                                             password: password,
                                             completion: { result in
                                                
                                                if result
                                                {
                                                    self.message = LocalizationManager.alert_signIn_success.localizedText
                                                    self.isRegisteredUser = true
                                                }
                                                else
                                                {
                                                    self.message = LocalizationManager.alert_sigIn_failed.localizedText
                                                }
                                                
                                                self.alertPresented.toggle()
                                                
                                                completion(result)
                                             })
    }
}
