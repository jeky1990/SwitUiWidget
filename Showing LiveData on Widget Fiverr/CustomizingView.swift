

import SwiftUI

class CustomModel: ObservableObject{
    @Published var colorTempLabel: Color = .red
    @Published var tempLabelSize: CGFloat = 20
}


struct CustomizingView: View {
    @ObservedObject var WeatherDesignModel:CustomModel = CustomModel()
    @StateObject var WeatherDataModel = WeatherViewModel()
    
    var body: some View{

        VStack {
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .shadow(color: .secondary, radius: 8, x: 0, y: 0)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .frame(width: 169, height: 169, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
                Text (WeatherDataModel.temp)
                    .frame(width: 169, height: 169, alignment: .center)
                    .foregroundColor(WeatherDesignModel.colorTempLabel)
                    .font(.system(size: WeatherDesignModel.tempLabelSize))

            }
            ColorPicker("Fontcolour", selection: $WeatherDesignModel.colorTempLabel)
                .padding()
            Text("size")
            Slider(value: $WeatherDesignModel.tempLabelSize, in: 0...40)
   
        }
    }
}

struct CustomizingView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizingView()
    }
}
