//
//  ChartsView.swift
//  goalz_final_App
//
//  Created by Quentin Wingard on 11/6/23.
//

import SwiftUI
import Charts

struct ChartsView: View {
    let catData = ActivityData.catExamples
    let dogData = ActivityData.dogExamples
    
    var data: [(type: String, activityData: [ActivityData])] {
        [(type: "Run", activityData: catData),
         (type: "Swim", activityData: dogData)]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Goal Progress") // Your title
                    .font(.title)
                    .padding()
                
                Chart(data, id: \.type) { dataSeries in
                    ForEach(dataSeries.activityData) { data in
                        LineMark(x: .value("Time", data.year),
                                 y: .value("Activity", data.population))
                            .foregroundStyle(.black) // Set text color to black
                    }
                    .symbol(by: .value("Activity type", dataSeries.type))
                }
                .chartXScale(domain: 1...7)
                .chartXAxisLabel("Days")
                .chartYAxisLabel("# Completions")
                .aspectRatio(1, contentMode: .fit)
                .padding()
                
            }
            .background(Color.gray.edgesIgnoringSafeArea(.all)) // Set the background color to grey for the entire view
        }
    }
}

struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}
