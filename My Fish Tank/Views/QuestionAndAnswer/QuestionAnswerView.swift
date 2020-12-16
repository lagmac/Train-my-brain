//
//  QuestionAnswerView.swift
//  My Fish Tank
//
//  Created by Gino Preti on 28/11/20.
//

import SwiftUI

struct QuestionAnswerView: View
{
    @Binding var set: String
    @ObservedObject var roundViewModel: RoundViewModel
    
    @StateObject var _questionViewModel = QuestionAndAnswerViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var loadingTimeoutError = false
    @State var progressInactive = false
    
    var body: some View
    {
        ZStack
        {
            if _questionViewModel.questions.isEmpty
            {
                if self.progressInactive
                {
                    ProgressView()
                        .hidden()
                }
                else
                {
                    ProgressView()
                        .scaleEffect(x: 2, y: 2, anchor: .center)
                }
            }
            else
            {
                if _questionViewModel.completed()
                {
                    QuestionCompletedSummaryView(set: self.$set,
                                                 roundViewModel: self.roundViewModel,
                                                 correctAnswerCount: _questionViewModel.correctAnswerCount,
                                                 wrongAnswerCount: _questionViewModel.wrongAnswerCount,
                                                 scoreMultiplier: self.roundViewModel.getScoreMultiplierForRound(withName: set),
                                                 previousScore: self.roundViewModel.getPreviousScore(withName: set))
                }
                else
                {
                    VStack
                    {
                        QuestionAndAnswerTopBar(correctAnswerCount: $_questionViewModel.correctAnswerCount, wrongAnswerCount: $_questionViewModel.wrongAnswerCount, progress: _questionViewModel.progress())
                        
                        ZStack
                        {
                            ForEach(_questionViewModel.questions.reversed().indices) { index in
                                
                                QuestionView(question: $_questionViewModel.questions[index],
                                             onAnswerSubmitted: { selectedAnswer in
                                                
                                                _questionViewModel.checkAnswer(answer: selectedAnswer, forQuestion: _questionViewModel.questions[index])
                                             },
                                             onNext: { _questionViewModel.incrementQuestionAnswered() }
                                    )
                                    .offset(x: _questionViewModel.questions[index].completed ? 1000 : 0)
                                    .rotationEffect(.init(degrees: _questionViewModel.questions[index].completed ? 10 : 0))
                            }
                        }
                    }
                }
            }
            
            if self.loadingTimeoutError
            {
                CustomAlert(message: LocalizationManager.alert_question_download_error.localizedText,
                            hasTowButton: true,
                            leftButtonTitle: LocalizationManager.btn_close_title.localizedText,
                            rightButtonTitle: LocalizationManager.btn_try_again_title.localizedText, onFirstButtonTap: {
                    
                    self.loadingTimeoutError.toggle()
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                }, onSecondButtonTap: {
                    
                    self.loadingTimeoutError.toggle()
                    self.progressInactive = false
                    
                    _questionViewModel.getQuestions(set: set, completion: { result in
                        
                        if !result
                        {
                            self.progressInactive = true
                            self.loadingTimeoutError.toggle()
                        }
                    })
                })
            }
        }
        .padding(.horizontal, 15)
        .onAppear(perform: {
            
            _questionViewModel.getQuestions(set: set, completion: { result in
                
                if !result
                {
                    self.progressInactive = true
                    self.loadingTimeoutError.toggle()
                }
            })
        })
    }
}
