//
//  LocationModel.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/8/24.
//

import Foundation

struct LocationModel: Decodable, Identifiable, Hashable {
    let id: String
    let name: String
    let region: String
    let country: String
    let lat: Float
    let lon: Float
}
