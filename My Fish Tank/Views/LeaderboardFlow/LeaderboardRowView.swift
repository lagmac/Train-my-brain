//
//  LeaderboardRowView.swift
//  My Fish Tank
//
//  Created by Gino Preti on 09/12/20.
//

import SwiftUI

struct LeaderboardRowView: View
{
    var index: Int = 0
    var score: LeaderboardScoreModel
    
    var body: some View
    {
        HStack
        {
            if index < 4
            {
                Image("\(index)_place_icon")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(.leading, 4)
            }
            else
            {
                Image("score_badge")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(.leading, 4)
            }
                                            
            Text(score.userName!)
                .font(.custom("BrandonText-Bold", size: 22))
                .foregroundColor(Color("title_brown"))
            
            Spacer()
            
            Text("\(score.score!)")
                .font(.custom("BrandonText-Bold", size: 22))
                .foregroundColor(Color("title_brown"))
                .padding(.trailing, 8)
        }
        .padding(.vertical, 5)
        .background(Color("title_yellow"))
        .cornerRadius(8)
    }
}
