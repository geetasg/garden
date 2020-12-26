//
//  Plant.swift
//  PlantTracker
//
//  Created by Aditi on 11/3/20.
//

import Foundation

class Plant {
    let commonName: String
    let scientificName: String
    let variety: String
    let whenToPlant: Date
    let harvestTime: Int
    
    init(commonName: String, scientificName: String, variety: String, whenToPlant: Date, harvestTime: Int) {
        self.commonName = commonName
        self.scientificName = scientificName
        self.variety = scientificName
        self.whenToPlant = whenToPlant
        self.harvestTime = harvestTime
    }
}
