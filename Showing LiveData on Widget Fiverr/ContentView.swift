

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
            Text(viewModel.timezone)
                .font(.system(size: 32))
            Text(viewModel.temp)
                .font(.system(size: 44))
            Text(viewModel.title)
                .font(.system(size: 24))
            Text(viewModel.descriptionText)
                .font(.system(size: 24))


                NavigationLink(destination: CustomizingView()){
                        Text("Change Widget Design")
                            .bold()
                            .font(.system(size: 16))
                            .foregroundColor(.red)
                            .background(Color.blue)
                        
                        Spacer()
                    
                }.padding()
                
            }

            .navigationTitle("Weather New York")
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


