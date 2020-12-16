//
//  ChangePasswordAlertViewModel.swift
//  My Fish Tank
//
//  Created by Gino Preti on 11/12/20.
//

import Foundation

class ChangePasswordAlertViewModel: ObservableObject
{
    @Published var isInputValid: Bool = false
    
    func sendChangePasswordRequest(password: String)
    {
        FireBaseHelper.changePassword(withNewPassword: password)
    }
    
    func validate(_ currentPwd: String, newPwd: String, confirmPwd: String)
    {
        var v1: Bool = false
        var v2: Bool = false
        var v3: Bool = false
        var v4: Bool = false
        
        if currentPwd.isEmpty == false
        {
            if Validations.isValidPassword(currentPwd)
            {
                v1 = true
            }
            else
            {
                v1 = false
            }
        }
        
        if newPwd.isEmpty == false
        {
            if Validations.isValidPassword(newPwd)
            {
                v2 = true
            }
            else
            {
                v2 = false
            }
        }
        
        if confirmPwd.isEmpty == false
        {
            if Validations.isValidPassword(confirmPwd)
            {
                v3 = true
            }
            else
            {
                v3 = false
            }
        }
        
        if newPwd.isEmpty == false && confirmPwd.isEmpty == false
        {
            if newPwd == confirmPwd
            {
                v4 = true
            }
            else
            {
                v4 = false
            }
        }
        
        isInputValid = v1 && v2 && v3 && v4
    }
    
}
