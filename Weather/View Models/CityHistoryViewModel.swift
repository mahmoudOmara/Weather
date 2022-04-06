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

    init(city: City, managedCity: ManagedCity) {
        self.city = city
        self.managedCity = managedCity
    }
}
