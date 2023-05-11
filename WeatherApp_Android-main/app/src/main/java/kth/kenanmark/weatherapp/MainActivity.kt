package kth.kenanmark.weatherapp

import WeatherVM
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.annotation.RequiresApi
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.Button
import androidx.compose.material.Divider
import androidx.compose.material.Text
import androidx.compose.material.TextField
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color.Companion.Black
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight.Companion.Black
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import kth.kenanmark.weatherapp.model.Weather
import java.time.LocalTime


class MainActivity : ComponentActivity() {
    private val weatherVM = WeatherVM(this)

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            WeatherScreen(weatherVM = weatherVM)
        }
    }
}



@RequiresApi(Build.VERSION_CODES.O)
@Composable
fun WeatherScreen(weatherVM: WeatherVM) {
    var weather by remember { mutableStateOf<Weather?>(null) }
    var lat by remember { mutableStateOf("") }
    var lon by remember { mutableStateOf("") }

    val weatherData = weatherVM.getWeatherData()

        // Store the weather data in a local state variable
    weather = weatherData.value

        // Display the weather data in a UI layout
    Column(modifier = Modifier.padding(top = 20.dp)) {
        val sizeOfValidTimes = weather?.validTimes
        val temperatures = weather?.temperatures
        val tccs = weather?.tccs

        Box(
            Modifier.fillMaxWidth(),
            contentAlignment = Alignment.Center
        ) {
            Text(
                "Approved time: ${weather?.approvedTime?.replace("T", " ")?.replace("Z", " ")}",
                modifier = Modifier.padding(bottom = 50.dp),
                fontSize = 20.sp
            )
            Text("Longitude: ${weather?.long.toString()}" + " Latitude: ${weather?.lat.toString()}",
            fontSize = 15.sp)
        }
        if (sizeOfValidTimes!=null){
                Box(
                    Modifier
                        .fillMaxWidth()
                )
                {
                    LazyColumn(
                        state = rememberLazyListState(),
                        modifier = Modifier
                            .fillMaxSize()
                            .padding(horizontal = 16.dp)
                            .padding(top = 80.dp)
                    ) {
                        items(sizeOfValidTimes.size) { i ->
                            val validTime = sizeOfValidTimes[i].replace("T", " ")?.replace("Z", "")
                            val temperature = temperatures?.get(i)?.values?.joinToString()
                            val tcc = tccs?.get(i)?.values?.joinToString()
                            val imageId : Int

                            val timePart = validTime.substringAfter(" ")
                            val validTimeLocalTime = LocalTime.parse(timePart)
                            val inputTimeMorning = LocalTime.parse("05:00")
                            val inputTimeEvening = LocalTime.parse("18:00")

                            if (validTimeLocalTime > inputTimeMorning && validTimeLocalTime < inputTimeEvening )
                            {
                                imageId = when (tcc) {
                                    "0.0" -> R.drawable.dayimage1
                                    "1.0" -> R.drawable.dayimage2
                                    "2.0" -> R.drawable.dayimage2
                                    "3.0" -> R.drawable.dayimage3
                                    "4.0" -> R.drawable.dayimage4
                                    "5.0" -> R.drawable.dayimage5
                                    "6.0" -> R.drawable.dayimage5
                                    "7.0" -> R.drawable.dayimage6
                                    "8.0" -> R.drawable.dayimage6
                                    else -> R.drawable.default_image
                                }
                            }

                            else{
                                imageId = when (tcc) {
                                    "0.0" -> R.drawable.nightimage1
                                    "1.0" -> R.drawable.nightimage2
                                    "2.0" -> R.drawable.nightimage2
                                    "3.0" -> R.drawable.nightimage3
                                    "4.0" -> R.drawable.nightimage4
                                    "5.0" -> R.drawable.nightimage5
                                    "6.0" -> R.drawable.nightimage5
                                    "7.0" -> R.drawable.nightimage6
                                    "8.0" -> R.drawable.nightimage6
                                    else -> R.drawable.default_image
                                }
                            }
                            Divider(color = androidx.compose.ui.graphics.Color.Black, thickness = 2.dp)

                            Row{
                                Text(text = "\n$validTime\n\n$temperature°C\n",
                                    fontSize = 20.sp
                                    )
                                Image(
                                    painter = painterResource(id = imageId),
                                    contentDescription = null,
                                    modifier = Modifier
                                        .size(100.dp)
                                        .padding(end = 20.dp),
                                    contentScale = ContentScale.Fit
                                )
                            }

                        }
                    }
                }
            }
        }
    Column (
        modifier = Modifier.fillMaxSize().padding(top = 80.dp),
        horizontalAlignment = Alignment.CenterHorizontally,

    ){

        Row(
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Text(text = "Lat:")
            TextField(
                modifier = Modifier.width(100.dp),
                value = lat,
                onValueChange = {newLat -> lat = newLat},
                singleLine = true,
                keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number)
            )
            Spacer(modifier = Modifier.width(16.dp))
            Text(text = "Long:")
            TextField(
                modifier = Modifier.width(100.dp),
                value = lon,
                onValueChange = {newLon -> lon = newLon},
                singleLine = true,
                keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number)
            )
            Button(
                onClick = { weatherVM.fetchWeather(lon, lat)},
                modifier = Modifier.padding(start = 8.dp)
            ) {
                Text("Get Weather")
            }

        }
        
    }
}
