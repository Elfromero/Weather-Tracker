//
//  SearchLocationViewModel.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/8/24.
//

import Foundation

protocol SearchViewModel: ObservableObject {
    var searchLocationInput: String { get set }
    var locationsList: [(LocationModel, CityWeatherModel)] { get }
    var errorToPresent: Error? { get set }
    func closeErrorMessage()
}

final class SearchLocationViewModel: SearchViewModel {    
    @Published var searchLocationInput: String = "" {
        didSet {
            guard searchLocationInput.count >= 3 else { return }
            Task { await updateLocations(with: searchLocationInput) }
        }
    }
    @Published var locationsList: [(LocationModel, CityWeatherModel)] = []
    private let service: WeatherInfoService
    var errorToPresent: Error?

    init(service: WeatherInfoService) {
        self.service = service
    }
    
    @MainActor
    private func updateLocations(with string: String) async {
        do {
            let locations = try await service.searchLocations(with: string)
            locationsList = locations
        } catch {
            locationsList = []
            errorToPresent = error
        }
    }
    
    func closeErrorMessage() {
        errorToPresent = nil
    }
}
