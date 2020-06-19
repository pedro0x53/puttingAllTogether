//
//  weatherInfo.swift
//  testAPI
//
//  Created by Pedro Henrique Costa on 02/06/20.
//  Copyright © 2020 Pedro Henrique Costa. All rights reserved.
//

import Foundation

enum WeatherDataError : Error {
    case nilPlace
    case nilWeather
    case nilTemperature
    case nilWind
    case nilCloudiness
    case nilVisibility
}

struct subWeather : Codable {
    var id : Int
    var main : String
    var description : String
}

class WeatherData : Codable {
    static var shared = WeatherData()
    var temperatureFormat = "Celsius"
    
    var weather : Array<subWeather>?
    var main : Dictionary<String, Float>?
    var visibility : Int?
    var wind : Dictionary<String, Float>?
    var clouds : Dictionary<String, Float>?
    var name : String?
    
    private init() {}
    
//    func printTest() {
//        print("""
//        Place: \(getPlace())
//        Weather: \(getWeather())
//        Temperature: \(getTemperature()) Celsius
//        Wind Speed: \(getWindSpeed()) m/s
//        Cloudiness: \(getCloudiness()) percent coverage
//    """)
//    }
    
    func setDefaultData() {
        weather = [
            subWeather(id: 500, main: "Rain", description: "light rain")
        ]
        main = [
            "temp": 303.25,
            "feels_like": 301.3,
            "temp_min": 280.15,
            "temp_max": 304.15,
            "pressure": 1014,
            "humidity": 58
        ]
        visibility = 10000
        wind = [
            "speed": 3.0,
            "deg": 90
        ]
        clouds = [
            "all": 25
        ]
        name = "Lugar Nenhum"
    }
    
    func resetData() {
        weather = nil
        main = nil
        visibility = nil
        wind = nil
        clouds = nil
        name = nil
    }
    
    func getPlace() throws -> String {
        if let placeName = name {
            return placeName
        } else {
            throw WeatherDataError.nilPlace
        }
    }
    
    func getWeather() throws -> String {
        if let weatherId = weather?[0].id {
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
            throw WeatherDataError.nilWeather
        }
    }
    
    //Visibilidade em metros
    func getVisibility() throws -> Int {
        if let visibility = visibility {
            return visibility
        } else {
            throw WeatherDataError.nilVisibility
        }
    }
    
    //Velocidade do vento em metros por segundo
    func getWindSpeed() throws -> Float {
        if let wind = wind?["speed"] {
            return wind
        } else {
            throw WeatherDataError.nilWind
        }
    }
    
    //Nuvens em percentual do céu coberto
    func getCloudiness() throws -> Float {
        if let clouds = clouds?["all"] {
            return clouds
        } else {
            throw WeatherDataError.nilCloudiness
        }
    }
    
    func getTemperature(in format : String = WeatherData.shared.temperatureFormat) throws -> Float {
        if let temp = main?["temp"] {
            if format == "Celsius" {
                let celsiusTemp = temp - 273.15
                return celsiusTemp
            } else {
                let fahrenheitTemp = -459.67 + (9*temp)/5
                return fahrenheitTemp
            }
        } else {
            throw WeatherDataError.nilTemperature
        }
    }
    
}

//MARK: - Reference for API response

/*
{
    "coord": {
        "lon": 139,
        "lat": 35
    },
    "weather": [
    {
      "id": 800,
      "main": "Clear",
      "description": "clear sky",
      "icon": "01n"
    }
    ],
    "base": "stations",
    "main": {
        "temp": 303.25,
        "feels_like": 301.3,
        "temp_min": 280.15,
        "temp_max": 304.15,
        "pressure": 1014,
        "humidity": 58
    },
    "visibility":10000,
    "wind": {
        "speed": 8.7,
        "deg": 90
    },
    "clouds": {
        "all": 40
    },
    "dt": 1591198180,
    "sys": {
        "type": 1,
        "id": 8363,
        "country": "BR",
        "sunrise": 1591173301,
        "sunset": 1591216196
    },
    "timezone": -10800,
    "id": 6320062,
    "name": "Fortaleza",
    "cod": 200
}
*/
