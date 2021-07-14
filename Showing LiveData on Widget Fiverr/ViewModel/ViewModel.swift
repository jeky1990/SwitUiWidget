


import Foundation
import UIKit
import SwiftUI
//import WidgetKit
//Hier werden die Daten "vearbeitet" für den View


class WeatherViewModel: ObservableObject {
    @Published var title: String = "-"
    @Published var descriptionText: String = "-"
    @Published var temp: String = "-"
    @Published var timezone: String = "-"
    
    //Store and get data from local save
    @AppStorage("widegetWeather",store:UserDefaults(suiteName: "group.G-W.de.Showing-LiveData-on-Widget-Fiverr.jeky"))
    var watherData : Data = Data()
    
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
    
    var tempFontSize : CGFloat = 24
    var tempDetailFontSize : CGFloat = 24
    
    
init() {
    fetchWeather { done in // Change to Completion method for update UI at every 10 Minutes
        //
    }
}
    
func fetchWeather(completion:@escaping (_ done:Bool) ->()) {
    
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
                
                self.getData() //Last save data get if availabel
                
                self.title = model.current.weather.first?.main ?? "No title"
                self.descriptionText = model.current.weather.first?.description ?? "No description"
                self.temp = "\(model.current.temp)"
                self.timezone = model.timezone
                
                //Save data locally
                let localSave = savedWeatherData(
                    title: self.title,
                    descriptionText: self.descriptionText,
                    temp: self.temp,
                    timezone: self.timezone,
                    tempFont: self.tempFontSize,
                    tempDetailFont : self.tempDetailFontSize)
                guard let data = try? JSONEncoder().encode(localSave) else { return }
                self.watherData = data
                completion(true)
            }
        }
        catch{
            completion(false)
            print("failed, something went wrong")
        }
        
    }
    task.resume()
    
    //    WidgetCenter.shared.reloadAllTimelines()
}
    
        //Get all local data
    func getData() {
        @AppStorage("widegetWeather",store:UserDefaults(suiteName: "group.G-W.de.Showing-LiveData-on-Widget-Fiverr.jeky"))
        var watherData : Data = Data()
        
        guard let data = try? JSONDecoder().decode(savedWeatherData.self, from: watherData) else  { return }
        self.tempFontSize = data.tempFont
        self.tempDetailFontSize = data.tempDetailFont
    }

    
}



