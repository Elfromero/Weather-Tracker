//
//  WeatherView.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/7/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var viewModel: MainViewModel
    @State private var isSearchFieldFocused: Bool = false
    var body: some View {
        NavigationStack {
            if isSearchFieldFocused {
                LocationsListView()
            } else if let selectedCityWeather = viewModel.selectedCityWeather {
                CityWeatherView(model: selectedCityWeather)
            } else {
                NoLocationSelectedView()
                    .frame(maxHeight: .infinity)
                    .padding()
            }
        }
        .searchable(text: $viewModel.searchLocationInput, isPresented: $isSearchFieldFocused)
        .font(Font.custom("Poppins-Regular", size: 15))
        .foregroundStyle(Color.primaryShadow)
        .onTapGesture { isSearchFieldFocused = false }
    }
}

#Preview {
    MainView()
        .environmentObject(MainViewModel())
}
