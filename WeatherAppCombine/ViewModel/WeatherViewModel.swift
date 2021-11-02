//
//  WeatherViewModel.swift
//  WeatherAppCombine
//
//  Created by Luka Zlatarić on 01.11.2021..
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject{
    @Published var fetchedWeather: WeatherModel? = nil
    
    @Published var latitude: Double = 0
    @Published var longitude: Double = 0
    @Published var dateNum: Int = 0
    
    var cancellable: AnyCancellable? = nil
    
    init() {}

    func setCancelable(lat: Double, long: Double){
        self.latitude = lat
        self.longitude = long
        cancellable = $latitude
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: {str in
                if str != 0{
                    self.getWeather()
                }
            })
    }
    
    func getWeather(){
        guard let url = URL(string:"https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely,hourly&appid=fea3484bcaa73f8523b6a16e6b6b706e") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){ (data, _, err) in
            if let error = err{
                print(error)
                return
            }
            guard let ApiData = data else{
                print("No data")
                return
            }
            do{
                let weather = try JSONDecoder().decode(WeatherModel.self, from: ApiData)
                DispatchQueue.main.async {
                    self.fetchedWeather = weather
                    self.dateNum = weather.current.dt
                }
            }catch{
                print(error)
            }
        }.resume()
    }
    
}
