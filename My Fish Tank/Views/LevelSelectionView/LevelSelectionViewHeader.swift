//
//  LevelSelectionViewHeader.swift
//  My Fish Tank
//
//  Created by Gino Preti on 28/11/20.
//

import SwiftUI
import Foundation
import AVFoundation

struct LevelSelectionViewHeader: View
{    
    @ObservedObject var parentViewModel: LevelSelectionViewModel
    @ObservedObject var levelListener: FirebaseListenerViewModel

    var body: some View
    {
        ZStack {

            HStack
            {
                if parentViewModel.isRegisteredUser
                {
                    Image(systemName: levelListener.newRoundAdded ? "bell.fill" : "bell")
                        .font(.title)
                        .foregroundColor(Color("title_yellow"))
                        .padding(.top)
                        .padding(.leading, 12)
                        .onTapGesture {

                            self.parentViewModel.onNotificationTap()
                    }
                }
                
                Spacer()
            }
            .disabled(levelListener.newRoundAdded ? false : true)
            
            
            HStack {
                Text(LocalizationManager.app_title.localizedText)
                    .font(.custom("BrandonText-Bold", size: 42))
                    .foregroundColor(Color("title_brown"))
                    .padding(.top)
            }
            
            HStack {
                
                Spacer()
                
                if parentViewModel.isRegisteredUser
                {
                    Image(systemName: "line.horizontal.3")
                        .font(.largeTitle)
                        .foregroundColor(Color("title_yellow"))
                        .padding(.top)
                        .padding(.trailing, 12)
                        .onTapGesture {
                            
                            self.parentViewModel.onSettingsTap()
                    }
                }
                else
                {
                    Image(systemName: "gear")
                        .font(.title)
                        .foregroundColor(Color("title_yellow"))
                        .padding(.top)
                        .padding(.trailing, 12)
                        .onTapGesture {
                            
                            self.parentViewModel.onSettingsTap()
                    }
                }
            }
        }
        
        Text(LocalizationManager.level_selection_sub_text.localizedText)
            .font(.custom("BrandonText-Regular", size: 28))
            .foregroundColor(Color("title_yellow"))
            .padding(.top, 4)
            .multilineTextAlignment(.center)
    }
}

