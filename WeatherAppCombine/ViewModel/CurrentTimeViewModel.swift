//
//  CurrentTimeViewModel.swift
//  WeatherAppCombine
//
//  Created by Luka Zlatarić on 28.10.2021..
//

import Foundation
import Combine

class CurrentTimeViewModel: ObservableObject{
    
    @Published var currentTime: String = ""
    @Published var time: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    let timeDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.timeStyle = .medium
        return df
    }()
    
    
    init(){
        exactTime()
        currentTimePublisher()
    }
    
    private func exactTime(){
        let date = Date()
        self.time = self.timeDateFormatter.string(from: date)
        print(self.time)
    }
    
    private func currentTimePublisher(){
        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .receive(on: RunLoop.main)
            .sink{ value in
                self.currentTime = self.timeDateFormatter.string(from: value)
            }
            .store(in: &cancellables)
    }
    
 
}
