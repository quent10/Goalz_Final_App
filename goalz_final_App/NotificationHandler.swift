//
//  NotificationHandler.swift
//  goalz_final_App
//
//  Created by Quentin Wingard on 11/23/23.
//

import SwiftUI

struct LocalNotificationsApp: App{
    
    init() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) {
            result, error in
            if let error = error {
                print(error)
            }
        }
    }
    var body: some Scene {
        WindowGroup{
            SomeView()
        }
    }
}
