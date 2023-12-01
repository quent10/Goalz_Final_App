//
//  ContentView.swift
//  goalz_final_App
//
//  Created by Quentin Wingard on 11/08/23.
//

import SwiftUI
import UserNotifications

enum NotificationAction: String {
    case dismiss
    case reminder
}

enum NotificationCategory: String {
    case general
}

struct SomeView: View {
    @State private var selectedDate = Date() // State variable to hold the selected date
    
    var body: some View {
        NavigationView {
            ScrollView { // Wrapping VStack inside ScrollView
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
                    
                    // Date picker to select a specific date and time
                    DatePicker("Select Date and Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .padding()
                    
                    // Button to schedule a notification
                    Button("Schedule a Notification") {
                        scheduleNotification() // Calls the function to schedule the notification
                    }
                    
                    Spacer() // Spacer to push content to the top
                }
                .navigationBarTitle("") // Empty title to hide the default title
                .navigationBarHidden(true) // Hide the navigation bar
            }
        }
    }
    
    // Function to schedule the notification based on the selected date
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        
        // Request permission to show notifications
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Complete your goal!"
        content.body = "You have 1 day left of your goal. Push hard!"
        
        // Convert selected date to components
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: selectedDate)
        
        // Set the trigger for the selected date and time
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)
        
        let dismiss = UNNotificationAction(identifier: NotificationAction.dismiss.rawValue, title: "Dismiss", options: [])
        let reminder = UNNotificationAction(identifier: NotificationAction.reminder.rawValue, title: "Reminder", options: [])
        
        let generalCategory = UNNotificationCategory(identifier: NotificationCategory.general.rawValue, actions: [dismiss, reminder], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([generalCategory])
        
        // Add the notification request
        center.add(request) { error in
            if let error = error {
                print("Error adding notification request: \(error)")
            } else {
                print("Notification request added successfully")
            }
        }
    }
}

struct SomeView_Previews: PreviewProvider {
    static var previews: some View {
        SomeView()
    }
}
