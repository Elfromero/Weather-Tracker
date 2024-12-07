//
//  MainViewModel.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/7/24.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var searchLocationInput: String = ""
    @Published var selectedCityWeather: CityWeatherModel?
}
