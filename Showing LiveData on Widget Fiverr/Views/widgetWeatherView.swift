//
//  widgetWeatherView.swift
//  Showing LiveData on Widget Fiverr
//
//  Created by Jaykishan Moradiya on 13/07/21.
//

import SwiftUI

struct widgetWeatherView: View { //Widegts Weather View how it looks like
    
    let weatherSavedData : savedWeatherData //Always update data from local save
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("tempTextColor",store:UserDefaults(suiteName: "group.G-W.de.Showing-LiveData-on-Widget-Fiverr.jeky")) var storedColor1: Color = .black
    @AppStorage("tempDetailTextColor",store:UserDefaults(suiteName: "group.G-W.de.Showing-LiveData-on-Widget-Fiverr.jeky")) var storedColor2: Color = .black
    
    var body: some View {
        
        VStack{
            Group {
                Text(weatherSavedData.timezone)
                    .font(.system(size: 13))
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                Text(weatherSavedData.temp)
                    .font(.system(size: weatherSavedData.tempFont))
                    .foregroundColor(storedColor1)
                Text(weatherSavedData.title)
                    .font(.system(size: 13))
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                Text(weatherSavedData.descriptionText)
                    .font(.system(size: weatherSavedData.tempDetailFont))
                    .foregroundColor(storedColor2)
            }
        }
        
    }
}

/*struct widgetWeatherView_Previews: PreviewProvider { //Provide Preview
    static var previews: some View {
        let savedWeatherData  = savedWeatherData(title: "Surat",
                                                 descriptionText: "Cool",
                                                 temp: "28.5",
                                                 timezone: "IST",
                                                 tempFont: 24,
                                                 tempColor: "ff0000")
        widgetWeatherView(weatherSavedData: savedWeatherData)
    }
}*/
