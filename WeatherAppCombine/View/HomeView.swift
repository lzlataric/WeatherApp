//
//  HomeView.swift
//  WeatherAppCombine
//
//  Created by Luka Zlatarić on 29.10.2021..
//

import SwiftUI

struct HomeView: View {
    @StateObject var currentTimeViewModel = CurrentTimeViewModel()
    @EnvironmentObject var cityViewModel: CityViewModel
    @StateObject var searchedCityTimeViewModel = SearchedCityTimeViewModel()
    
    @State var long: Double = 0
    @State var lat: Double = 0
    @State var pushView = false
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.blue
                    .ignoresSafeArea()
                VStack{
                    if(currentTimeViewModel.currentTime == ""){
                        Text(currentTimeViewModel.time)
                            .foregroundColor(.white)
                            .font(.system(size: 30.0, weight: .bold))
                    }else{
                        Text(currentTimeViewModel.currentTime)
                            .foregroundColor(.white)
                            .font(.system(size: 30.0, weight: .bold))
                    }
                    if #available(iOS 15.0, *) {
                        Image(systemName: "cloud.sun.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, .yellow)
                            .font(.system(size: 150.0, weight: .bold))
                            .padding(.top, 30)
                    } else {
                        Image(systemName: "sun.max.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 150.0, weight: .bold))
                            .padding(.top, 30)
                    }
                    
                    Spacer()
                    
                    VStack{
                        VStack{
                            TextField("City name..", text: $cityViewModel.searchedCity)
                                .frame(width: 300, height: 50, alignment: .center)
                                .textFieldStyle(.roundedBorder)
                                .multilineTextAlignment(.center)
                        }
                        ScrollView{
                            VStack{
                                if let cities = cityViewModel.fetchedCities{
                                    if cities.data.isEmpty{
                                        Text("No results")
                                    }else{
                                        ForEach(cities.data){ index in
                                            NavigationLink(destination: CityWeatherView(lat: index.latitude, long: index.longitude, cityName: index.name)) {
                                                HStack{
                                                    Text(index.name)
                                                        .font(.title3)
                                                }
                                                .frame(width: 300, height: 80, alignment: .center)
                                                .background(Color.white)
                                                .cornerRadius(10)
                                                .foregroundColor(.blue)
                                            }
                                        }
                                    }
                                }else{
                                    if cityViewModel.searchedCity != "" {
                                        ProgressView()
                                            .padding(.top, 20)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
        }.accentColor(.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
