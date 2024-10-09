//
//  WeatherViewModel.swift
//  NewWeather
//
//  Created by Sergei Biryukov on 09.10.2024.
//

import Foundation
import SwiftData

struct WeatherResponse: Codable {
    let current_weather: CurrentWeather
    
    struct CurrentWeather: Codable {
        let temperature: Double
    }
}

@Observable
class WeatherViewModel {
    var temperature: Int = 0
    
    func fetchData() async {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=53&longitude=35&current_weather=true"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data) {
                self.temperature = Int(weatherResponse.current_weather.temperature)
            }
        } catch {
            print("Failed to decode JSON")
        }
    }
}
