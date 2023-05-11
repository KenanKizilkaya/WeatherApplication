import SwiftUI

@main
struct WeatherApp_iOSApp: App {
    @StateObject private var theViewModel = WeatherVM()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(theViewModel)
        }
    }
}
