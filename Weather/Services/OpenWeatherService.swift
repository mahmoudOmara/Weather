//
//  OpenWeatherService.swift
//  Weather
//
//  Created by mac on 06/04/2022.
//

import Foundation
import AFNetworking



class OpenWeatherService {
    typealias WeatherDataCompletion = (CityWeatherInfo?, Error?) -> ()

    private static let apiKey = "f5cb0b965ea1564c50c6f1b74534d823"
    private static let host = "https://api.openweathermap.org"
    private static let path = "/data/2.5/weather"
    
    static func getWeatherDataForCity(_ cityName: String, completion: @escaping WeatherDataCompletion) {
        let url = host + path
        let params = [
            "q" : cityName,
            "appid" : apiKey,
            "units" : "metric"
        ]
        let manager = AFHTTPSessionManager()
        manager.get(url, parameters: params, headers: nil, progress: nil) {
            (operation, responseObject) in
            
            let decoder = JSONDecoder()
            let jsonData = try! JSONSerialization.data(withJSONObject: responseObject as Any)
            let cityWeatherInfo = try? decoder.decode(CityWeatherInfo.self, from: jsonData)

            DispatchQueue.main.async {
                completion(cityWeatherInfo, nil)
            }
        } failure: {
            (operation, error) in
            print("Error: " + error.localizedDescription)
            DispatchQueue.main.async {
                completion(nil, error)
            }
        }
    }
}
