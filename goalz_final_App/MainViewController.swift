//
//  ContentView.swift
//  goalz_final_App
//
//  Created by Quentin Wingard on 11/08/23.
//

import SwiftUI

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
