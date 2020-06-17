//
//  WeatherAPITests.swift
//  puttingAllTogetherTests
//
//  Created by Pedro Henrique Costa on 16/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import XCTest
@testable import puttingAllTogether

class WeatherAPITests: XCTestCase {

    var weatherInfo = WeatherAPI()
    
    override func setUp() {
        weatherInfo.userWeather = WeatherData()
    }
    
    func test_weatherAPI_placeName_Fortaleza() {
        //Given
        weatherInfo.userWeather.name = "Fortaleza"
        
        //When
        let name = weatherInfo.getPlace()
        
        //Then
        XCTAssertEqual(name, "Fortaleza")
    }
    
    func test_weatherAPI_weatherMain_clear() {
        //Given        
        weatherInfo.userWeather.weather = [
            subWeather(id: 800, main: "Clear", description: "clear sky"),
        ]

        //When
        let weather = weatherInfo.getWeather()

        //Then
        XCTAssertEqual(weather, "Clear")
    }

    func test_weatherAPI_temperature_celsiusBoiling() {
        //Given
        weatherInfo.userWeather.main = [
            "temp": 373.15,
            "feels_like": 301.3,
            "temp_min": 280.15,
            "temp_max": 304.15,
            "pressure": 1014,
            "humidity": 58
        ]

        //When
        let temp = weatherInfo.getCelsiusTemperature()

        //Then
        XCTAssertEqual(temp, 100, accuracy: 0.01)
    }

    func test_weatherAPI_temperature_fahrenheitBoiling() {
        //Given
        weatherInfo.userWeather.main = [
            "temp": 373.15,
            "feels_like": 301.3,
            "temp_min": 280.15,
            "temp_max": 304.15,
            "pressure": 1014,
            "humidity": 58
        ]

        //When
        let temp = weatherInfo.getFahrenheitTemperature()

        //Then
        XCTAssertEqual(temp, 212, accuracy: 0.01)
    }

    func test_weatherAPI_wind_100ms() {
        //Given
        weatherInfo.userWeather.wind = [
            "speed": 100,
            "deg": 90
        ]
        
        //When
        let windSpeed = weatherInfo.getWindSpeed()
        
        //Then
        XCTAssertEqual(windSpeed, 100)
    }
    
    func test_weatherAPI_cloudiness_halfCover() {
        //Given
        weatherInfo.userWeather.clouds = [
            "all": 50
        ]

        //When
        let clouds = weatherInfo.getCloudiness()

        //Then
        XCTAssertEqual(clouds, 50)
    }

    func test_weatherAPI_visibility_10kMeters() {
        //Given
        weatherInfo.userWeather.visibility = 10000

        //When
        let visibility = weatherInfo.getVisibility()

        //Then
        XCTAssertEqual(visibility, 10000)
    }

}
