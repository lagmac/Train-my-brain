//
//  HomeView.swift
//  My Fish Tank
//
//  Created by Gino Preti on 28/11/20.
//

import SwiftUI

struct LevelSelectionView: View
{
    @ObservedObject var viewModel = LevelSelectionViewModel()
 
    var body: some View
    {
        ZStack
        {
            VStack
            {
                LevelSelectionViewHeader(parentViewModel: viewModel, levelListener: viewModel.firebaseListener)
                
                Image("Icon_brain")
                    .resizable()
                    .background(Color.green)
                    .frame(width: 100, height:100)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color("title_brown"), lineWidth: 4))
                    .padding()

                Spacer(minLength: 0)
                
                LevelGrid(_roundViewModel: viewModel.roundViewModel, parentViewModel: viewModel).disabled(viewModel.slideMenu ? true : false)

                Spacer(minLength: 0)

            }
            .background(viewModel.roundViewModel.rounds.isEmpty ? Color.white.ignoresSafeArea() : Color.black.opacity(0.05).ignoresSafeArea())
            .blur(radius: viewModel.slideMenu ? 3 : 0)
            
            SlideMenu(parentViewModel: viewModel)
            
            if viewModel.closeAlert
            {
                CustomAlert(message: viewModel.alertMessage,
                            hasTowButton: viewModel.twoButtonAlert,
                            isSecondButtondestructive: true,
                            onFirstButtonTap: { viewModel.onFirstButtonCloseAlert() })
            }
            
            if viewModel.signOutAlert
            {
                CustomAlert(message: viewModel.alertMessage,
                            hasTowButton: viewModel.twoButtonAlert,
                            isSecondButtondestructive: true,
                            onFirstButtonTap: { viewModel.onFirstButtonTapSignOutAlert() },
                            onSecondButtonTap: { viewModel.onSecondButtonTapSignOutAlert() })
            }
            
            if viewModel.firstLauchAlert
            {
                CustomAlert(message: LocalizationManager.alert_first_launch_disclaimer.localizedText, onFirstButtonTap: {
                    
                    viewModel.onFirstLaunchDisclaimer()
                })
            }
            
            if viewModel.activateBell
            {
                CustomAlert(message: viewModel.alertMessage,
                            hasTowButton: viewModel.twoButtonAlert,
                            leftButtonTitle: LocalizationManager.btn_close_title.localizedText,
                            rightButtonTitle: LocalizationManager.btn_update_level.localizedText,
                            isSecondButtondestructive: false,
                            onFirstButtonTap: { viewModel.OnFirstButtonTapNewRoundNotification() },
                            onSecondButtonTap: { viewModel.OnSecondButtonTapNewRoundNotification() })
            }
        }
        .sheet(item: $viewModel.viewType, content: { item in
            
            if item.vt == .questionView
            {
                QuestionAnswerView(set: $viewModel.set, roundViewModel: viewModel.roundViewModel)
            }
            
            if item.vt == .signUpView
            {
                SignUpView(fireBaseListener: viewModel.firebaseListener)
            }
            
            if item.vt == .signInView
            {
                SignInView(onSignIn: { viewModel.onSignInView() })
            }
            
            if item.vt == .settingsView
            {
                UserSettingsView(roundViewModel: viewModel.roundViewModel)
            }
            
            if item.vt == .leaderboard
            {
                LeaderboardView()
            }
        })
        .onAppear(perform: { viewModel.onViewAppear() })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSelectionView()
    }
}
