


import Foundation
import UIKit
import SwiftUI

//Hier legen wir die Daten ab


struct WeatherModel: Codable {
    let timezone: String
    let current: CurrentWeather
}

struct CurrentWeather: Codable {
    let temp: Float
    let weather: [WeatherInfo]
}

struct WeatherInfo: Codable {
    let main: String
    let description: String
}

//By jaykishan

struct savedWeatherData : Codable { //Local sava data structure
    
    let title: String
    let descriptionText: String
    let temp: String
    let timezone: String
    let tempFont : CGFloat
    let tempDetailFont : CGFloat
}
