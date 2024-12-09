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
            .padding(.top, 80)
            
            Text(model.name)
                .font(Font.custom("Poppins-SemiBold", size: 30))
                .foregroundStyle(Color.primaryBlack)
            Text("\(Int(model.temperature))°")
                .font(Font.custom("Poppins-Medium", size: 70))
                .foregroundStyle(Color.primaryBlack)
            
            CityWeatherDetailsView(model: model)
                .background(.red)
        }
        Spacer()
    }
}

#Preview {
    let mockData = #"{"location":{"name":"London"},"current":{"temp_c":6.1,"temp_f":43.0,"condition":{"icon":"//cdn.weatherapi.com/weather/64x64/night/296.png"},"humidity":87,"feelslike_c":1.2,"feelslike_f":34.1,"uv":0.0}}"#.data(using: .utf8)
    let mock = try! JSONDecoder().decode(CityWeatherModel.self, from: mockData!)
    CityWeatherView(model: mock)
}
