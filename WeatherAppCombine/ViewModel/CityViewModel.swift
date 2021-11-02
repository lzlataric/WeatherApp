//
//  CityViewModel.swift
//  WeatherAppCombine
//
//  Created by Luka Zlatarić on 29.10.2021..
//

import Foundation
import Combine
import SwiftUI

class CityViewModel: ObservableObject{
    @Published var searchedCity = ""
    @Published var fetchedCities: CityModel? = nil
    
    var cancellable: AnyCancellable? = nil
    
    init() {
        cancellable = $searchedCity
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: {str in
                if str == ""{
                    self.fetchedCities = nil
                }else{
                    self.retrieveCityData()
                }
            })
    }
    
    func retrieveCityData() {
        
        guard let url = URL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/cities?namePrefix=\(searchedCity)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("wft-geo-db.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        request.setValue("d168834076msh5a5fe7044469925p1e2023jsne5d59e8c5391", forHTTPHeaderField: "X-RapidAPI-Key")
        
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
                let cities = try JSONDecoder().decode(CityModel.self, from: ApiData)
                DispatchQueue.main.async {
                        self.fetchedCities = cities
                }
            }catch{
                print(error)
            }
        }.resume()
    }
}
