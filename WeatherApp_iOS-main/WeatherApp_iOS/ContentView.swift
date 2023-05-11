import SwiftUI

struct ContentView: View {
    @EnvironmentObject var theViewModel : WeatherVM
    @State var lat = ""
    @State var long = ""
    
    var body: some View {
        VStack {
            Text("Weather App").font(.title)

            Text("Approved Time: \(theViewModel.model.weather.approvedTime)").onAppear(perform:theViewModel.getStoredWeather)
            Text("Latitude:\(theViewModel.model.weather.lat) and Longitude:\(theViewModel.model.weather.long)")

            List{
                ForEach(0 ..< (theViewModel.model.weather.validTimes.count), id:\.self) { i in
                    HStack {
                        Image("\(Int(theViewModel.model.weather.tccs[i].values[0]))")
                        Text(theViewModel.model.weather.validTimes[i]).padding(.trailing, 8)
                        Text(theViewModel.model.weather.temperatures[i].values[0].description + "°C")
                    }
                }
            }
            
            HStack{
                Text("Lat:")
                TextField("Lat", text: $lat)
                    .keyboardType(.decimalPad)
                Text("Long:")
                TextField("Long", text: $long)
                    .keyboardType(.decimalPad)
                Button("Search") {
                        theViewModel.getWeather(latValue: Float(lat) ?? 0.0, longValue: Float(long) ?? 0.0)
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(WeatherVM())

    }
}
