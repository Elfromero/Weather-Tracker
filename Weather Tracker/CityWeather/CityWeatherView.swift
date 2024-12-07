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
            AsyncImage(url: model.conditionIconUrl)
            { image in
                image.resizable()
            } placeholder: {
                Image("loading_placeholder")
                .resizable()
            }
            .frame(width: 123, height: 123)
            .padding(.bottom, 27)
            
            Text(model.name)
                .font(Font.custom("Poppins-SemiBold", size: 30))
                .foregroundStyle(Color.primaryBlack)
                .padding(.bottom, 16)
            Text("\(model.temperature)°")
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
            ("Humidity", "\(model.humidity*100)%" ),
            ("UV", "\(model.uvIndex)" ),
            ("Feels Like", "\(model.feelsLikeTemperature)°" )
        ]
    }
}

#Preview {
    let mock = CityWeatherModel(
        name: "Chicago",
        temperature: 40,
        conditionIconUrl: URL(string: "https://hws.dev/paul.jpg")! ,
        humidity: 0.3,
        uvIndex: 0.2,
        feelsLikeTemperature: 30
    )
    CityWeatherView(model: mock)
}
