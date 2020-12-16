//
//  MenuRow.swift
//  My Fish Tank
//
//  Created by Gino Preti on 04/12/20.
//

import SwiftUI

struct MenuRow: View
{
    var rowIconName: String = ""
    var rowTitle: String = ""
    
    var onAction : () -> (Void) = {}
    
    var body: some View
    {
        HStack
        {
            Button(action: {
                
                onAction()

            },
                   label: {

                    HStack(spacing: 18) {
                        Image(rowIconName).renderingMode(.original).resizable().frame(width: 30, height: 30)
                        Text(rowTitle)
                            .font(.custom("BrandonText-Bold", size: 22))
                            .foregroundColor(Color("title_brown"))
                    }
               })
        }
        .padding(.leading, 15)
        .padding(.trailing, 60)
    }
}

struct MenuRow_Previews: PreviewProvider {
    static var previews: some View {
        MenuRow()
    }
}
