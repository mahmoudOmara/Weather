//
//  CityHistoryViewModel.swift
//  Weather
//
//  Created by mac on 06/04/2022.
//

import Foundation

class CityHistoryViewModel {
    
    private let city: City
    private let managedCity: ManagedCity

    private var historyWeatherInfo: [(cityWeatherInfo: CityWeatherInfo, managedCityWeatherInfo: ManagedCityWeatherInfo)] = [] {
        didSet {
            self.numberOfRows.value = historyWeatherInfo.count
        }
    }

    var numberOfRows = Box(0)

    init(city: City, managedCity: ManagedCity) {
        self.city = city
        self.managedCity = managedCity
        
        let historyManagedWeatherInfo: [ManagedCityWeatherInfo] = managedCity.history?.allObjects as! [ManagedCityWeatherInfo]
        self.historyWeatherInfo = historyManagedWeatherInfo.compactMap { managedCityWeatherInfo -> (cityWeatherInfo: CityWeatherInfo, managedCityWeatherInfo: ManagedCityWeatherInfo) in
            let cityWeatherInfo = CityWeatherInfo(descritption: managedCityWeatherInfo.description, icon: managedCityWeatherInfo.icon!, temp: managedCityWeatherInfo.temp, humidity: managedCityWeatherInfo.humidity, wind: managedCityWeatherInfo.wind, dateRecieved: managedCityWeatherInfo.dateRecieved!)
            return (cityWeatherInfo: cityWeatherInfo, managedCityWeatherInfo: managedCityWeatherInfo)
        }
    }
    
    func viewModelForCell(at index: Int) -> HistoryCellViewModel {
        return HistoryCellViewModel(cityWeatherInfo: historyWeatherInfo[index].cityWeatherInfo)
    }
}
