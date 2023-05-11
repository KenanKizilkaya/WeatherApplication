import android.content.Context
import android.os.Build
import android.util.Log
import androidx.lifecycle.MutableLiveData
import com.android.volley.Request
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import com.google.gson.Gson
import kth.kenanmark.weatherapp.model.Parameter
import kth.kenanmark.weatherapp.model.Weather
import kth.kenanmark.weatherapp.model.WeatherResponse

class WeatherVM(private val context: Context) {
    private var weatherData = MutableLiveData<Weather>()

    fun fetchWeather(long: String, lat: String) {
        resetWeather()
        val queue = Volley.newRequestQueue(context)
        val url = "https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/lon/$long/lat/$lat/data.json"

        val request = JsonObjectRequest(
            Request.Method.GET, url, null,
            { response ->
                val weatherResponse = Gson().fromJson(response.toString(), WeatherResponse::class.java)
                val weather = mapToWeather(weatherResponse)
                weatherData.value = weather
                weather.lat = lat.toFloat()
                weather.long = long.toFloat()


            },
            { error ->
                Log.e("WeatherVM", "Error fetching weather data", error)
            }
        )
        queue.add(request)
    }

    private fun mapToWeather(response: WeatherResponse): Weather {
        val temperatures = mutableListOf<Parameter>()
        val tccs = mutableListOf<Parameter>()
        val validTimes = mutableListOf<String>()

        for (timeSeriesInfo in response.timeSeries) {
            validTimes.add(timeSeriesInfo.validTime)

            for (parameter in timeSeriesInfo.parameters) {
                when (parameter.name) {
                    "t" -> temperatures.addAll(parameter.values.map { Parameter("t", listOf(it)) })
                    "tcc_mean" -> tccs.addAll(parameter.values.map { Parameter("tcc_mean", listOf(it)) })
                }
            }
        }
        return Weather(
            temperatures = temperatures,
            tccs = tccs,
            validTimes = validTimes,
            approvedTime = response.approvedTime
        )
    }

    fun getWeatherData(): MutableLiveData<Weather> {
        return weatherData
    }

    private fun resetWeather() {
        weatherData.value = null
    }
}
