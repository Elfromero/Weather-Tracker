//
//  Weather_TrackerApp.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/7/24.
//

import SwiftUI

@main
struct Weather_TrackerApp: App {
    private let service = WeatherInfoRemoteService()

    var body: some Scene {
        WindowGroup {
            MainView(
                viewModel: MainScreenViewModel(service: service),
                searchViewModel: SearchLocationViewModel(service: service)
            )
        }
    }
    
    
}
