//
//  LeaderboardUserModel.swift
//  My Fish Tank
//
//  Created by Gino Preti on 09/12/20.
//

import Foundation
import FirebaseFirestoreSwift

struct LeaderboardUserModel: Identifiable, Codable
{
    @DocumentID var id: String?
    
    var name: String?
}
