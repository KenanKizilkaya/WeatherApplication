import Foundation
import JavaScriptKit

struct Weather: Codable{
    var temperatures = [Parameter]()
    var tccs = [Parameter]()
    var validTimes = [String]()
    var approvedTime = ""
    var lat: Float = 0.0
    var long: Float = 0.0
}

struct WeatherResponse: Codable{
    var approvedTime: String
    var timeSeries:[TimeSeriesInfo]
}

struct TimeSeriesInfo: Codable{
    var validTime:String
    var parameters:[Parameter]
}

struct Parameter: Codable{
    var name: String
    var values: [Float]
}

