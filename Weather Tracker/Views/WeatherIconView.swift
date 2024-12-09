//
//  WeatherIconView.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/8/24.
//

import SwiftUI

struct WeatherIconView: View {
    let path: String
    
    var body: some View {
        iconView
    }
    
    private var iconView: some View {
        do {
            let iconURL = try IconURLBuilder(path: path)
                .size(.large)
                .build()
            return AnyView(AsyncImage(url: iconURL) { $0.resizable() }
            placeholder: {
                defaultIcon
            })
        } catch {
            assertionFailure(error.localizedDescription)
            return AnyView(defaultIcon)
        }
    }
    
    private var defaultIcon: some View {
        Image("loading_placeholder").resizable()
    }
}

#Preview {
    WeatherIconView(path: "//cdn.weatherapi.com/weather/64x64/day/113.png")
}
