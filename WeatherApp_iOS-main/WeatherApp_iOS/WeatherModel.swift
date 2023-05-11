import Foundation

struct WeatherModel{
    private(set) var weather = Weather()
    
    mutating func setWeather(weatherValue: Weather){
        weather = weatherValue
        
        weather.approvedTime = weatherValue.approvedTime.replacingOccurrences(of: "T", with: " ").replacingOccurrences(of: "Z", with: " ")
        
        for i in 0...weather.validTimes.count-1{
            weather.validTimes[i] = weather.validTimes[i].replacingOccurrences(of: "T", with: " ").replacingOccurrences(of: "Z", with: " ")
        }
    }    
}
