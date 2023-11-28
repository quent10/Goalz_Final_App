//
//  ContentView.swift
//  goalz_final_App
//
//  Created by Quentin Wingard on 11/08/23.
//

import SwiftUI

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
                    
                    //Content
                    let content = UNMutableNotificationContent()
                    content.title = "Complete your goal!"
                    content.body = "You have 1 day left of your goal. Push hard!"
                    //
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
                    //Request
                    let request = UNNotificationRequest( identifier: "Identifier", content: content, trigger: trigger)
                    //Define actions
                    let dismiss = UNNotificationAction(identifier: NotificationAction.dismiss.rawValue, title: "Dismiss", options: [])
                    
                    let reminder = UNNotificationAction(identifier: NotificationAction.reminder.rawValue, title: "Reminder", options: [])
                    
                    let generalCategory = UNNotificationCategory(identifier: NotificationCategory.general.rawValue, actions: [dismiss, reminder], intentIdentifiers: [], options: [])
                    
                    center.setNotificationCategories([generalCategory])
                    //Add requests
                    center.add(request) {error in
                        if let error = error {
                            print(error)
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
