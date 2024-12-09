//
//  LocationsListView.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/7/24.
//

import SwiftUI

struct SearchLocationListView<VM>: View where VM: SearchViewModel {
    @StateObject private var viewModel: VM
    let onSelectAction: (LocationModel, CityWeatherModel) -> Void
    
    init(
        viewModel: @autoclosure @escaping () -> VM,
        onSelectAction: @escaping (LocationModel, CityWeatherModel) -> Void
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel())
        self.onSelectAction = onSelectAction
    }
    
    var body: some View {
        List {
            ForEach(viewModel.locationsList, id: \.0) { location, weather in
                CityWeatherThumbnailView(model: weather)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        onSelectAction(location, weather)
                    }
            }
        }
        .frame( maxWidth: .infinity)
        .listStyle(GroupedListStyle())
        .alert(viewModel.errorToPresent?.localizedDescription ?? "Error. Contact with technical support", isPresented: isShowingError) {
            Button("OK", role: .cancel) {
                viewModel.closeErrorMessage()
            }
        }
    }
    
    var isShowingError: Binding<Bool> {
        Binding {
            viewModel.errorToPresent != nil
        } set: { _ in
            viewModel.errorToPresent = nil
        }
    }
}

#Preview {
    let service = WeatherInfoRemoteService()
    SearchLocationListView(viewModel: SearchLocationViewModel(service: service), onSelectAction: {_,_ in })
}
