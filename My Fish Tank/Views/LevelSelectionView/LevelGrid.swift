//
//  LevelGrid.swift
//  My Fish Tank
//
//  Created by Gino Preti on 28/11/20.
//

import SwiftUI

struct LevelGrid: View
{
    @ObservedObject var _roundViewModel: RoundViewModel
    @ObservedObject var parentViewModel: LevelSelectionViewModel
                
    var body: some View
    {
        ZStack
        {
            if  _roundViewModel.rounds.isEmpty
            {
                ProgressView()
                    .scaleEffect(x: 2, y: 2, anchor: .center)
            }
            else
            {
                ScrollView(.vertical, showsIndicators: true, content: {
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 35, content: {

                        ForEach(0..<parentViewModel.roundCount(), id: \.self) { index in
                            
                            let roundNumber = index + 1
                            
                            if roundNumber <= parentViewModel.roundCount()
                            {
                                let _rvm = parentViewModel.getRoundModel(index: index)

                                VStack(spacing: 15)
                                {
                                    LevelCookie(roundModel: _rvm,
                                                lastLevel: Double(parentViewModel.roundCount()),
                                                roundNumber: _rvm.index!,
                                                index: index)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(15)
                                .opacity(_rvm.enabled! ? 1.0 : 0.5)
                                .onTapGesture {

                                    if _rvm.enabled!
                                    {
                                        parentViewModel.setSet(index: index)
                                        parentViewModel.viewType = ViewTypes(vt: .questionView)
                                    }
                                }
                            }
                        }
                    })
                    .padding()
                })
            }
        }
    }
}
