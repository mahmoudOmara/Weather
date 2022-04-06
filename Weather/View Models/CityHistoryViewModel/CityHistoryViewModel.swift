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

    private var historyWeatherInfo: [(cityWeatherInfo: CityWeatherInfo, managedCityWeatherInfo: ManagedCityWeatherInfo)] = [] 

    var numberOfRows = Box(0)
    let cityName = Box("")

    init(city: City, managedCity: ManagedCity) {
        self.city = city
        self.managedCity = managedCity
        
        self.cityName.value = "\(city.name)\rHistorical"

        let historyManagedWeatherInfo: [ManagedCityWeatherInfo] = managedCity.history?.allObjects as! [ManagedCityWeatherInfo]
        self.historyWeatherInfo = historyManagedWeatherInfo.compactMap { managedCityWeatherInfo -> (cityWeatherInfo: CityWeatherInfo, managedCityWeatherInfo: ManagedCityWeatherInfo) in
            let cityWeatherInfo = CityWeatherInfo(weatherDescritption: managedCityWeatherInfo.weatherDescritption!, icon: managedCityWeatherInfo.icon!, temp: managedCityWeatherInfo.temp, humidity: managedCityWeatherInfo.humidity, wind: managedCityWeatherInfo.wind, dateRecieved: managedCityWeatherInfo.dateRecieved!)
            return (cityWeatherInfo: cityWeatherInfo, managedCityWeatherInfo: managedCityWeatherInfo)
        }
        self.numberOfRows.value = historyWeatherInfo.count
    }
    
    func viewModelForCell(at index: Int) -> HistoryCellViewModel {
        return HistoryCellViewModel(cityWeatherInfo: historyWeatherInfo[index].cityWeatherInfo)
    }
}
