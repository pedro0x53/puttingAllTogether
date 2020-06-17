//
//  weatherAPI.swift
//  testAPI
//
//  Created by Pedro Henrique Costa on 03/06/20.
//  Copyright © 2020 Pedro Henrique Costa. All rights reserved.
//

import Foundation
import CoreLocation

public class WeatherAPI {
    var userWeather = WeatherData()
    
    var locationCoordinates = (latitude : 0.0, longitude : 0.0)
    let APIKey = "9402f537f757e5a96e51fef8c3c29882"
    var weatherURLString = ""
   
    //MARK: - Update User Location
    
    func setLocation(latitude lat : Double, longitude lon : Double) {
        locationCoordinates.latitude = lat
        locationCoordinates.longitude = lon
    }
    
    //MARK: - OpenWeatherMap API Request
    
    private func createURLString() {
        weatherURLString = "https://api.openweathermap.org/data/2.5/weather?lat=\(locationCoordinates.latitude)&lon=\(locationCoordinates.longitude)&appid=\(APIKey)"
    }
    
    func weatherRequestInfo() {
        createURLString()
        
        let url = URL(string: weatherURLString)!
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("Client error!")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error!")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.userWeather = try decoder.decode(WeatherData.self, from: data!)
                semaphore.signal()
            } catch {
                print(error)
            }
        }
        
        task.resume()
        
        semaphore.wait()
    }
    
    //MARK: - Print for Tests
    
    func printAllInfo() {
        print("""
        Place: \(getPlace())
        Weather: \(getWeather())
        Temperature: \(getCelsiusTemperature()) Celsius
        Wind Speed: \(getWindSpeed()) m/s
        Clouds: \(getCloudiness())%
        Visibility: \(getVisibility()) meters
        """)
    }
    
    //MARK: - Game Requests
    
    func getPlace() -> String {
        if let placeName = userWeather.name {
            return placeName
        } else {
            fatalError("No place information in memory!")
        }
    }
    
    func getWeather() -> String {
        if let weatherId = userWeather.weather?[0].id {
            switch weatherId {
                case 200...232:
                    return "Thunderstorm"
                case 300...321:
                    return "Drizzle"
                case 500...531:
                    return "Rain"
                case 600...622:
                    return "Snow"
                case 800:
                    return "Clear"
                case 801...804:
                    return "Clouds"
                default:
                    return "Clear"
            }
        } else {
            fatalError("No weather information in memory!")
        }
    }
    
    //Visibilidade em metros
    func getVisibility() -> Int {
        if let visibility = userWeather.visibility {
            return visibility
        } else {
            fatalError("No visibility information in memory!")
        }
    }
    
    //Velocidade do vento em metros por segundo
    func getWindSpeed() -> Float {
        if let wind = userWeather.wind?["speed"] {
            return wind
        } else {
            fatalError("No wind information in memory!")
        }
    }
    
    //Nuvens em percentual do céu coberto
    func getCloudiness() -> Float {
        if let clouds = userWeather.clouds?["all"] {
            return clouds
        } else {
            fatalError("No cloud information in memory!")
        }
    }
    
    func getCelsiusTemperature() -> Float {
        if let kelvinTemp = userWeather.main?["temp"] {
            let celsiusTemp = kelvinTemp - 273.15
            return celsiusTemp
        } else {
            fatalError("No cloud information in memory!")
        }
    }
    
    func getFahrenheitTemperature() -> Float {
        if let kelvinTemp = userWeather.main?["temp"] {
            let fahrenheitTemp = -459.67 + (9*kelvinTemp)/5
            return fahrenheitTemp
        } else {
            fatalError("No temperature information in memory!")
        }
        
        
    }
    
}
