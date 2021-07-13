


import Foundation
import UIKit
//import WidgetKit
//Hier werden die Daten "vearbeitet" für den View

class WeatherViewModel: ObservableObject {
@Published var title: String = "-"
@Published var descriptionText: String = "-"
@Published var temp: String = "-"
@Published var timezone: String = "-"

//    var TEXTANPASSUNG: String {
//        if temp == "15.9"{
//            return "Genau 15,9"
//        }else{
//            return "Keine 15,9"
//        }
        
//    }


private let myApiKey = "6d495bd2cec1a372bde2afb7028f1fee"
//Breitengrad = lat
private let breitengradNewYork = "40.6943"
    
//Längengrad = lon
private let längengradNewYork = "-73.9249"
    
init() {
    fetchWeather()
}

func fetchWeather() {
    
    //Beispiel URL-Gesamt
    //https://api.openweathermap.org/data/2.5/onecall?lat=52.2056952&lon=7.1876491&exclude=hourly,daily,minutely&appid=a37d710d29613aeab9bb73f931b51fae
    
    guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(breitengradNewYork)&lon=\(längengradNewYork)&units=metric&exclude=hourly,daily,minutely&appid=\(myApiKey)")
    else {
        return
    }
    let task = URLSession.shared.dataTask(with: url){ data, _, error in
        guard let data = data, error == nil else {
            return
        }
        
//        Hier werden die Daten konvertiert 
        do {
            let model = try JSONDecoder().decode(WeatherModel.self, from: data)
            
            DispatchQueue.main.async {
                self.title = model.current.weather.first?.main ?? "No title"
                self.descriptionText = model.current.weather.first?.description ?? "No description"
                self.temp = "\(model.current.temp)"
                self.timezone = model.timezone
            }
        }
        catch{
            print("failed, something went wrong")
        }
        
    }
    task.resume()
    
//    WidgetCenter.shared.reloadAllTimelines()
}

}



