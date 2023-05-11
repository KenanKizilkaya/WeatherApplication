# Weather Application for iOS, Android and browser

An application is written in Swift that runs on iOS, Android, and in the browser. The code is initially written in Swift for iOS and reused in Android and browsers to minimize the amount of code written. 

## iOS
A weather application has been developed using Swift and SwiftUI to display the weather forecast for the upcoming 10 days. The application makes network calls to the SMHI API to fetch the weather data. The logic code, written in Swift, handles the processing and manipulation of the data. The User Interface (UI) of the application is built using SwiftUI, providing an intuitive and visually appealing user experience. The project has been thoroughly tested using the simulator within the Xcode environment to ensure efficient performance and a seamless user experience.

<img width="200" alt="Skärmavbild 2023-05-09 kl  10 46 32" src="https://github.com/KenanKizilkaya/WeatherApplication/assets/81639299/f3557333-a77b-42e9-a5dc-c0c47e8b9aac">

## Android
By utilizing the SwiftKotlin conversion tool, developers can leverage the similarities between Swift and Kotlin, which allows for the conversion of Swift code into Kotlin code. This process saves significant time and effort by eliminating the need to manually rewrite the code. However, it's important to note that while the conversion tool can handle many similarities between the languages, sometimes certain adjustments may be required to ensure the converted code functions correctly in Kotlin.

Although Swift and Kotlin share similarities and can be converted using tools like SwiftKotlin, it's important to note that the user interface frameworks for the two platforms differ. Swift utilizes SwiftUI, while Android employs Jetpack Compose. These frameworks have distinct libraries and approaches for building user interfaces. Despite their differences, there are still similarities between them, such as declarative UI patterns and component-based architectures. Developers familiar with SwiftUI can leverage their understanding of these concepts when transitioning to Jetpack Compose, albeit with some adjustments due to platform-specific variations.

<img width="250" alt="Skärmavbild 2023-05-09 kl  10 47 09" 
 src = "https://github.com/KenanKizilkaya/WeatherApplication/assets/81639299/9c7b596e-8525-4794-b503-592ff929628d">

## Browser
The Swift code has been repurposed for browser-based applications by utilizing the Tokamak and JavaScriptKit frameworks, which leverage WebAssembly. The Tokamak framework allows developers to utilize Swift in web browsers by compiling the code to WebAssembly. Additionally, JavaScriptKit has been employed to enable platform-specific functionalities, like local storage, within the browser environment. This approach enables developers to leverage their existing Swift codebase and utilize it in web applications, providing a seamless cross-platform experience.

<img width="600" alt="Skärmavbild 2023-05-09 kl  10 47 07" src="https://github.com/KenanKizilkaya/WeatherApplication/assets/81639299/f7427fdb-5040-49cb-bafd-c5af7f1828e6">
