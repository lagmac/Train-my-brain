//
//  TextAnswerModifier.swift
//  My Fish Tank
//
//  Created by Gino Preti on 29/11/20.
//

import SwiftUI

struct TextAnswerModifier: ViewModifier {
    
    var selected: String
    var option: String
    var question: Question
    
    func body(content: Content) -> some View
    {
        content
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 15)
                            .stroke(switchColor(), lineWidth: 3))
    }
    
    func switchColor() -> Color
    {
        if option == selected
        {
            if question.isSubmitted
            {
                if selected == question.answer!
                {
                    return Color.green
                }
                else
                {
                    return Color.red
                }
            }
            else
            {
                return Color("title_brown")
            }
        }
        else
        {
            if question.isSubmitted
            {
                if question.answer! == option
                {
                    return Color.green
                }
            }
            
            return Color("title_yellow")
        }
    }
}
