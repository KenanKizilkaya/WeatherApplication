import TokamakShim
import Foundation
import JavaScriptKit


class WeatherVM: ObservableObject{
    @Published private(set) var model = WeatherModel(){
        didSet{
            storeWeather()
        }
    }
    private(set) var reuquest = WeatherRequest()    
    let localStorage = JSObject.global.localStorage.object!

    func getWeather(latValue: Float, longValue: Float) async{
        print(latValue)
        print(longValue)
        
        self.setWeather(weatherValue: await reuquest.getWeather(latValue:latValue, longValue:longValue)) 

    }

    func setWeather(weatherValue: Weather) {
        model.setWeather(weatherValue: weatherValue)
    }

    func storeWeather(){
        let encoder = JSONEncoder()

        guard let jsonData = try? encoder.encode(model.weather) else {
            fatalError("Failed to encode Weather to JSON")
        }
        let jsonString = String(data: jsonData, encoding: .utf8)!
        localStorage.setItem!("weather", jsonString)
    }

    func getStoredWeather(){
        guard let jsonString = localStorage.getItem?("weather").string else {
            print("No weather data found in local storage")
            return
        }
        let jsonData = jsonString.data(using: .utf8)!

        let decoder = JSONDecoder()
        do {
            let weather = try decoder.decode(Weather.self, from: jsonData)
                setWeather(weatherValue: weather)

        } catch {
                print("Error decoding Weather:", error.localizedDescription)
        }
    }

}
