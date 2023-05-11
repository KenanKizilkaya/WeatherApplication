import TokamakDOM
import Foundation

@main
struct TokamakApp: App {
    @StateObject private var theViewModel = WeatherVM()

    var body: some Scene {
        WindowGroup("Tokamak App") {
            ContentView()
            .environmentObject(theViewModel)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var theViewModel : WeatherVM
    @State var lat = ""
    @State var long = ""
   
    var body: some View {
        VStack{
            Text("Weather App").font(.title)

            HStack{
                Text("Lat:")
                TextField("Lat", text: $lat)
                Text("Long:")
                TextField("Long", text: $long)
                Button("Search") {
                    Task {  
                        await self.theViewModel.getWeather(latValue: Float(lat) ?? 0.0, longValue:Float(long) ?? 0.0)
                    }
                }
            }

            Text("Approved Time: \(theViewModel.model.weather.approvedTime)").onAppear(perform:theViewModel.getStoredWeather)
            Text("Latitude:\(theViewModel.model.weather.lat) and Longitude:\(theViewModel.model.weather.long)")

            List{
                ForEach(0 ..< (theViewModel.model.weather.validTimes.count), id:\.self) { i in
                  HStack {
                    Image("\(Int(theViewModel.model.weather.tccs[i].values[0])).png")      
                    Text(theViewModel.model.weather.validTimes[i]).padding(.trailing, 8)
                    Text(theViewModel.model.weather.temperatures[i].values[0].description + "°C")
                    }
                }
            }
        }
    }
}
