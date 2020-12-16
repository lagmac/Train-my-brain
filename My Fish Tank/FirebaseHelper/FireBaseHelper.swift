//
//  FireBaseHelper.swift
//  My Fish Tank
//
//  Created by Gino Preti on 01/12/20.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class FireBaseHelper
{
    private static let db = Firestore.firestore()
    
    static func changePassword(withNewPassword password: String)
    {
        
    }
    
    static func forgotPassword(email: String, completion: @escaping ((Bool)->Void))
    {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            
            if error == nil
            {
                completion(true)
            }
            else
            {
                completion(false)
            }
        }
    }
    
    static func signInUser(withEmail email: String, password: String, completion: @escaping ((Bool)->Void))
    {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error == nil
            {
                guard result != nil else { return }
                
                completion(true)
            }
            else
            {
                completion(false)
            }
        }
    }
    
    static func signoutUser(completion: @escaping ((Bool)->Void))
    {
        do
        {
            try Auth.auth().signOut()
            
            completion(true)
        }
        catch
        {
            print("SIGNOUT ERROR !!!")
            completion(false)
        }
    }
    
    static func isUserSignedIn() -> Bool
    {
        if Auth.auth().currentUser != nil
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    static func getUserInfo() -> UserModel?
    {
        if isRegisteredUser()
        {
            if let user = Auth.auth().currentUser
            {
                return UserModel(displayName: user.displayName, email: user.email, uid: user.uid)
            }
        }
        
        return nil
    }
    
    static func updateUserName(withName name: String, completion: @escaping ((Bool)->Void))
    {
        if isRegisteredUser()
        {
            if let user = Auth.auth().currentUser
            {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = name
                
                changeRequest.commitChanges { (error) in
                    
                    if error == nil
                    {
                        let userData: [String : Any] = ["name" : name]
                        
                        db.collection("users").document(user.uid).setData(userData)
                        
                        completion(true)
                    }
                    else
                    {
                        completion(false)
                    }
                }
            }
        }
    }
        
    static func AddListener(_ completion: @escaping ((Bool)->Void))
    {
        if isRegisteredUser()
        {            
            var isFirstTime: Bool = true
            
            db.collection("rounds").addSnapshotListener { (querySnapshot, error) in
                
                if error == nil
                {
                    guard let snapshot = querySnapshot else {
                                print("Error fetching snapshots: \(error!)")
                                return
                            }
                                                
                    snapshot.documentChanges.forEach { diff in
                        
                        switch diff.type
                        {
                            case .modified:
                                break
                            case .added:
                                if !isFirstTime  { completion(true) }
                            case .removed:
                                break
                            
                        }
                    }
                }
                else
                {
                    print("ERROR: \(error?.localizedDescription ?? "")")
                }
                
                if isFirstTime { isFirstTime = false }
            }
        }
    }
    
    static func isRegisteredUser() -> Bool
    {
        if let a = Auth.auth().currentUser?.isAnonymous
        {
            return !a
        }
                
        return false
    }
    
    static func migrateToRegisterUser(withUserName email: String, password: String, completion: @escaping ((Bool)->Void))
    {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        Auth.auth().currentUser?.link(with: credential, completion: { (result, error) in
            
            if error == nil
            {
                createUser()
                
                completion(true)
            }
            else
            {
                completion(false)
            }
        })
            
    }
    
    static func createUser()
    {
        let userID = Auth.auth().currentUser?.uid
        
        let userData: [String : Any] = ["name" : "Anonymous"]
        
        db.collection("users").document(userID!).setData(userData)
    }
    
    static func createUserCollection(isFirstLaunch: Bool, completion: @escaping ((Bool)->Void))
    {
        if (Auth.auth().currentUser?.uid) != nil
        {
            let username = Auth.auth().currentUser?.displayName
            
            print(username ?? "no user name")
            
            let uid = Auth.auth().currentUser?.uid
            
            print(uid ?? "NO UID")
            
            if isFirstLaunch
            {
                do
                {
                    try Auth.auth().signOut()

                    completeCreationUserCollection { (response) in

                                                        if response
                                                        {
                                                            completion(true)
                                                        }
                                                        else
                                                        {
                                                            completion(false)
                                                        }
                                                    }
                }
                catch
                {
                    print("SIGN OUT ERROR !!!")
                }
            }
            else
            {
                completion(true)
            }
        }
        else
        {
            completeCreationUserCollection { (response) in
                
                                                if response
                                                {
                                                    completion(true)
                                                }
                                                else
                                                {
                                                    completion(false)
                                                }
                                            }
        }
    }
    
    static private func completeCreationUserCollection(_ completion: @escaping ((Bool)->Void))
    {
        Auth.auth().signInAnonymously { (result, error) in
            
            if error == nil
            {
                getRounds(onUserCreation: true) { (roundModels) in
                    
                    if let data = result?.user
                    {
                        for roundData in roundModels
                        {
                            let docData: [String : Any] = ["name" : roundData.name!,
                                                           "completed" : roundData.completed!,
                                                           "enabled" : roundData.enabled!,
                                                           "difficulty" : roundData.difficulty!,
                                                           "index" : roundData.index!]
                            
                            db.collection(data.uid).addDocument(data: docData)
                        }
                        
                        completion(true)
                    }
                    else
                    {
                        completion(false)
                    }
                }
            }
            else
            {
                completion(false)
            }
        }

    }
    
    static func getRounds(onUserCreation: Bool = false, completion: @escaping (([RoundModel])->Void))
    {
        var rounds: [RoundModel] = []
                        
        var collectionId = "rounds"
        
        if onUserCreation == false
        {
            if let uid = Auth.auth().currentUser?.uid
            {
                collectionId = uid
            }
        }

        db.collection(collectionId).order(by: "name").getDocuments { (query, error) in
            
            guard let data = query else { return }
            
            DispatchQueue.main.async {
                
                rounds = data.documents.compactMap({ (doc) -> RoundModel? in
                    
                    return try? doc.data(as: RoundModel.self)
                })
                
                completion(rounds)
            }
        }
    }
    
    static func fetchNewRounds(completion: @escaping ((Bool)->Void))
    {
        var commonRounds: [RoundModel] = []
        var userRounds: [RoundModel] = []
        var newRounds: [RoundModel] = []
                
        var collectionId = "rounds"
        
        db.collection(collectionId).order(by: "name").getDocuments { (query, error) in
            
            guard let data = query else { return }
            
            DispatchQueue.main.async {
                
                commonRounds = data.documents.compactMap({ (doc) -> RoundModel? in
                    
                    return try? doc.data(as: RoundModel.self)
                })
                
                if let uid = Auth.auth().currentUser?.uid
                {
                    collectionId = uid
                }
                
                db.collection(collectionId).order(by: "name").getDocuments { (query, error) in
                    
                    guard let data = query else { return }
                    
                    DispatchQueue.main.async {
                        
                        userRounds = data.documents.compactMap({ (doc) -> RoundModel? in
                            
                            return try? doc.data(as: RoundModel.self)
                        })

                        if commonRounds.count > 0 && userRounds.count > 0
                        {
                            if commonRounds.count > userRounds.count
                            {
                                for _cr in commonRounds
                                {
                                    if userRounds.contains(where: { $0.name == _cr.name}) == false
                                    {
                                        newRounds.append(_cr)
                                    }
                                }
                            }
                        }
                        
                        let lastCompleted = userRounds.filter { (rm) -> Bool in
                            return rm.completed! && rm.enabled!
                            
                        }.sorted { (rm1, rm2) -> Bool in
                            
                            return rm1.index! < rm2.index!
                        }.last
                        
                        if newRounds.isEmpty == false
                        {
                            if let uid = Auth.auth().currentUser?.uid
                            {
                                for roundData in newRounds
                                {
                                    var canEnable = false
                                    
                                    if let lc = lastCompleted
                                    {
                                        if (lc.index! + 1) == roundData.index!
                                        {
                                            canEnable = true
                                        }
                                    }
                                    
                                    let docData: [String : Any] = ["name" : roundData.name!,
                                                                   "completed" : roundData.completed!,
                                                                   "enabled" : canEnable,
                                                                   "difficulty" : roundData.difficulty!,
                                                                   "index" : roundData.index!]
                                    
                                    db.collection(uid).addDocument(data: docData)
                                }
                            }
                            
                            completion(true)
                        }
                        else
                        {
                            completion(false)
                        }
                    }
                }
            }
        }
    }
    
    static func getQuestions(set: String, completion: @escaping (([Question])->Void))
    {
        var questions: [Question] = []
                        
        db.collection(set).getDocuments { (query, error) in
            
            guard let data = query else { return }
            
            DispatchQueue.main.async {
                
                questions = data.documents.compactMap({ (doc) -> Question? in
                    
                    return try? doc.data(as: Question.self)
                })
                                
                completion(questions)
            }
        }
    }
    
    static func updateRound(withName name: String, correctAnswer: Int, wrongAnswer: Int, completion: @escaping ((Bool)->Void))
    {
        let uid = Auth.auth().currentUser?.uid
        
        db.collection(uid!).whereField("name", isEqualTo: name).getDocuments { (query, error) in
            
            if error == nil
            {
                guard let data = query else { return }
                
                var rounds: [RoundModel]?
                
                DispatchQueue.main.async {
                    
                    rounds = data.documents.compactMap({ (doc) -> RoundModel? in
                        
                        return try? doc.data(as: RoundModel.self)
                    })
                    
                    if rounds?.first != nil
                    {
                        var round = rounds?.first
                        
                        round?.completed = true
                        
                        let newData: [String : Any] = ["completed" : true, "correctAnswer" : correctAnswer, "wrongAnswer" : wrongAnswer]
                        
                        db.collection(uid!).document((round?.id)!).updateData(newData)
                    }
                    
                    completion(false)
                }
            }
            else
            {
                completion(true)
            }
        }
    }
    
    static func unlockRound(afterRound name: String, completion: @escaping ((Bool)->Void))
    {
        let nextRoundName = getNextRoundName(afterRound: name)
                        
        let uid = Auth.auth().currentUser?.uid
        
        db.collection(uid!).whereField("name", isEqualTo: nextRoundName).getDocuments { (query, error) in
            
            if error == nil
            {
                guard let data = query else { return }
                
                var rounds: [RoundModel]?
                
                DispatchQueue.main.async {
                    
                    rounds = data.documents.compactMap({ (doc) -> RoundModel? in
                        
                        return try? doc.data(as: RoundModel.self)
                    })
                    
                    if rounds?.first != nil
                    {
                        var round = rounds?.first
                        
                        round?.completed = true
                        
                        db.collection(uid!).document((round?.id)!).updateData(["enabled" : true])
                    }
                    
                    completion(false)
                }
            }
            else
            {
                completion(true)
            }
        }
    }
    
    static func resetAllRounds(completion: @escaping ((Bool)->Void))
    {
        if isRegisteredUser()
        {
            if let cu = Auth.auth().currentUser
            {
                var rounds: [RoundModel] = []
                
                db.collection(cu.uid).order(by: "name").getDocuments { (query, error) in
                    
                    guard let data = query else { return }
                    
                    DispatchQueue.main.async {
                        
                        rounds = data.documents.compactMap({ (doc) -> RoundModel? in
                            
                            return try? doc.data(as: RoundModel.self)
                        })
                        
                        if rounds.count > 0
                        {
                            for r in rounds
                            {
                                var newData: [String : Any]!
                                
                                if r.index! == 1
                                {
                                    newData = ["enabled" : true, "completed" : false, "correctAnswer" : 0, "wrongAnswer" : 0]
                                }
                                else
                                {
                                    newData = ["enabled" : false, "completed" : false, "correctAnswer" : 0, "wrongAnswer" : 0]
                                }
                                
                                db.collection(cu.uid).document(r.id!).updateData(newData)
                            }
                            
                            completion(true)
                        }
                        else
                        {
                            completion(false)
                        }
                    }
                }
            }
        }
    }
    
    static func sendScore(value: ScoreModel)
    {
        if isRegisteredUser()
        {
            if Auth.auth().currentUser != nil
            {                
                db.collection("leaderboard").whereField("user", isEqualTo: value.user!).getDocuments { (query, error) in
                    
                    if error == nil
                    {
                        guard let data = query else { return }
                        
                        let scores = data.documents.compactMap({ (doc) -> ScoreModel? in
                            
                            return try? doc.data(as: ScoreModel.self)
                        })
                        
                        if let s = scores.first
                        {
                            db.collection("leaderboard").document(s.id!).updateData(["score" : value.score!])
                        }
                        else
                        {
                            db.collection("leaderboard").addDocument(data: [ "user" : value.user!, "score" : value.score!])
                        }
                    }
                    else
                    {
                        db.collection("leaderboard").addDocument(data: [ "user" : value.user!, "score" : value.score!])
                    }
                }
            }
        }
    }
    
    static func removeScoreFromLeaderboard(completion: @escaping ((Bool)->Void))
    {
        if isRegisteredUser()
        {
            if let user = Auth.auth().currentUser
            {
                db.collection("leaderboard").whereField("user", isEqualTo: user.uid).getDocuments { (query, error) in
                    
                    if error == nil
                    {
                        guard let data = query else {
                            completion(false)
                            return
                        }
                        
                        let scores = data.documents.compactMap({ (doc) -> ScoreModel? in
                            
                            return try? doc.data(as: ScoreModel.self)
                        })
                        
                        if let s = scores.first
                        {
                            db.collection("leaderboard").document(s.id!).delete { (error) in
                                
                                if error == nil
                                {
                                    completion(true)
                                }
                                else
                                {
                                    completion(false)
                                }
                            }
                        }
                        else
                        {
                            completion(false)
                        }
                    }
                    else
                    {
                        completion(false)
                    }
                }
            }
        }
    }
    
    static func getLeaderboardScores(completion: @escaping (([LeaderboardScoreModel])->Void))
    {
        var scores: [ScoreModel] = []
        var users: [LeaderboardUserModel] = []
        var leaderboardScores: [LeaderboardScoreModel] = []
                        
        db.collection("leaderboard").order(by: "score", descending: true).limit(to: 100).getDocuments { (query, error) in
            
            guard let data = query else { return }
            
            DispatchQueue.main.async {
                
                scores = data.documents.compactMap({ (doc) -> ScoreModel? in
                    
                    return try? doc.data(as: ScoreModel.self)
                })
                
                db.collection("users").getDocuments { (query, error) in
                    
                    if error == nil
                    {
                        guard let data = query else { return }
                        
                        DispatchQueue.main.async {
                            
                            users = data.documents.compactMap({ (doc) -> LeaderboardUserModel? in
                                
                                return try? doc.data(as: LeaderboardUserModel.self)
                            })
                            
                            for score in scores
                            {
                                var leaderboardScore = LeaderboardScoreModel(score: 0, userName: "")
                                
                                for user in users
                                {
                                    if score.user! == user.id!
                                    {
                                        leaderboardScore.score = score.score
                                        leaderboardScore.userName = user.name
                                        leaderboardScore.userID = score.user
                                        
                                        leaderboardScores.append(leaderboardScore)
                                    }
                                }
                            }
                            
                            completion(leaderboardScores)
                        }
                    }
                }
            }
        }
    }
    
    private static func getNextRoundName(afterRound currentRound: String) -> String
    {
        let start = currentRound.index(currentRound.startIndex, offsetBy: 6)
        let end = currentRound.endIndex
        let substring = String(currentRound[start..<end])
        let currentRoundNumber = Int(substring) ?? 0
        let nextRoundNumber = currentRoundNumber + 1
        let nextRoundName = "Round_\(nextRoundNumber)"
        
        return nextRoundName
    }
}
