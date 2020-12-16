//
//  NotificationSoundList.swift
//  My Fish Tank
//
//  Created by Gino Preti on 08/12/20.
//

import Foundation

class NotificationSoundsList
{
    static private var nsl = [NotificationSoundModel(name: "Alarm", id: 1005),
                       NotificationSoundModel(name: "Bloom", id: 1021),
                       NotificationSoundModel(name: "Fanfare", id: 1025),
                       NotificationSoundModel(name: "New mail", id: 1000),
                       NotificationSoundModel(name: "Suspense", id: 1032)]
    
    static func getSounsNotificationList() -> [NotificationSoundModel]
    {
        let sorted = nsl.sorted { (nsm1, nsm2) -> Bool in
            
            return nsm1.name! < nsm2.name!
        }
        
        return sorted
    }
}
