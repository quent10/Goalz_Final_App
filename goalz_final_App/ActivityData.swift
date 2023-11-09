//
//  PetData.swift
//  goalz_final_App
//
//  Created by Quentin Wingard on 11/8/23.
//

import Foundation

struct PetData: Identifiable, Equatable {
    let year: Int
    
    
    let population: Double
    
    var id: Int { year }
    
    static var catExamples: [PetData] {
        [PetData(year: 1, population: 0),
         PetData(year: 2, population: 1),
         PetData(year: 3, population: 2),
         PetData(year: 4, population: 2)]
    }
    static var dogExamples: [PetData] {
        [PetData(year: 1, population: 1),
         PetData(year: 2, population: 2),
         PetData(year: 3, population: 3),
         PetData(year: 4, population: 4)]
    }
}
