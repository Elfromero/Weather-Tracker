//
//  CityWeatherThumbnailView.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/8/24.
//

import SwiftUI

struct CityWeatherThumbnailView: View {
    let model: CityWeatherModel
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(model.name)
                    .font(Font.custom("Poppins-SemiBold", size: 20))
                    .foregroundStyle(Color.primaryBlack)
                Text("\(Int(model.temperature))°")
                    .font(Font.custom("Poppins-Medium", size: 60))
                    .foregroundStyle(Color.primaryBlack)
                    .frame(height: 45)
            }
            .frame(maxWidth: 150)
            .scaledToFit()
            Spacer()
            WeatherIconView(path: model.conditionIconUrl)
            .frame(width: 83, height: 83)
        }
        .padding(.horizontal, 31)
        .frame(height: 117)
        .frame(maxWidth: .infinity)
        .background(Color.secondaryBackground)
        .cornerRadius(16)
    }
}

#Preview {
    let mockData = #"{"location":{"name":"London"},"current":{"temp_c":6.1,"temp_f":43.0,"condition":{"icon":"//cdn.weatherapi.com/weather/64x64/night/296.png"},"humidity":87,"feelslike_c":1.2,"feelslike_f":34.1,"uv":0.0}}"#.data(using: .utf8)
    let mock = try! JSONDecoder().decode(CityWeatherModel.self, from: mockData!)
    CityWeatherThumbnailView(model: mock)
}
