//
//  QuestionView.swift
//  My Fish Tank
//
//  Created by Gino Preti on 28/11/20.
//

import SwiftUI

struct QuestionView: View
{
    @Binding var question: Question

    @State var selectedAnswer: String = ""
    
    var onAnswerSubmitted: (String) -> (Void) = { _ in }
    var onNext: () -> (Void) = {}
    
    var body: some View
    {
        VStack(spacing: 22)
        {
            Text(question.question!)
                .font(.custom("BrandonText-Bold", size: 24))
                .foregroundColor(Color("title_brown"))
                .padding(.top, 10)
            
            Spacer(minLength: 0)
            
            Button(action: {
                
                self.selectedAnswer = question.optionA!
                
            }, label: {
                Text(question.optionA!)
                    .font(.custom("BrandonText-Regular", size: 20))
                    .modifier(TextAnswerModifier(selected: self.selectedAnswer, option: question.optionA!, question: question))
            })
            .disabled(!question.isSubmitted ? false : true)
            
            Button(action: {
                
                self.selectedAnswer = question.optionB!
                
            }, label: {
                Text(question.optionB!)
                    .font(.custom("BrandonText-Regular", size: 20))
                    .modifier(TextAnswerModifier(selected: self.selectedAnswer, option: question.optionB!, question: question))
            })
            .disabled(!question.isSubmitted ? false : true)
            
            Button(action: {
                
                self.selectedAnswer = question.optionC!
                
            }, label: {
                Text(question.optionC!)
                    .font(.custom("BrandonText-Regular", size: 20))
                    .modifier(TextAnswerModifier(selected: self.selectedAnswer, option: question.optionC!, question: question))
            })
            .disabled(!question.isSubmitted ? false : true)
            
            Spacer(minLength: 0)
            
            QuestionAndAnswerFooterButtons(question: $question,
                                           onSubmitt: {
                                            onAnswerSubmitted(self.selectedAnswer)
                                            question.isSubmitted.toggle()
                                           },
                                           onNext: {
                                            withAnimation{ question.completed.toggle() }
                                            onNext() })
        }
        .padding()
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: Color("title_brown").opacity(0.05), radius: 5, x: 5, y: 5)
        .shadow(color: Color("title_brown").opacity(0.05), radius: 5, x: -5, y: -5)
    }
}
