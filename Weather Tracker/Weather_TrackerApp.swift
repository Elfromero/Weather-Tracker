//
//  Weather_TrackerApp.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/7/24.
//

import SwiftUI

@main
struct Weather_TrackerApp: App {
    let viewModel = MainViewModel()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
        }
    }
}
