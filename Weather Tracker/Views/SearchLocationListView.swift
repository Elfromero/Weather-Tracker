//
//  LocationsListView.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/7/24.
//

import SwiftUI

struct SearchLocationListView: View {
    let locations: [(LocationModel, CityWeatherModel)]
    @Binding var selcetedCity: (LocationModel, CityWeatherModel)?
    
    var body: some View {
        List {
            ForEach(locations, id: \.0) { location, weather in
                CityWeatherThumbnailView(model: weather)
                    .onTapGesture {
                        selcetedCity = location
                    }
                    .listRowSeparator(.hidden)
            }
        }
        
        .frame( maxWidth: .infinity)
        .listStyle(GroupedListStyle())
    }
}

#Preview {
    SearchLocationListView(locations: [], selcetedCity: .constant(nil))
}
