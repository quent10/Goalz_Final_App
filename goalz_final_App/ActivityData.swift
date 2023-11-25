//
//  PetData.swift
//  goalz_final_App
//
//  Created by Quentin Wingard on 11/8/23.
//

import Foundation

struct ActivityData: Identifiable, Equatable {
    let year: Int
    
    
    let population: Double
    
    var id: Int { year }
    
    static var catExamples: [ActivityData] {
        [ActivityData(year: 1, population: 0),
         ActivityData(year: 2, population: 1),
         ActivityData(year: 3, population: 2),
         ActivityData(year: 4, population: 2)]
    }
    static var dogExamples: [ActivityData] {
        [ActivityData(year: 1, population: 1),
         ActivityData(year: 2, population: 2),
         ActivityData(year: 3, population: 3),
         ActivityData(year: 4, population: 4)]
    }
}
