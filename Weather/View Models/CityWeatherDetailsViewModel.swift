//
//  CityWeatherDetailsViewModel.swift
//  Weather
//
//  Created by mac on 06/04/2022.
//

import Foundation

class CityWeatherDetailsViewModel {
    
    private let city: City
    private let managedCity: ManagedCity
    
    init(city: City, managedCity: ManagedCity) {
        self.city = city
        self.managedCity = managedCity
        
        OpenWeatherService.getWeatherDataForCity(self.city.name) { [weak self] weatherInfo, error in
            guard let self = self else { return }
            guard let weatherInfo = weatherInfo else { return }
            
        }
    }
}
