//
//  WeatherAPITests.swift
//  puttingAllTogetherTests
//
//  Created by Pedro Henrique Costa on 16/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import XCTest
@testable import puttingAllTogether

class WeatherDataTests: XCTestCase {
    
    override func setUp() {
        WeatherData.shared.resetData()
    }
    
    func test_weatherData_placeName_Fortaleza() {
        //Given
        WeatherData.shared.name = "Fortaleza"
        
        //When
        let name = WeatherData.shared.getPlace()
        
        //Then
        XCTAssertEqual(name, "Fortaleza")
    }
    
    func test_weatherData_weatherMain_clear() {
        //Given
        WeatherData.shared.weather = [
            subWeather(id: 800, main: "Clear", description: "clear sky"),
        ]

        //When
        let weather = WeatherData.shared.getWeather()

        //Then
        XCTAssertEqual(weather, "Clear")
    }

    func test_weatherData_temperature_celsiusBoiling() {
        //Given
        WeatherData.shared.main = [
            "temp": 373.15,
            "feels_like": 301.3,
            "temp_min": 280.15,
            "temp_max": 304.15,
            "pressure": 1014,
            "humidity": 58
        ]

        //When
        let temp = WeatherData.shared.getCelsiusTemperature()

        //Then
        XCTAssertEqual(temp, 100, accuracy: 0.01)
    }

    func test_weatherData_temperature_fahrenheitBoiling() {
        //Given
        WeatherData.shared.main = [
            "temp": 373.15,
            "feels_like": 301.3,
            "temp_min": 280.15,
            "temp_max": 304.15,
            "pressure": 1014,
            "humidity": 58
        ]

        //When
        let temp = WeatherData.shared.getFahrenheitTemperature()

        //Then
        XCTAssertEqual(temp, 212, accuracy: 0.01)
    }

    func test_weatherData_wind_100ms() {
        //Given
        WeatherData.shared.wind = [
            "speed": 100,
            "deg": 90
        ]
        
        //When
        let windSpeed = WeatherData.shared.getWindSpeed()
        
        //Then
        XCTAssertEqual(windSpeed, 100)
    }
    
    func test_weatherData_cloudiness_halfCover() {
        //Given
        WeatherData.shared.clouds = [
            "all": 50
        ]

        //When
        let clouds = WeatherData.shared.getCloudiness()

        //Then
        XCTAssertEqual(clouds, 50)
    }

    func test_weatherData_visibility_10kMeters() {
        //Given
        WeatherData.shared.visibility = 10000

        //When
        let visibility = WeatherData.shared.getVisibility()

        //Then
        XCTAssertEqual(visibility, 10000)
    }

}
