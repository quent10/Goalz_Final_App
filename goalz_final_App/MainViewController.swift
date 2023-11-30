//
//  ContentView.swift
//  goalz_final_App
//
//  Created by Quentin Wingard on 11/08/23.
//

import SwiftUI
import UserNotifications // Import UserNotifications framework

enum NotificationAction: String {
    case dismiss
    case reminder
}

enum NotificationCategory: String {
    case general
}

struct SomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("GOALZ")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .padding(.bottom, 200)

                NavigationLink(destination: ContentView()) {
                    Text("Choose a goal")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                NavigationLink(destination: DateSelectionView()) {
                    Text("Choose Date")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                NavigationLink(destination: ChartsView()) {
                    Text("Progress")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Button("Schedule a Notification"){
                    let center = UNUserNotificationCenter.current()
                    
                    // Request permission to show notifications
                    center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                        if granted {
                            print("Notification permission granted")
                        } else {
                            print("Notification permission denied")
                        }
                    }
                    
                    // Content for the notification
                    let content = UNMutableNotificationContent()
                    content.title = "Complete your goal!"
                    content.body = "You have 1 day left of your goal. Push hard!"
                    
                    // Trigger for the notification after 5 seconds
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
                    
                    // Request to display the notification
                    let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)
                    
                    // Define actions for the notification
                    let dismiss = UNNotificationAction(identifier: NotificationAction.dismiss.rawValue, title: "Dismiss", options: [])
                    
                    let reminder = UNNotificationAction(identifier: NotificationAction.reminder.rawValue, title: "Reminder", options: [])
                    
                    let generalCategory = UNNotificationCategory(identifier: NotificationCategory.general.rawValue, actions: [dismiss, reminder], intentIdentifiers: [], options: [])
                    
                    center.setNotificationCategories([generalCategory])
                    
                    // Add the request to show the notification
                    center.add(request) { error in
                        if let error = error {
                            print("Error adding notification request: \(error)")
                        } else {
                            print("Notification request added successfully")
                        }
                    }
                }
                
                Spacer() // Spacer to push content to the top
            }
            .navigationBarTitle("") // Empty title to hide the default title
            .navigationBarHidden(true) // Hide the navigation bar
        }
    }
}

struct SomeView_Previews: PreviewProvider {
    static var previews: some View {
        SomeView()
    }
}
