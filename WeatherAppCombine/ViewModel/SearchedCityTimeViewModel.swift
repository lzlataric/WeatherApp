//
//  SearchedCityTimeViewModel.swift
//  WeatherAppCombine
//
//  Created by Luka Zlatarić on 28.10.2021..
//

import Foundation
import Combine

class SearchedCityTimeViewModel: ObservableObject{
    
    
    //@Published var searchedTime: String = ""
    @Published var time: String = ""
    @Published var seconds: Int = 0
    @Published var latitude: Double = 0
    @Published var longitude: Double = 0
    
    var cancellable: AnyCancellable? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    let timeDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.timeStyle = .medium
        return df
    }()
    
    init(){}
    
    
    func test(lat: Double, long: Double){
        self.latitude = lat
        self.longitude = long
                cancellable = $latitude
                    .removeDuplicates()
                    .debounce(for: 1, scheduler: RunLoop.main)
                    .sink(receiveValue: {str in
                        if str != 0{
                            self.getTime(longitude: self.longitude, latitude: self.latitude)
                        }
                    })
    }
    
    private func getTime(longitude: Double, latitude: Double){
        guard let url = URL(string:"https://www.timeapi.io/api/Time/current/coordinate?latitude=\(latitude)&longitude=\(longitude)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
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
                let gottenTime = try JSONDecoder().decode(TimeModel.self, from: ApiData)
                DispatchQueue.main.async {
                    self.time = gottenTime.time
                }
            }catch{
                print(error)
            }
        }.resume()
        
        
    }
}
