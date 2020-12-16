//
//  NewLevelAddedAlert.swift
//  My Fish Tank
//
//  Created by Gino Preti on 03/12/20.
//

import SwiftUI

struct CustomAlert: View
{
    var message: String = ""
    var hasTowButton: Bool = false
    
    var leftButtonTitle: String?
    var rightButtonTitle:String?
    
    var isFirstButtondestructive: Bool = false
    var isSecondButtondestructive: Bool = false
    
    var onFirstButtonTap: () -> (Void) = {}
    var onSecondButtonTap: () -> (Void) = {}
    
    var body: some View
    {
        HStack
        {
            VStack(spacing: 20)
            {
                HStack
                {
                    Text(LocalizationManager.app_title.localizedText)
                        .font(.custom("BrandonText-Bold", size: 28))
                        .foregroundColor(Color("title_brown"))
                }
                .padding(.horizontal, 50)
                .padding(.vertical, 10)
                
                HStack {
                    Text(message)
                        .multilineTextAlignment(.center)
                        .font(.custom("BrandonText-Bold", size: 20))
                        .foregroundColor(Color("title_yellow"))
                }
                .padding(.horizontal, 10)

                if !hasTowButton
                {
                    HStack
                    {
                        Button(action: {
                                                
                            onFirstButtonTap()
                            
                        }, label: {
                            Text(leftButtonTitle != nil ? leftButtonTitle! : LocalizationManager.btn_close_title.localizedText)
                                .font(.custom("BrandonText-Bold", size: 22))
                                .foregroundColor(Color("title_yellow"))
                                .padding(.vertical, 10)
                                .padding(.horizontal, 50)
                                .background(Color("title_brown"))
                                .cornerRadius(15)
                        })
                    }
                    .padding(.vertical, 30)
                    .padding(.horizontal, 50)
                }
                else
                {
                    HStack(spacing: 20)
                    {
                        Button(action: {
                                                
                            onFirstButtonTap()
                            
                        }, label: {
                            Text(leftButtonTitle != nil ? leftButtonTitle! : LocalizationManager.btn_discard_title.localizedText)
                                .font(.custom("BrandonText-Bold", size: 22))
                                .foregroundColor(Color("title_yellow"))
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(isFirstButtondestructive ? Color.red : Color("title_brown"))
                                .cornerRadius(15)
                        })
                                                
                        Button(action: {
                                                
                            onSecondButtonTap()
                            
                        }, label: {
                            Text(rightButtonTitle != nil ? rightButtonTitle! : LocalizationManager.btn_continue_title.localizedText)
                                .font(.custom("BrandonText-Bold", size: 22))
                                .foregroundColor(Color("title_yellow"))
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(isSecondButtondestructive ? Color.red : Color("title_brown"))
                                .cornerRadius(15)
                        })
                    }
                    .padding(.vertical, 30)
                    .padding(.horizontal, 30)
                }
            }
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 10)
        }
        .padding(.horizontal, 15)
    }
}

struct NewLevelAddedAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(message: "Do you really want to disconnect?")
    }
}
