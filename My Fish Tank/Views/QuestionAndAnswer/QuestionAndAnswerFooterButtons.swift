//
//  QuestionAndAnswerFooterButtons.swift
//  My Fish Tank
//
//  Created by Gino Preti on 30/11/20.
//

import SwiftUI

struct QuestionAndAnswerFooterButtons: View
{
    @Binding var question: Question

    var onSubmitt: () -> (Void) = {}
    var onNext: () -> (Void) = {}
    
    var body: some View
    {
        HStack(spacing: 15)
        {
            Button(action: {

                onSubmitt()

            }, label: {
                Text(LocalizationManager.btn_submit_title.localizedText)
                    .font(.custom("BrandonText-Bold", size: 20))
                    .foregroundColor(Color("title_yellow"))
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(Color("title_brown"))
                    .cornerRadius(15)
            })
            .disabled(question.isSubmitted ? true : false)
            .opacity(question.isSubmitted ? 0.7 : 1.0)
            
            Button(action: {
             
                onNext()
                
            }, label: {
                Text(LocalizationManager.btn_next_title.localizedText)
                    .font(.custom("BrandonText-Bold", size: 20))
                    .foregroundColor(Color("title_yellow"))
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(Color("title_brown"))
                    .cornerRadius(15)
            })
            .disabled(!question.isSubmitted ? true : false)
            .opacity(!question.isSubmitted ? 0.7 : 1.0)
        }
        .padding(.bottom)
    }
}
