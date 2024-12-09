//
//  CityWeatherView.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/7/24.
//

import SwiftUI

struct CityWeatherView: View {
    let model: CityWeatherModel
    var body: some View {
        VStack {
            WeatherIconView(path: model.conditionIconUrl)
            .frame(width: 123, height: 123)
            .padding(.bottom, 27)
            
            Text(model.name)
                .font(Font.custom("Poppins-SemiBold", size: 30))
                .foregroundStyle(Color.primaryBlack)
                .padding(.bottom, 16)
            Text("\(Int(model.temperature))°")
                .font(Font.custom("Poppins-Medium", size: 70))
                .foregroundStyle(Color.primaryBlack)
            
            CityWeatherDetailsView(model: model)
                .padding(.top, 36)
        }
    }
}

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
    CityWeatherView(model: mock)
}
