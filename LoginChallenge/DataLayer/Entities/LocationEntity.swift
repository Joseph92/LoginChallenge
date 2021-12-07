//
//  LocationEntity.swift
//  LoginChallenge
//
//  Created by Josseph Colonia on 7/12/21.
//

import Foundation

struct LocationEntity: Decodable {
    let longitud: Double
    let latitude: Double
    let currentDate: String
    
    enum CodingKeys: String, CodingKey {
        case longitud = "lng"
        case latitude = "lat"
        case currentDate = "time"
    }
}
