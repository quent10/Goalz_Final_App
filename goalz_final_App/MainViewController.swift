//
//  ContentView.swift
//  goalz_final_App
//
//  Created by Quentin Wingard on 11/08/23.
//

import SwiftUI
import UserNotifications

struct SomeView: View {
    @State private var selectedDate = Date()
    @State private var notificationTitle = ""
    @State private var notificationBody = ""
    @State private var showAlert = false // State to control the alert visibility

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("GOALZ")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                        .padding(.bottom, 200)

                    TextField("Goal name", text: $notificationTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("What's our goal?", text: $notificationBody)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    DatePicker("Select Date and Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .padding()

                    Button("Schedule a Notification") {
                        scheduleNotification()
                    }
                    .padding()

                    Spacer()
                }
                .navigationBarTitle("")
                .navigationBarHidden(false)
            }
            .background(Color.gray.edgesIgnoringSafeArea(.all)) //Set the background color to grey for the entire view
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(notificationTitle.isEmpty ? "Walk" : notificationTitle),
                  message: Text(notificationBody.isEmpty ? "Go for a 5 mile walk?" : notificationBody),
                  dismissButton: .default(Text("OK")))
        }
    }

    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }

        let content = UNMutableNotificationContent()
        content.title = notificationTitle.isEmpty ? "Walk" : notificationTitle
        content.body = notificationBody.isEmpty ? "Go for a 5 mile walk?" : notificationBody

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: selectedDate)

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        center.add(request) { error in
            if let error = error {
                print("Error adding notification request: \(error)")
            } else {
                print("Notification request added successfully")
                // Show alert when a notification is scheduled
                self.showAlert = true
            }
        }
    }
}

struct SomeView_Previews: PreviewProvider {
    static var previews: some View {
        SomeView()
    }
}
