//
//  MainViewModel.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/7/24.
//

import Foundation

protocol MainViewModel: ObservableObject {
    var selectedCityWeather: CityWeatherModel? { get set }
    func fetchStoredLocationWeather() async
}

final class MainScreenViewModel: MainViewModel {
    @MainActor
    @Published var selectedCityWeather: (LocationModel, CityWeatherModel)? {
        didSet {
            UserDefaults.standard.set(selectedCityWeather, forKey: "selected_location")
        }
    }
    
    private let service: WeatherInfoService
    
    init(service: WeatherInfoService) {
        self.service = service
        UserDefaults.standard.set("London", forKey: "selected_location")
    }
    
    func fetchStoredLocationWeather() async {
        guard let storedSelectedLocationID = UserDefaults.standard.string(forKey: "selected_location") else { return }
        let weather = try! await service.getWeather(with: storedSelectedLocationID)
        await MainActor.run {
            selectedCityWeather = weather
        }
    }
    
//    @MainActor
//    func select(_ cityWeather: CityWeatherModel) async {
//        selectedCityWeather = cityWeather
//    }
}
