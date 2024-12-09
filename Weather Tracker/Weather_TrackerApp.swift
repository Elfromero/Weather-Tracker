//
//  Weather_TrackerApp.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/7/24.
//

import SwiftUI

@main
struct Weather_TrackerApp: App {
    let service = WeatherInfoRemoteService()
    
    var body: some Scene {
        let searchLocationViewModel = SearchLocationViewModel(service: service)
        let mainScreenViewModel = MainScreenViewModel(service: service, searchViewModel: searchLocationViewModel)
        return WindowGroup {
            MainView(
                viewModel: mainScreenViewModel
            )
        }
    }
}
