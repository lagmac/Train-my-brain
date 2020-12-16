//
//  QuestionCompletedSummaryView.swift
//  My Fish Tank
//
//  Created by Gino Preti on 30/11/20.
//

import SwiftUI

struct QuestionCompletedSummaryView: View
{
    @Binding var set: String
    @ObservedObject var roundViewModel: RoundViewModel
    
    @ObservedObject var qcsvm = QuestionCompletedSummaryViewModel()
    
    var correctAnswerCount: Int
    var wrongAnswerCount: Int
    var scoreMultiplier: Int
    var previousScore: Int

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View
    {
        VStack(spacing: 25)
        {
            Image("trophy")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
            
            Text(qcsvm.summaryMessage(correctAnswer: correctAnswerCount, wrongAnswer: wrongAnswerCount))
                .foregroundColor(Color("title_yellow"))
                .font(.custom("BrandonText-Bold", size: 42))
            
            HStack(spacing: 25)
            {
                Image("correct_answer_icon")
                    .resizable()
                    .frame(width: 50, height: 50)
                
                Text("\(correctAnswerCount)")
                    .font(.custom("BrandonText-Bold", size: 38))
                    .foregroundColor(Color("title_yellow"))
                
                Image("wrong_answer_icon")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.leading)
                
                Text("\(wrongAnswerCount)")
                    .font(.custom("BrandonText-Bold", size: 38))
                    .foregroundColor(Color("title_yellow"))
            }
            
            Button(action: {
                
                qcsvm.sendScore(rvm: self.roundViewModel,
                                correctAnswer: correctAnswerCount,
                                wrongAnswer: wrongAnswerCount,
                                set: self.set) { presentationMode.wrappedValue.dismiss() }
            }, label: {
                
                Text(LocalizationManager.btn_goHome_title.localizedText)
                        .font(.custom("BrandonText-Bold", size: 24))
                        .foregroundColor(Color("title_yellow"))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 150)
                        .background(Color("title_brown"))
                        .cornerRadius(15)
            })
        }
        .onAppear(perform: {
            qcsvm.scoreMultiplier = scoreMultiplier
            qcsvm.previousScore = previousScore
        })
    }
}

struct QuestionCompletedSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCompletedSummaryView(set: .constant(""),
                                     roundViewModel: RoundViewModel(),
                                     correctAnswerCount: 6,
                                     wrongAnswerCount: 6,
                                     scoreMultiplier: 1,
                                     previousScore: 100)
    }
}

