//
//  ChartsView.swift
//  goalz_final_App
//
//  Created by Quentin Wingard on 11/6/23.
//

import SwiftUI
import Charts

struct ChartsView: View {
    let catData = PetData.catExamples
    let dogData = PetData.dogExamples
    
    var data: [(type: String, petData: [PetData])] {
        [(type: "Run", petData: catData),
         (type: "Swim", petData: dogData)]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Goal Progress") // Your title
                    .font(.title)
                    .padding()
                
                Chart(data, id: \.type) { dataSeries in
                    ForEach(dataSeries.petData) { data in
                        LineMark(x: .value("Year", data.year),
                                 y: .value("Population", data.population))
                    }
                    .foregroundStyle(by: .value("Pet type", dataSeries.type))
                    .symbol(by: .value("Pet type", dataSeries.type))
                }
                .chartXScale(domain: 1...7)
                .chartXAxisLabel("Days")
                .chartYAxisLabel("# Completions")
                .aspectRatio(1, contentMode: .fit)
                .padding()
            }
        }
    }
}

struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}
