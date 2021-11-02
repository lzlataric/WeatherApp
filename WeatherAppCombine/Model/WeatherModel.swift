//
//  WeatherModel.swift
//  WeatherAppCombine
//
//  Created by Luka Zlatarić on 28.10.2021..
//

import Foundation
import SwiftUI

struct WeatherModel: Codable{
    let timezone: String
    let current: Current
    let daily: [Daily]
}

struct Current: Codable{
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let wind_speed: Double
    let weather: [Weather]
    let dt: Int
}

struct Weather: Codable {
    let main: String
    let description: String
}

struct Daily: Codable, Identifiable{
    let id = UUID()
    let temp: Temp
    let pressure: Int
    let humidity: Int
    let wind_speed: Double
    let weather: [Weather]
    let dt: Int
}

struct Temp: Codable{
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

