import Foundation

struct WeatherRequest{
    
    func getWeather(lat:Float, long:Float, completion: @escaping (Weather) -> ()){
        
        var weather = Weather()

        guard let requestUrl = URL(string: "https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/lon/\(long)/lat/\(lat)/data.json") else {return}
        URLSession.shared.dataTask(with: requestUrl) { data, _, _ in
            if let data = data{
                if let response = try? JSONDecoder().decode(WeatherResponse.self, from: data) {
                    for i in 0...response.timeSeries.count-1{
                        weather.tccs.append(contentsOf: response.timeSeries[i].parameters.filter { $0.name == "tcc_mean"})
                        weather.temperatures.append(contentsOf: response.timeSeries[i].parameters.filter { $0.name == "t"})
                        weather.validTimes.append(response.timeSeries[i].validTime)
                    }
                    weather.approvedTime = response.approvedTime
                    weather.lat = lat
                    weather.long = long
                    DispatchQueue.main.async {
                        completion(weather)
                    }
                }
            }

        }.resume()
    }
}
