//
//  LeaderboardViewModel.swift
//  My Fish Tank
//
//  Created by Gino Preti on 09/12/20.
//

import Foundation
import SwiftUI

class LeaderboardViewModel: ObservableObject
{
    @Published var scores: [LeaderboardScoreModel] = []
    @Published var userScoreAndRank: UserScoreRankModel!
    
    @AppStorage(AppStorageKeys.lastScore.rawValue) var lastScore: Int = 0
    
    func getScores()
    {
        FireBaseHelper.getLeaderboardScores { result in
            
            if result.isEmpty == false
            {
                self.scores = result;
                self.userScoreAndRank = self.getUserScoreAndRank()
            }
        }
    }
    
    func getUserScoreAndRank() -> UserScoreRankModel
    {
        var rankString = "\(LocalizationManager.leaderboard_view_you_rank_label.localizedText) > 100"
        var scoreString = "\(LocalizationManager.leaderboard_view_you_score_label.localizedText) \(lastScore)"
        
        if let userInfo = FireBaseHelper.getUserInfo()
        {
            let userScore = scores.first { sc -> Bool in

                return sc.userID! == userInfo.uid!
            }

            let userRank = scores.firstIndex { sc -> Bool in

                return sc.userID! == userInfo.uid!
            }

            if let us = userScore, let ur = userRank
            {
                let rank = (ur + 1)
                
                rankString = "\(LocalizationManager.leaderboard_view_you_rank_label.localizedText) #\(rank)"
                scoreString = "\(LocalizationManager.leaderboard_view_you_score_label.localizedText) \(us.score!)"
                
                return UserScoreRankModel(score: scoreString, rank: rankString)
            }

            return UserScoreRankModel(score: scoreString, rank: rankString)
        }
        
        return UserScoreRankModel(score: scoreString, rank: rankString)
    }
}
