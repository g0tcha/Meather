//
//  WeatherView.swift
//  Meather
//
//  Created by Vincent Grossier on 06/05/2023.
//

import SwiftUI

struct WeatherView: View {
    
    var weather: WeatherData
    let imageUrl = URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")!
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold()
                        .font(.title)
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            VStack(spacing: 20) {
                                Image(systemName: "sun.max")
                                    .font(.system(size: 40))
                                Text(weather.weather.first?.main ?? "")
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            Spacer()
                            
                            Text(weather.main.feels_like.roundDouble() + "°")
                                .font(.system(size: 100))
                                .fontWeight(.bold)
                                .padding()
                        }
                        
                        Spacer()
                            .frame(height: 80)
                        
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 350)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now")
                        .bold()
                        .padding(.bottom)
                    
                    HStack {
                        WeatherRow(
                            logo: "thermometer",
                            name: "Min temp",
                            value: weather.main.temp_min.roundDouble() + "°"
                        )
                        Spacer()
                        WeatherRow(
                            logo: "thermometer",
                            name: "Max temp",
                            value: weather.main.temp_max.roundDouble() + "°"
                        )
                    }
                    HStack {
                        WeatherRow(
                            logo: "wind",
                            name: "Min temp",
                            value: weather.wind.speed.roundDouble() + "m/s"
                        )
                        Spacer()
                        WeatherRow(
                            logo: "humidity",
                            name: "Humidity",
                            value: weather.main.humidity.roundDouble() + "%"
                        )
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
