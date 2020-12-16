//
//  TermsAndConditionsView.swift
//  My Fish Tank
//
//  Created by Gino Preti on 11/12/20.
//

import SwiftUI

struct TermsAndConditionsView: View
{
    @Binding var accepted: Bool
    @Binding var termsAndConditionsOpen: Bool
    
    let fileUrl = Bundle.main.url(forResource: "termsAndConditions", withExtension: "pdf")!
    
    var body: some View
    {
        VStack
        {
            HStack {
                Text(LocalizationManager.sign_up_terms_and_conditions_label_title.localizedText)
                    .font(.custom("BrandonText-Bold", size: 32))
                    .foregroundColor(Color("title_brown"))
                    .padding(.leading, 30)
                
                Spacer()
                
                Button(action: {
                    
                    self.termsAndConditionsOpen.toggle()
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
                        self.termsAndConditionsOpen.toggle()
                    }
                
                Text(LocalizationManager.sign_up_terms_and_conditions_accept_label_title.localizedText)
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

struct TermsAndConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndConditionsView(accepted: .constant(false), termsAndConditionsOpen: .constant(false))
    }
}
