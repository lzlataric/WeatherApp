//
//  ContentView.swift
//  WeatherAppCombine
//
//  Created by Luka Zlatarić on 28.10.2021..
//

import SwiftUI

struct ContentView: View {
    
    @State var isActive:Bool = false
    @StateObject var cityViewModel = CityViewModel()
    
    var body: some View {
        VStack {
            if self.isActive {
                HomeView()
                    .environmentObject(cityViewModel)
            } else {
                ZStack{
                    Color.blue
                        .ignoresSafeArea()
                    VStack{
                    LottieView(name: "7420-clouds-opening", loopMode: .loop)
                        .frame(width: 650, height: 650)
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isActive = true
                }
            }
            
        }
        
    }
    
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
