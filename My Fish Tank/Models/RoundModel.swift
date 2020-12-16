//
//  RoundModel.swift
//  My Fish Tank
//
//  Created by Gino Preti on 30/11/20.
//

import SwiftUI
import FirebaseFirestoreSwift

struct RoundModel: Identifiable, Codable
{
    @DocumentID var id: String?
    
    var name: String?
    var completed: Bool?
    var enabled: Bool?
    var difficulty: String?
    var index: Int?
    var correctAnswer: Int?
    var wrongAnswer: Int?
    
    func isIconDifficultyActive(index: Int) -> Bool
    {
        if index == 1
        {
            return String(difficulty![difficulty!.startIndex]) == "1"
        }
        
        if index == 2
        {
            return String(difficulty![difficulty!.index(difficulty!.startIndex, offsetBy: 1)]) == "1"
        }
        
        if index == 3
        {
            return String(difficulty![difficulty!.index(difficulty!.startIndex, offsetBy: 2)]) == "1"
        }
        
        return false
    }
    
    func getDifficultyColor(index: Int) -> Color
    {
        if index == 1
        {
            return String(difficulty![difficulty!.startIndex]) == "1" ? Color.red : Color.gray.opacity(0.5)
        }
        
        if index == 2
        {
            return String(difficulty![difficulty!.index(difficulty!.startIndex, offsetBy: 1)]) == "1" ? Color.red : Color.gray.opacity(0.5)
        }
        
        if index == 3
        {
            return String(difficulty![difficulty!.index(difficulty!.startIndex, offsetBy: 2)]) == "1" ? Color.red : Color.gray.opacity(0.5)
        }
        
        return Color.gray.opacity(0.5)
    }
    
    func totalQuwestions() -> Int
    {
        return correctAnswer! + wrongAnswer!
    }
}
