//
//  QuestionAndAnswerViewModel.swift
//  My Fish Tank
//
//  Created by Gino Preti on 28/11/20.
//

import SwiftUI

class QuestionAndAnswerViewModel: ObservableObject
{
    @Published var questions: [Question] = []
    @Published var answered: Int = 0
    @Published var correctAnswerCount: Int = 0
    @Published var wrongAnswerCount: Int = 0

    func getQuestions(set: String, completion: @escaping ((Bool)->Void))
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            
            if self.questions.isEmpty
            {
                completion(false)
            }
        }

        FireBaseHelper.getQuestions(set: set) { [self] result in

            if !result.isEmpty
            {
                self.questions = result
                completion(true)
            }
        }
    }
    
    func incrementQuestionAnswered()
    {
        self.answered += 1
    }
    
    func checkAnswer(answer: String, forQuestion question: Question)
    {
        if answer == question.answer
        {
            correctAnswerCount += 1
        }
        else
        {
            wrongAnswerCount += 1
        }
    }
    
    func completed() -> Bool
    {
        return answered == questions.count
    }
    
    func progress() -> CGFloat
    
    {
        let fraction = CGFloat(answered) / CGFloat(questions.count)
        
        let  width = UIScreen.main.bounds.width - 30
        
        return fraction * width
    }
}
