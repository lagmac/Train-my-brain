//
//  RoundViewModel.swift
//  My Fish Tank
//
//  Created by Gino Preti on 30/11/20.
//

import SwiftUI

class RoundViewModel: ObservableObject
{
    @Published var rounds: [RoundModel] = []
    
    func getRounds(completion: @escaping (()->Void) = {})
    {
        FireBaseHelper.getRounds(completion: { result in
            
            let sortedResult = result.sorted { (r1, r2) -> Bool in
                
                return r1.index! < r2.index!
            }
            
            self.rounds = sortedResult
            
            completion()
        })
    }

    func updateRound(withName name: String, correctAnswer: Int, wrongAnswer: Int)
    {
        FireBaseHelper.updateRound(withName: name, correctAnswer: correctAnswer, wrongAnswer: wrongAnswer) { error in
            
            if error
            {
                return
            }
            
            self.getRounds()
        }
    }
    
    func unlockNextRound(afterRound currentRound: String)
    {
        FireBaseHelper.unlockRound(afterRound: currentRound, completion: { error in
            
            if error
            {
                return
            }
            
            self.getRounds()
        })
    }
    
    func getScoreMultiplierForRound(withName name: String) -> Int
    {
        let currentRound = rounds.first { (rm) -> Bool in
            
            return rm.name! == name
        }
        
        if currentRound != nil
        {
            let difficulty = currentRound!.difficulty!
            
            return calculateScoreMultiplier(fromDifficulty: difficulty)
        }

        return 0
    }
    
    func getPreviousScore(withName name: String) -> Int
    {
        var previousScore: Int = 0
        
        let currentRound = rounds.first { (rm) -> Bool in
            
            return rm.name! == name
        }
        
        if let cr = currentRound
        {
            if cr.completed!
            {
                let scoreMultiplier = calculateScoreMultiplier(fromDifficulty: cr.difficulty!)
                
                previousScore = (cr.correctAnswer! * scoreMultiplier) - ((cr.wrongAnswer!*(scoreMultiplier/10)))
            }
        }
        
        return previousScore
    }
    
    private func calculateScoreMultiplier(fromDifficulty difficulty: String) -> Int
    {
        var counter: Int = 0
        
        for c in difficulty
        {
            if c == "1"
            {
                counter += 1
            }
        }
        
        return (counter * 10)
    }
}
