//
//  ScoreModel.swift
//  My Fish Tank
//
//  Created by Gino Preti on 09/12/20.
//

import Foundation
import FirebaseFirestoreSwift

struct ScoreModel: Identifiable, Codable
{
    @DocumentID var id: String?
    
    var score: Int?
    var user: String?
}
