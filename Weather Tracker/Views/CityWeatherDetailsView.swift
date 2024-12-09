//
//  CityWeatherDetailsView.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/8/24.
//

import SwiftUI

struct CityWeatherDetailsView: View {
    let model: CityWeatherModel
    var body: some View {
        HStack {
            ForEach(contentInfo, id: \.0) { title, value in
                VStack {
                    Text(title)
                        .font(Font.custom("Poppins-SemiBold", size: 12))
                        .foregroundStyle(Color.primaryShadow)
                    Text(value)
                        .font(Font.custom("Poppins-Medium", size: 15))
                        .foregroundStyle(Color.primaryInactive)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(width: 274, height: 75)
        .background(Color.secondaryBackground)
        .cornerRadius(16)
    }
    
    private var contentInfo: [(String, String)] {
        [
            ("Humidity", "\(model.humidity)%" ),
            ("UV", "\(Int(model.uvIndex))" ),
            ("Feels Like", "\(Int(model.feelsLikeTemperature))°" )
        ]
    }
}

#Preview {
    let mockData = #"{"location":{"name":"London"},"current":{"temp_c":6.1,"temp_f":43.0,"condition":{"icon":"//cdn.weatherapi.com/weather/64x64/night/296.png"},"humidity":87,"feelslike_c":1.2,"feelslike_f":34.1,"uv":0.0}}"#.data(using: .utf8)
    let mock = try! JSONDecoder().decode(CityWeatherModel.self, from: mockData!)
    CityWeatherDetailsView(model: mock)
}
