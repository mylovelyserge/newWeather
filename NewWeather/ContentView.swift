//
//  ContentView.swift
//  NewWeather
//
//  Created by Sergei Biryukov on 09.10.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = WeatherViewModel()
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                TitleView(temp: viewModel.temperature)
                ExtractedView(temp: viewModel.temperature)
            }
            .task {
                await viewModel.fetchData()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct TitleView: View {
    let temp: Int

    var iconName: String {
        if temp > 10 {
            return "sun.max.fill"
        } else {
            return "cloud.fill"
        }
    }
    
    var iconColor: Color {
        if iconName == "sun.max.fill" {
            return Color.yellow
        } else {
            return Color.gray
        }
    }
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .foregroundStyle(iconColor)
                .font(.title)
                .padding()
            Text("Temperature")
                .foregroundStyle(.white)
                .font(.largeTitle)
        }
    }
}

struct ExtractedView: View {
    let temp: Int
    var body: some View {
        Text("\(temp) °C")
            .fontWeight(.bold)
            .padding()
            .font(.title)
            .foregroundColor(.white)
    }
}
