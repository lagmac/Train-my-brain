//
//  ContentView.swift
//  My Fish Tank
//
//  Created by Gino Preti on 18/11/20.
//

import SwiftUI
import Firebase

struct ContentView: View
{
    @AppStorage(AppStorageKeys.firstlaunch.rawValue) var firstlaunch: Bool = true
    @AppStorage(AppStorageKeys.isRegisteredUser.rawValue) var isRegisteredUser: Bool = false
        
    var body: some View
    {
        LevelSelectionView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
