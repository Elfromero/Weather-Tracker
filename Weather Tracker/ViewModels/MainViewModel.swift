//
//  MainViewModel.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/7/24.
//

import Foundation

protocol MainViewModel: ObservableObject {
    associatedtype SearchVM: SearchViewModel
    var selectedCityWeather: CityWeatherModel? { get }
    var searchViewModel: SearchVM { get set }
    var errorToPresent: Error? { get set }
    func closeErrorMessage()
    func fetchStoredLocationWeather() async
    func select(_ location: LocationModel, with weatherModel: CityWeatherModel)
}

final class MainScreenViewModel<SVM>: MainViewModel where SVM: SearchViewModel {
    typealias SearchVM = SVM
    
    @Published var selectedCityWeather: CityWeatherModel?
    @Published var errorToPresent: Error?
    
    var searchViewModel: SearchVM
    private let service: WeatherInfoService
    
    init(service: WeatherInfoService, searchViewModel: SVM) {
        self.service = service
        self.searchViewModel = searchViewModel
    }
    
    @MainActor
    func fetchStoredLocationWeather() async {
        guard let storedSelectedLocationID = UserDefaults.standard.string(forKey: "selected_location_id") else { return }
        do {
            let weather = try await service.getWeather(with: storedSelectedLocationID)
            selectedCityWeather = weather
        } catch {
            errorToPresent = error
        }
    }
    
    func select(_ location: LocationModel, with weatherModel: CityWeatherModel) {
        Task { @MainActor in
            selectedCityWeather = weatherModel
            UserDefaults.standard.set(location.id, forKey: "selected_location_id")
        }
    }
    
    var isShowingError: Bool {
        errorToPresent != nil
    }
    
    func closeErrorMessage() {
        errorToPresent = nil
    }
}
