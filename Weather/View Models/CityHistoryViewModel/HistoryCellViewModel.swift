//
//  HistoryCellViewModel.swift
//  Weather
//
//  Created by mac on 06/04/2022.
//

import Foundation

class HistoryCellViewModel {
    
    let date: Box<String>
    let temprature: Box<String>

    private let dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd.MM.yyyy - HH:mm"
      return dateFormatter
    }()
    
    init(cityWeatherInfo: CityWeatherInfo) {
        let dateString = dateFormatter.string(from: cityWeatherInfo.dateRecieved)
        date = Box(dateString)
        temprature = Box("\(cityWeatherInfo.descritption), \(cityWeatherInfo.temp)° C")
    }
    
}
