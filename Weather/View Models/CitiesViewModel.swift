//
//  CitiesViewModel.swift
//  Weather
//
//  Created by mac on 05/04/2022.
//

import Foundation


class CitiesViewModel {
    
    var numberOfRows: Int = 0
    var cities: [City] = []
    
    init() {
        getPreviouslyAddedCities()
    }
    
    func viewModelForCell(at index: Int) -> CityCellViewModel {
        return CityCellViewModel(city: cities[index])
    }
    
    private func getPreviouslyAddedCities() {
        //TODO:- get cities from core data
        self.cities = []
        self.numberOfRows = cities.count
    }
}
