//
//  BeginningView.swift
//  goalz_final_App
//
//  Created by Quentin Wingard on 12/14/23.
//

import SwiftUI
import UserNotifications

struct HomeView: View {
    var body: some View {
        Text("Home Content")
            .font(.title)
    }
}



struct TabbedView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Goal", systemImage: "circle")
                }
            
            ChartsView()
                .tabItem {
                    Label("Progress", systemImage: "flask")
                }
            
            SomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            DateSelectionView()
                .tabItem {
                    Label("Date", systemImage: "calendar")
                }
        }
    }
}

struct TabbedView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView()
    }
}

