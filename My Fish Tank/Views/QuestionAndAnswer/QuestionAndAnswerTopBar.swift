//
//  QuestionAndAnswerTopBar.swift
//  My Fish Tank
//
//  Created by Gino Preti on 28/11/20.
//

import SwiftUI

struct QuestionAndAnswerTopBar: View
{
    @Binding var correctAnswerCount: Int
    @Binding var wrongAnswerCount: Int
    
    var progress: CGFloat = 0.0
    
    var body: some View
    {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
            
            Capsule()
                .fill(Color("title_yellow").opacity(0.7))
                .frame(height: 6)
            
            Capsule()
                .fill(Color("title_brown"))
                .frame(width: progress, height: 6)
                
        })
        .padding()
        
        HStack
        {
            Label(
                title: { Text(correctAnswerCount == 0 ? "" : "\(correctAnswerCount)")
                    .font(.custom("BrandonText-Bold", size: 38))
                    .foregroundColor(.black)
                },
                icon: { Image("correct_answer_icon")
                    .resizable()
                    .frame(width: 40, height: 40)
                })
            
            Spacer()
            
            Label(
                title: { Text(wrongAnswerCount == 0 ? "" : "\(wrongAnswerCount)")
                    .font(.custom("BrandonText-Bold", size: 38))
                    .foregroundColor(.black)
                },
                icon: { Image("wrong_answer_icon")
                    .resizable()
                    .frame(width: 40, height: 40)
                })
        }
        .padding()
    }
}
