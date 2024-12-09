//
//  CityWeatherModel.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/7/24.
//

import Foundation

struct CityWeatherModel: Decodable {
    let location: WeatherLocationModle
    let current: WeatherModel
    
    var name: String { location.name }
    var temperature: Double { current.temp_f }
    var conditionIconUrl: String { current.condition.icon }
    var humidity: Int { current.humidity }
    var uvIndex: Double { current.uv }
    var feelsLikeTemperature: Double { current.feelslike_f }
}

struct WeatherLocationModle: Decodable {
    let name: String
}

struct WeatherModel: Decodable {
    let temp_c, temp_f: Double
    let condition: WeatherCondition
    let humidity: Int
    let uv: Double
    let feelslike_c, feelslike_f: Double
}

struct WeatherCondition: Decodable {
    let icon: String
}
