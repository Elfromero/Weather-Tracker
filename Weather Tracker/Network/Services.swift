//
//  Services.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/7/24.
//

import Foundation
import Alamofire
import SwiftUICore

protocol WeatherInfoService {
    func getWeather(with locationID: String) async throws -> CityWeatherModel
    func searchLocations(with string: String) async throws -> [(LocationModel, CityWeatherModel)]
}

actor WeatherInfoRemoteService: WeatherInfoService {
    private enum Endpoint {
        static let currentWeather = "/current.json"
        static let searchLocations = "/search.json"
    }
    
    enum ParameterKey {
        static let location = "q"
    }
    
    private let networkManager = NetworkManager.shared
    
    func getWeather(with locationID: String) async throws -> CityWeatherModel {
        do {
            let data = try await networkManager.get(
                path: Endpoint.currentWeather,
                parameters: [ParameterKey.location: "id:" + locationID]
            )
            return try JSONDecoder().decode(CityWeatherModel.self, from: data)
        } catch let error {
            //TODO: Map errors.
            print(error.localizedDescription)
            throw error
        }
    }
    
    func searchLocations(with string: String) async throws -> [(LocationModel, CityWeatherModel)] {
        do {
            let data = try await networkManager.get(
                path: Endpoint.searchLocations,
                parameters: [ParameterKey.location: string]
            )
            let locations = try JSONDecoder().decode([LocationModel].self, from: data)
            return try await withThrowingTaskGroup(of: (LocationModel, CityWeatherModel).self) { group in
                for location in locations {
                    group.addTask {
                        (location, try await self.getWeather(with: location.id))
                    }
                }
                var result: [LocationModel: CityWeatherModel] = [:]
                while let workResult = await group.nextResult() {
                    switch workResult {
                    case .success(let value): result[value.0] = value.1
                    case .failure(let error): throw error
                    }
                }
                return locations.map() { ($0, result[$0]!) }
            }
        } catch let error {
            //TODO: Map errors.
            print(error.localizedDescription)
            throw error
        }
    }
}
