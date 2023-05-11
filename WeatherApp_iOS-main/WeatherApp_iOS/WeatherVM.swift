import SwiftUI

class WeatherVM: ObservableObject{
    @Published private(set) var model = WeatherModel(){
        didSet{
            storeWeather()
        }
    }
    private(set) var reuquest = WeatherRequest()

    
    func storeWeather(){
        if !model.weather.approvedTime.isEmpty{
            do{
                let encoder = JSONEncoder()
                let data = try encoder.encode(model.weather)
                UserDefaults.standard.set(data, forKey: "weatherInfo")
            }catch{
                print("Failed to store")
            }
        }
    }
    
    func getStoredWeather(){
        if let data = UserDefaults.standard.value(forKey:"weatherInfo") as? Data{
            do {
                let decoder = JSONDecoder()
                let weather = try decoder.decode(Weather.self, from: data)
                setWeather(weatherValue: weather)
            } catch {
                print("Failed to load")
            }
            
        }
    }
    
    func getWeather(latValue: Float, longValue: Float){
        reuquest.getWeather(lat: latValue, long: longValue){
            (result) in self.setWeather(weatherValue: result)
        }
    }
    
    func setWeather(weatherValue: Weather) {
        model.setWeather(weatherValue: weatherValue)
    }
}


