//
//  WeatherView.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/7/24.
//

import SwiftUI

struct MainView<VM, SVM>: View where VM: MainViewModel, SVM: SearchViewModel{
    @StateObject private var viewModel: VM
    @StateObject private var searchViewModel: SVM
    @State private var isSearchFieldFocused: Bool = false
    
    init(viewModel: @autoclosure @escaping () -> VM, searchViewModel: @autoclosure @escaping () -> SVM) {
        self._viewModel = StateObject(wrappedValue: viewModel())
        self._searchViewModel = StateObject(wrappedValue: searchViewModel())
      }
    var body: some View {
        NavigationStack {
            if isSearchFieldFocused {
                SearchLocationListView(locations: searchViewModel.locationsList, selcetedCity: $viewModel.selectedCityWeather)
            } else if let selectedCityWeather = viewModel.selectedCityWeather {
                CityWeatherView(model: selectedCityWeather)
            } else {
                NoLocationSelectedView()
                    .frame(maxHeight: .infinity)
                    .padding()
            }
        }
        .searchable(text: $searchViewModel.searchLocationInput, isPresented: $isSearchFieldFocused)
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
        viewModel: MainScreenViewModel(service: service),
        searchViewModel: SearchLocationViewModel(service: service)
    )
}
