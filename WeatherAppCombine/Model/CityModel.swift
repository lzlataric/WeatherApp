//
//  CityModel.swift
//  WeatherAppCombine
//
//  Created by Luka Zlatarić on 29.10.2021..
//

import Foundation

struct CityModel: Codable, Identifiable{
    let id = UUID()
    let data: [Data]
}

struct Data: Codable, Identifiable, Hashable{
    let id: Int
    let name: String
    let country: String
    let latitude: Double
    let longitude: Double
}
