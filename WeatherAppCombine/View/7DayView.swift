//
//  7DayView.swift
//  WeatherAppCombine
//
//  Created by Luka Zlatarić on 02.11.2021..
//

import SwiftUI

struct SevenDayView: View {
    let days:[Daily]

    var body: some View {
        
        if days.isEmpty{
            Text("No results")
        }else{
            Divider()
                .frame(height: 1)
                .background(Color.white)
            let withoutToday = days.dropFirst()
            ForEach(withoutToday){ day in
                HStack(spacing: 5){
                    
                    Text(getDayOfWeek(date: day.dt))
                        .frame(width: 50, height: 30, alignment: .center)
                    
                    HStack{
                        if day.weather[0].main == "Clear"{
                            getWeatherPicture(weather: day.weather[0].main)
                                .foregroundColor(.yellow)
                                .frame(width: 50, height: 30, alignment: .center)
                        }else{
                            getWeatherPicture(weather: day.weather[0].main)
                                .frame(width: 50, height: 30, alignment: .center)
                        }
                    }
                    HStack{
                        Image(systemName: "humidity.fill")
                        Text(String(day.humidity)+"%")
                    }
                    .frame(width: 80, height: 30, alignment: .leading)
                    
                    HStack{
                        Image(systemName: "wind")
                        Text(String(day.wind_speed)+"m/s")
                    }
                    .frame(width: 100, height: 30, alignment: .leading)
                    
                    HStack(){
                        Text(String(KToC(KelvTemp:day.temp.max))+"°")
                            .font(.system(size: 20.0, weight: .bold))
                            .frame(width: 50, height: 30, alignment: .center)
                    }
                    .frame(width: 40, height: 30, alignment: .trailing)
                    
                    HStack(){
                        Text(String(KToC(KelvTemp:day.temp.min))+"°")
                            .font(.system(size: 20.0))
                            .frame(width: 50, height: 30, alignment: .center)
                    }
                    .frame(width: 40, height: 30, alignment: .trailing)
                }
                .foregroundColor(.white)
                Divider()
                    .frame(height: 1)
                    .background(Color.white)
            }
        }
    }
}

//struct _DayView_Previews: PreviewProvider {
//    static var previews: some View {
//        SevenDayView()
//    }
//}
