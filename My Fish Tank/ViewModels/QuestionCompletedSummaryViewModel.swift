//
//  QuestionCompletedSummaryViewModel.swift
//  My Fish Tank
//
//  Created by Gino Preti on 09/12/20.
//

import Foundation
import SwiftUI

class QuestionCompletedSummaryViewModel
{
    @AppStorage(AppStorageKeys.lastScore.rawValue) var lastScore: Int = 0
    
    var scoreMultiplier: Int = 10
    var previousScore: Int = 0
    
    func sendScore(correctAnswer: Int, wrongAnswer: Int)
    {
        let score = calculateScore(correctAnswer: correctAnswer, wrongAnswer: wrongAnswer)
        
        if score > previousScore
        {
            lastScore -= previousScore
            lastScore += score
            
            if let userInfo = FireBaseHelper.getUserInfo()
            {
                let scoreModel = ScoreModel(score: lastScore, user: userInfo.uid!)
                
                FireBaseHelper.sendScore(value: scoreModel)
            }
        }
    }
    
    func summaryMessage(correctAnswer: Int, wrongAnswer: Int) -> String
    {
        if wrongAnswer == 0
        {
            return LocalizationManager.summary_message_great_job.localizedText
        }
        
        if correctAnswer == 0
        {
            return LocalizationManager.summary_message_sleep.localizedText
        }
        
        if correctAnswer == wrongAnswer
        {
            return LocalizationManager.summary_message_do_better.localizedText
        }
                
        if correctAnswer > wrongAnswer
        {
            if (correctAnswer - wrongAnswer) >= 3
            {
                return LocalizationManager.summary_message_well_done.localizedText
            }
            else
            {
                return LocalizationManager.summary_message_bad_result.localizedText
            }
        }
        
        if correctAnswer < wrongAnswer
        {
            if (wrongAnswer - correctAnswer) <= 3
            {
                return LocalizationManager.summary_message_bad_result.localizedText
            }
            else
            {
                return LocalizationManager.summary_message_sleep.localizedText
            }
        }
        
        return LocalizationManager.summary_message_bad_result.localizedText
    }
    
    private func calculateScore(correctAnswer: Int, wrongAnswer: Int) -> Int
    {
        // (C*D) - ((W*(D/10))
        
        var score: Int = 0

        score = (correctAnswer * scoreMultiplier) - ((wrongAnswer*(scoreMultiplier/10)))
        
        return score > 0 ? score : 0
    }
}