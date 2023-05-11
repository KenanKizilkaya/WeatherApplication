import Foundation
import JavaScriptKit

struct WeatherRequest{
    private let jsFetch = JSObject.global.fetch.function!

    func fetch(_ url: String) -> JSPromise {
        JSPromise(jsFetch(url).object!)!
    }

     func getWeather(latValue: Float, longValue: Float) async -> Weather {
        var weather = Weather()
        do {
            let response = try await fetch("https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/lon/\(longValue)/lat/\(latValue)/data.json").value
            let json = try await JSPromise(response.json().object!)!.value
            let parsedResponse = try JSValueDecoder().decode(WeatherResponse.self, from: json)
            for i in 0...parsedResponse.timeSeries.count-1{
                weather.tccs.append(contentsOf: parsedResponse.timeSeries[i].parameters.filter { $0.name == "tcc_mean"})
                weather.temperatures.append(contentsOf: parsedResponse.timeSeries[i].parameters.filter { $0.name == "t"})
                weather.validTimes.append(parsedResponse.timeSeries[i].validTime)
            }
            weather.approvedTime = parsedResponse.approvedTime
            weather.lat = latValue
            weather.long = longValue
        }catch {
            print(error)
        }
        return weather
    }
}
