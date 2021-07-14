

import SwiftUI
import WidgetKit

class CustomModel: ObservableObject{
    @Published var tempLabelSize: CGFloat = 20
    @Published var DetailLabelSize: CGFloat = 20
}


struct CustomizingView: View {
    @ObservedObject var WeatherDesignModel:CustomModel = CustomModel()
    @State var WeatherDataModel : WeatherViewModel
    
    @AppStorage("tempTextColor",store:UserDefaults(suiteName: "group.G-W.de.Showing-LiveData-on-Widget-Fiverr.jeky")) var storedColor1: Color = .black
    @AppStorage("tempDetailTextColor",store:UserDefaults(suiteName: "group.G-W.de.Showing-LiveData-on-Widget-Fiverr.jeky")) var storedColor2: Color = .black
    
    var body: some View{

        VStack {
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .shadow(color: .secondary, radius: 8, x: 0, y: 0)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .frame(width: 169, height: 169, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                VStack {
                    
                    Text (WeatherDataModel.temp)
                        .foregroundColor(storedColor1)
                        .font(.system(size: WeatherDesignModel.tempLabelSize))
                    
                    Text (WeatherDataModel.descriptionText)
                        .foregroundColor(storedColor2)
                        .font(.system(size: WeatherDesignModel.DetailLabelSize))
                    }
            }
            
            ColorPicker("Temp Font colour", selection: $storedColor1)
                .padding()
            Text("Font size for temperature")
            Slider(value: $WeatherDesignModel.tempLabelSize, in: 0...40)
            
            Divider()
            
            ColorPicker("Temp Detail Font Color", selection: $storedColor2)
                .padding()
            Text(" Font size for temerature detail")
            Slider(value: $WeatherDesignModel.DetailLabelSize, in: 0...40)
            
            Spacer()
        }
        .onDisappear { //On view disappear
            self.savedData()
        }
        .onAppear { //On View Appear
            self.getData()
        }
    }
    
    
    //On disaapper save data locally
    func savedData() {
        let savedWeatherData = savedWeatherData(
            title: WeatherDataModel.title,
            descriptionText: WeatherDataModel.descriptionText,
            temp: WeatherDataModel.temp,
            timezone: WeatherDataModel.timezone,
            tempFont: $WeatherDesignModel.tempLabelSize.wrappedValue,
            tempDetailFont: $WeatherDesignModel.DetailLabelSize.wrappedValue)
        
        guard let data = try? JSONEncoder().encode(savedWeatherData) else { return }
        self.$WeatherDataModel.watherData.wrappedValue = data
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    //On view appear get data locally
    func getData() {
        
        guard let data = try? JSONDecoder().decode(savedWeatherData.self, from: self.$WeatherDataModel.watherData.wrappedValue) else  { return }
        self.$WeatherDesignModel.tempLabelSize.wrappedValue = data.tempFont
        self.$WeatherDesignModel.DetailLabelSize.wrappedValue = data.tempDetailFont
        
    }
}

/*struct CustomizingView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizingView()
    }
}*/
