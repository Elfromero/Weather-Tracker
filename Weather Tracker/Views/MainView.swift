//
//  WeatherView.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/7/24.
//

import SwiftUI

struct MainView<VM>: View where VM: MainViewModel {
    @StateObject private var viewModel: VM
    @State private var isSearchFieldFocused: Bool = false
    
    init(viewModel: @autoclosure @escaping () -> VM) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        NavigationStack {
            if isSearchFieldFocused {
                SearchLocationListView(viewModel: viewModel.searchViewModel) {
                    viewModel.select($0, with: $1)
                    isSearchFieldFocused = false
                }
            } else if let selectedCityWeather = viewModel.selectedCityWeather {
                CityWeatherView(model: selectedCityWeather)
            } else {
                NoLocationSelectedView()
                    .frame(maxHeight: .infinity)
                    .padding()
            }
        }
        .searchable(text: $viewModel.searchViewModel.searchLocationInput, isPresented: $isSearchFieldFocused)
        .font(Font.custom("Poppins-Regular", size: 15))
        .foregroundStyle(Color.primaryShadow)
        .onTapGesture { isSearchFieldFocused = false }
        .task {
            await viewModel.fetchStoredLocationWeather()
        }
    }
}

#Preview {
    let service = WeatherInfoRemoteService()
    MainView(
        viewModel: MainScreenViewModel(
            service: service,
            searchViewModel: SearchLocationViewModel(service: service)
            )
    )
}
