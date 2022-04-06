//
//  CityWeatherInfo.swift
//  Weather
//
//  Created by mac on 06/04/2022.
//

import Foundation

struct CityWeatherInfo {
    var weatherDescritption: String
    var icon: String
    var temp: Double
    var humidity: Double
    var wind: Double
    var dateRecieved: Date
}

extension CityWeatherInfo: Decodable {
    enum RootKeys: CodingKey {
        case weather, main, wind
    }
    
    enum WeatherKeys: CodingKey {
        case description, icon
    }
    
    enum MainKeys: CodingKey {
        case temp, humidity
    }
    
    enum WindKeys: CodingKey {
        case speed
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        // descritption and icon
        var weatherUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .weather)
        var weatherDescriptionsArray = [String]()
        var weatherIconsArray = [String]()
        while !weatherUnkeyedContainer.isAtEnd {
            let weatherDescriptionContainer = try weatherUnkeyedContainer.nestedContainer(keyedBy: WeatherKeys.self)
            weatherDescriptionsArray.append(try weatherDescriptionContainer.decode(String.self, forKey: .description))
            weatherIconsArray.append(try weatherDescriptionContainer.decode(String.self, forKey: .icon))
        }
        guard let weatherDescription = weatherDescriptionsArray.first,
        let weatherIcon = weatherIconsArray.first else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath + [RootKeys.weather], debugDescription: "weather array cannot be empty"))
        }
        weatherDescritption = weatherDescription
        icon = weatherIcon
        
        //temp
        let mainContainer = try container.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        temp = try mainContainer.decode(Double.self, forKey: .temp)
        
        //humidity
        humidity = try mainContainer.decode(Double.self, forKey: .humidity)
        
        //wind
        let windContainer = try container.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
        wind = try windContainer.decode(Double.self, forKey: .speed)
        
        dateRecieved = Date()
    }
}
