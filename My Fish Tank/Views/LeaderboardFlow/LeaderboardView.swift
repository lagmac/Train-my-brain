//
//  LeaderboardView.swift
//  My Fish Tank
//
//  Created by Gino Preti on 09/12/20.
//

import SwiftUI

struct LeaderboardView: View {
    
    @ObservedObject var lbvm = LeaderboardViewModel()
    
    @State var userScoreAndRank: UserScoreRankModel = UserScoreRankModel(score: "0", rank: "0")
    
    var body: some View
    {
        ZStack
        {
            if lbvm.scores.isEmpty
            {
                ProgressView()
                    .scaleEffect(x: 2, y: 2, anchor: .center)
            }
            else
            {
                VStack
                {
                    HStack {
                        Spacer()

                        Text(LocalizationManager.leaderboard_view_title.localizedText)
                            .font(.custom("BrandonText-Bold", size: 42))
                            .foregroundColor(Color("title_brown"))

                        Spacer()
                    }
                    
                    HStack {

                        Text(userScoreAndRank.score!)
                            .font(.custom("BrandonText-Regular", size: 20))
                            .foregroundColor(Color("title_brown"))
                        
                        Spacer()
                        
                        Text(userScoreAndRank.rank!)
                            .font(.custom("BrandonText-Regular", size: 20))
                            .foregroundColor(Color("title_brown"))
                    }
                    
                    ScrollView(.vertical, showsIndicators: true, content: {
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 1), spacing: 8, content: {
                            
                            ForEach(0..<lbvm.scores.count) { index in
                                
                                LeaderboardRowView(index: index + 1, score: lbvm.scores[index])
                            }
                        })
                    })
                }
                .padding(.top, 20)
            }
        }
        .padding(.horizontal,20)
        .onAppear(perform: {
            
            lbvm.getScores(completion: { result in
                
                if result
                {
                    self.userScoreAndRank = lbvm.getUserScoreAndRank()
                }
            })
        })
    }
}
