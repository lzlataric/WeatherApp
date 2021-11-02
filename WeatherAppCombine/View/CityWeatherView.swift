//
//  CityWeatherView.swift
//  WeatherAppCombine
//
//  Created by Luka Zlatarić on 29.10.2021..
//

import SwiftUI

struct CityWeatherView: View {
    
    var lat: Double
    var long: Double
    var cityName : String
    
    @StateObject var searchedCityTimeViewModel = SearchedCityTimeViewModel()
    @StateObject var weatherViewModel = WeatherViewModel()
    
    var body: some View {
        ZStack{
            Color.blue
                .ignoresSafeArea()
            VStack {
                VStack{
                    Group(){
                        Text(cityName)
                            .font(.system(size: 35.0, weight: .bold))
                        
                        if searchedCityTimeViewModel.time == "" {
                            ProgressView()
                                .padding(.top, 20)
                        }else{
                            Text(searchedCityTimeViewModel.time)
                                .font(.system(size: 25.0, weight: .bold))
                                .padding(.top, 5)
                            if weatherViewModel.fetchedWeather?.current.weather[0].main != nil{
                                if weatherViewModel.fetchedWeather?.current.weather[0].main == "Clear"{
                                    getWeatherPicture(weather: weatherViewModel.fetchedWeather?.current.weather[0].main ?? "")
                                        .foregroundColor(.yellow)
                                        .font(.system(size: 100.0, weight: .bold))
                                        .padding(.top, 5)
                                }else{
                                    getWeatherPicture(weather: weatherViewModel.fetchedWeather?.current.weather[0].main ?? "")
                                        .font(.system(size: 100.0, weight: .bold))
                                        .padding(.top, 5)
                                }
                            }
                            
                            Text(weatherViewModel.fetchedWeather?.current.weather[0].main ?? "")
                                .font(.system(size: 25.0, weight: .bold))
                            
                            Text(String(KToC(KelvTemp: weatherViewModel.fetchedWeather?.current.temp ?? 0))+"°C")
                                .font(.system(size: 25.0, weight: .bold))
                            
                            HStack(spacing: 40){
                                HStack{
                                    Image(systemName: "speedometer")
                                    Text(String(weatherViewModel.fetchedWeather?.current.pressure ?? 0)+"hPa")
                                }
                                HStack{
                                    Image(systemName: "humidity.fill")
                                    Text(String(weatherViewModel.fetchedWeather?.current.humidity ?? 0)+"%")
                                }
                                HStack{
                                    Image(systemName: "wind")
                                    Text(String(weatherViewModel.fetchedWeather?.current.wind_speed ?? 0)+"m/s")
                                }
                            }
                            .padding(.top, 30)
                            
                            VStack{
                                SevenDayView(days: weatherViewModel.fetchedWeather?.daily ?? [])
                            }
                            .padding(.top, 30)
                        }
                    }
                    
                }.foregroundColor(.white)
                
            }.onAppear {
                searchedCityTimeViewModel.test(lat: lat, long: long)
                weatherViewModel.setCancelable(lat: lat, long: long)
            }
        }
    }
}

struct CityWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CityWeatherView(lat: 43.384444444, long: 16.555277777, cityName: "Supetar")
    }
}
