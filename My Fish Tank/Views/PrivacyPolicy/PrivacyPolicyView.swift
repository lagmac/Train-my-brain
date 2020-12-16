//
//  PrivacyPolicyView.swift
//  My Fish Tank
//
//  Created by Gino Preti on 11/12/20.
//

import SwiftUI

struct PrivacyPolicyView: View
{
    @Binding var accepted: Bool
    @Binding var pricavyPolicyOpen: Bool
    
    let fileUrl = Bundle.main.url(forResource: "privacyPolicy", withExtension: "pdf")!
    
    var body: some View
    {
        VStack
        {
            HStack {
                Text(LocalizationManager.sign_up_privacy_policy_label_title.localizedText)
                    .font(.custom("BrandonText-Bold", size: 32))
                    .foregroundColor(Color("title_brown"))
                    .padding(.leading, 30)
                
                Spacer()
                
                Button(action: {
                    
                    self.pricavyPolicyOpen.toggle()
                },
                       label: {
                    
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .foregroundColor(Color("title_yellow"))
                            .frame(width: 30, height: 30)
                })
                .padding(.trailing, 10)
            }
            
            PDFKitView(url: self.fileUrl)

            HStack
            {
                Image(systemName: accepted ? "checkmark.square" : "square")
                    .font(.title)
                    .foregroundColor(Color("title_yellow"))
                    .onTapGesture {
                        
                        self.accepted.toggle()
                        self.pricavyPolicyOpen.toggle()
                    }
                
                Text(LocalizationManager.sign_up_privacy_policy_accept_label_title.localizedText)
                    .font(.custom("BrandonText-Bold", size: 14))
                    .foregroundColor(Color("title_brown"))
                    .padding(.vertical, 20)
                    .onTapGesture {
                        
                    }
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .background(Color.white)
        .padding(.vertical)
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView(accepted: .constant(false), pricavyPolicyOpen: .constant(false))
    }
}
