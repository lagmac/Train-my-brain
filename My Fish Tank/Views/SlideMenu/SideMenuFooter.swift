//
//  SideMenuFooter.swift
//  My Fish Tank
//
//  Created by Gino Preti on 14/12/20.
//

import SwiftUI

struct SideMenuFooter: View
{
    var body: some View
    {
        HStack
        {
            VStack
            {
                Text("Ver. \(UIApplication.appVersion!) (\(LocalizationManager.internal_build_number.localizedText))")
                    .font(.custom("BrandonText-Regular", size: 12))
                    .foregroundColor(Color("title_brown"))
                
                Text(LocalizationManager.slide_menu_footer_title.localizedText)
                    .font(.custom("BrandonText-Regular", size: 12))
                    .foregroundColor(Color("title_brown"))
            }
        }
    }
}

struct SideMenuFooter_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuFooter()
    }
}
