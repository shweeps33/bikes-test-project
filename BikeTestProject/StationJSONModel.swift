//
//  StationJSONModel.swift
//  BikeTestProject
//
//  Created by David on 03.06.2022.
//

import SwiftUI

struct StationJSONModel: Decodable {
    struct Station: Decodable, Identifiable, Equatable {
        struct Property: Decodable, Equatable {
            enum CodingKeys: String, CodingKey {
                case bikes
                case freePlaces = "free_racks"
                case name = "label"
            }
            
            let name: String
            let freePlaces: String
            let bikes: String
        }
        
        struct Geometry: Decodable, Equatable {
            let coordinates: [Double]
        }
        
        let geometry: Geometry
        let id: String
        let properties: Property
    }
    
    let features: [Station]
}
