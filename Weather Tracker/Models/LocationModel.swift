//
//  LocationModel.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/8/24.
//

import Foundation

struct LocationModel: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let region: String
    let country: String
}
