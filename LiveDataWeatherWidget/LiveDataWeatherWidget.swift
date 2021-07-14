//
//  LiveDataWeatherWidget.swift
//  LiveDataWeatherWidget
//
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    
    //Get Local data and using App Groups with same identifire
    @AppStorage("widegetWeather",store:UserDefaults(suiteName: "group.G-W.de.Showing-LiveData-on-Widget-Fiverr.jeky"))
    var watherData : Data = Data()
    
    public typealias Entry = weatherEntry //EntrType
    
    //Required for first view
    func placeholder(in context: Context) -> weatherEntry {
        let savedWeatherData  = savedWeatherData(title: "Surat",
                                                 descriptionText: "Cool",
                                                 temp: "28.5",
                                                 timezone: "IST",
                                                 tempFont: 24,
                                                 tempDetailFont: 24)
        return weatherEntry(weatherData: savedWeatherData)
    }
    
    //Get sanpshot of widget with entry point
    func getSnapshot(in context: Context, completion: @escaping (weatherEntry) -> Void) {
        guard let data = try? JSONDecoder().decode(savedWeatherData.self, from: watherData) else { return }
        let entry = weatherEntry(weatherData: data)
        completion(entry)
    }
    
    //call at specific interval minimum 15 minutes depends on phone memory and bettry health
    func getTimeline(in context: Context, completion: @escaping (Timeline<weatherEntry>) -> Void) {
        guard let data = try? JSONDecoder().decode(savedWeatherData.self, from: watherData) else { return }
        
        let date = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 10, to: date)
        
        WeatherViewModel().fetchWeather { done in
            if done {
                
                let entry = weatherEntry(weatherData: data)
                
                let timeLine = Timeline(entries: [entry], policy: .after(refreshDate!))
                completion(timeLine)
            }
        }
    }
    
}

//Create weather entry structure
struct weatherEntry: TimelineEntry {
    let date = Date()
    let weatherData: savedWeatherData
}

//Only for Preview
struct providerPreview : View {
    var body: some View {
        let savedWeatherData  = savedWeatherData(title: "Surat",
                                                 descriptionText: "Cool",
                                                 temp: "28.5",
                                                 timezone: "IST",
                                                 tempFont: 15,
                                                 tempDetailFont: 24)
        widgetWeatherView(weatherSavedData: savedWeatherData)
    }
}

//Biniding Entry with WidgetView
struct LiveDataWeatherWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        widgetWeatherView(weatherSavedData: entry.weatherData)
    }
}

//Call first while updating weather
//setup of widget with class name
@main
struct LiveDataWeatherWidget: Widget {
    let kind: String = "LiveDataWeatherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: Provider())
        { entry in
            LiveDataWeatherWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Weather Widget")
        .supportedFamilies([.systemSmall,.systemLarge,.systemMedium])
    }
}

//Preview Provider
struct EmojiRangerWidget_Previews: PreviewProvider {
    static var previews: some View {
        providerPreview()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
