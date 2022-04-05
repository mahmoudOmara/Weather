//
//  CitiesViewModel.swift
//  Weather
//
//  Created by mac on 05/04/2022.
//

import Foundation


class CitiesViewModel {
    
    var numberOfRows = Box(0)
    private var cities: [City] = []
    
    init() {
        getPreviouslyAddedCities()
    }
    
    func viewModelForCell(at index: Int) -> CityCellViewModel {
        return CityCellViewModel(city: cities[index])
    }
    
    private func getPreviouslyAddedCities() {
        //TODO:- get cities from core data
        self.cities = [City(name: "Alex"), City(name: "Cairo")]
        self.numberOfRows = Box(cities.count)
    }
}
