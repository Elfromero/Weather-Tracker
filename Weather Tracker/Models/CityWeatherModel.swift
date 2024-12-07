//
//  CityWeatherModel.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/7/24.
//

import Foundation

struct CityWeatherModel {
    let name: String
    let temperature: Int
    let conditionIconUrl: URL
    let humidity: Double
    let uvIndex: Double
    let feelsLikeTemperature: Int
}
