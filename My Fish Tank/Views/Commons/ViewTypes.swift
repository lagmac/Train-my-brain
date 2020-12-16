//
//  ViewTypes.swift
//  My Fish Tank
//
//  Created by Gino Preti on 02/12/20.
//

import Foundation

struct ViewTypes: Identifiable
{
    var id = "ciao"
    var vt: ViewTypesEnum = .none
}

enum ViewTypesEnum: String
{
    case none
    case signInView
    case questionView
    case logoutView
    case settingsView
    case leaderboard
    case signUpView
}
