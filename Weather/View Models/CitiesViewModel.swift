//
//  CitiesViewModel.swift
//  Weather
//
//  Created by mac on 05/04/2022.
//

import Foundation


class CitiesViewModel {
    
    var numberOfRows = Box(0)
    private var cities: [City] = [] {
        didSet {
            self.numberOfRows.value = cities.count
        }
    }
    
    init() {
        getPreviouslyAddedCities()
    }
    
    func viewModelForCell(at index: Int) -> CityCellViewModel {
        return CityCellViewModel(city: cities[index])
    }
    
    private func getPreviouslyAddedCities() {
        
        let managedCities = CoreDataManager.shared.fetch(ofType: ManagedCity.self)
        
        self.cities = managedCities.compactMap {
            guard let cityName = $0.name else { return nil }
            return City(name: cityName)
        }
    }
    
    func addNewCity(cityName: String) {
        
        let managedCity = ManagedCity(context: CoreDataManager.shared.context)
        managedCity.name = cityName
        CoreDataManager.shared.saveContext()
        self.cities.append(City(name: cityName))
    }
}
