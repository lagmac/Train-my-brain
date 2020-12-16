//
//  LevelCookie.swift
//  My Fish Tank
//
//  Created by Gino Preti on 03/12/20.
//

import SwiftUI

struct LevelCookie: View
{    
    var roundModel: RoundModel!
    var lastLevel: Double = 0.0
    var roundNumber: Int = 0
    var index: Int = 0
    
    var body: some View
    {
        ZStack
        {
            if roundModel.completed! && roundModel.wrongAnswer == 0
            {
                RingShape()
                    .stroke(style: StrokeStyle(lineWidth: 20))
                    .fill(Color.green)
                    .frame(width: 120, height: 120)
            }
            else
            {
                RingShape()
                    .stroke(style: StrokeStyle(lineWidth: 20))
                    .fill(roundModel.completed! ? Color.red : Color("title_yellow"))
                    .frame(width: 120, height: 120)

                RingShape(percent: roundModel.completed! ? Double(roundModel.correctAnswer!) * Double((100 / roundModel.totalQuwestions())) : 0, startAngle: -90)
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .fill(Color.green)
                    .frame(width: 120, height: 120)
            }

            Text("\(roundNumber)")
                .font(.custom("BrandonText-Bold", size: 70))
                .foregroundColor(.black)
        }
        
        HStack
        {
            ForEach(1...3, id: \.self) { index in
                
                Image("brain")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .opacity(roundModel.isIconDifficultyActive(index: index) ? 1.0 : 0.5)
                    .padding(.top, 18)
            }
        }
    }
}
