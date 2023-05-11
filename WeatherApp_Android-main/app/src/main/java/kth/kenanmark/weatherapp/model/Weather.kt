package kth.kenanmark.weatherapp.model

data class Weather(
    var temperatures: List<Parameter> = listOf<Parameter>(),
    var tccs: List<Parameter> = listOf<Parameter>(),
    var validTimes: List<String> = listOf<String>(),
    var approvedTime: String = "",
    var lat: Float = 0.0f,
    var long: Float = 0.0f)


data class WeatherResponse(
    var approvedTime: String,
    var timeSeries: List<TimeSeriesInfo>
)

data class TimeSeriesInfo(
    var validTime: String,
    var parameters: List<Parameter>
)

data class Parameter(
    var name: String,
    var values: List<Float>
)