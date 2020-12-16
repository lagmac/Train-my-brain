//
//  UIApplicationExtensions.swift
//  My Fish Tank
//
//  Created by Gino Preti on 14/12/20.
//

import Foundation
import SwiftUI

extension UIApplication
{
    static var appVersion: String?
    {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    static var appBuild: String?
    {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
}
