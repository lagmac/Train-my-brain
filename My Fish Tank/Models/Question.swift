//
//  Question.swift
//  My Fish Tank
//
//  Created by Gino Preti on 28/11/20.
//

import Foundation
import FirebaseFirestoreSwift

struct Question: Identifiable, Codable
{
    @DocumentID var id: String?
    
    var question: String?
    var answer: String?
    var optionA: String?
    var optionB: String?
    var optionC: String?
    
    var isSubmitted = false
    var completed = false

    enum CodingKeys: String, CodingKey
    {
        case question
        case answer
        case optionA = "a"
        case optionB = "b"
        case optionC = "c"
    }
}
