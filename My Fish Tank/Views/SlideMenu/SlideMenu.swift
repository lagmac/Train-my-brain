//
//  SignOutView.swift
//  My Fish Tank
//
//  Created by Gino Preti on 02/12/20.
//

import SwiftUI

struct SlideMenu: View
{
    @ObservedObject var parentViewModel: LevelSelectionViewModel

    @State var isSwipping: Bool = false
    @State var startSwipePos: CGPoint = CGPoint.zero
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                Text(LocalizationManager.slide_menu_title.localizedText)
                    .font(.custom("BrandonText-Bold", size: 42))
                    .foregroundColor(Color("title_brown"))
            }
            .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 28)
            {
                MenuRow(rowIconName: "settings_icon", rowTitle: LocalizationManager.slide_menu_settings_title.localizedText) {
                    
                    parentViewModel.slideMenu.toggle()
                    parentViewModel.viewType = ViewTypes(vt: .settingsView)
                }
                
                MenuRow(rowIconName: "update_icon", rowTitle: LocalizationManager.slide_menu_chek_new_level.localizedText) {
                    
                    parentViewModel.fetchNewRounds()
                }
                
                MenuRow(rowIconName: "leaderboard_icon", rowTitle: LocalizationManager.slide_menu_leaderboard_title.localizedText) {
                    
                    parentViewModel.slideMenu.toggle()
                    parentViewModel.viewType = ViewTypes(vt: .leaderboard)
                }
                
                MenuRow(rowIconName: "exit_icon", rowTitle: LocalizationManager.slide_menu_signout_title.localizedText) {
                    
                    parentViewModel.alertMessage = LocalizationManager.alert_signout.localizedText;
                    parentViewModel.twoButtonAlert.toggle()
                    parentViewModel.signOutAlert.toggle()
                }

                Spacer()
            }
            
            SideMenuFooter()

            Spacer()
        }
        .padding(.vertical, 30)
        .background(Color.white)
        .padding(.trailing, 100)
        .offset(x: parentViewModel.slideMenu ? 0 : -UIScreen.main.bounds.width)
        .animation(.default)
        .gesture(DragGesture()
                    .onChanged { gesture in
                        
                        if isSwipping
                        {
                            self.startSwipePos = gesture.location
                            self.isSwipping.toggle()
                        }
                        
                    }
                    .onEnded { gesture in
                        
                        let xDist =  abs(gesture.location.x - self.startSwipePos.x)
                        let yDist =  abs(gesture.location.y - self.startSwipePos.y)
                        
                        if self.startSwipePos.x > gesture.location.x && yDist < xDist
                        {
                            parentViewModel.slideMenu.toggle()
                        }

                        self.isSwipping.toggle()
                    })
        .onTapGesture {
            parentViewModel.slideMenu.toggle()
        }
        .edgesIgnoringSafeArea(.vertical)
    }
}

struct SlideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenu(parentViewModel: LevelSelectionViewModel())
    }
}
