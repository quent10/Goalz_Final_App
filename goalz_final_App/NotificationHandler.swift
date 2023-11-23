//
//  NotificationHandler.swift
//  goalz_final_App
//
//  Created by Quentin Wingard on 11/23/23.
//

import Foundation
import UserNotifications

class NotificationHandler {
    func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound], completionHandler: { success, error in
            if success {
                print ("Access granted!")
            }
            else if let error  = error{
                print(error.localizedDescription)
            }
        })
    }
}
