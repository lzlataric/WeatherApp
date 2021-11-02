//
//  Extensions.swift
//  WeatherAppCombine
//
//  Created by Luka Zlatarić on 02.11.2021..
//

import Foundation
import SwiftUI

extension CityWeatherView{
    
    func getWeatherPicture(weather: String) -> Image{
        switch weather{
        case "Clouds":
            return  Image(systemName: "cloud.fill")
        case "Clear":
            return Image(systemName: "sun.max.fill")
        case "Rain":
            return Image(systemName: "cloud.rain.fill")
        case "Drizzle":
            return Image(systemName: "cloud.drizzle.fill")
        default:
            break
        }
        return Image(systemName: "sun.max.fill")
    }
    
    func KToC(KelvTemp: Double) -> Int{
        let celsiusTemp = KelvTemp-273.15
        return Int(celsiusTemp)
    }
}

extension SevenDayView{
    func getWeatherPicture(weather: String) -> Image{
        switch weather{
        case "Clouds":
            return  Image(systemName: "cloud.fill")
        case "Clear":
            return Image(systemName: "sun.max.fill")
        case "Rain":
            return Image(systemName: "cloud.rain.fill")
        case "Drizzle":
            return Image(systemName: "cloud.drizzle.fill")
        default:
            break
        }
        return Image(systemName: "sun.max.fill")
    }
    
    func KToC(KelvTemp: Double) -> Int{
        let celsiusTemp = KelvTemp-273.15
        return Int(celsiusTemp)
    }
    
    func getDayOfWeek(date: Int) -> String{
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let f = DateFormatter()
        let day = f.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
        return day.prefix(3).uppercased()
    }
}
