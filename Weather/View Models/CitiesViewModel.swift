//
//  CitiesViewModel.swift
//  Weather
//
//  Created by mac on 05/04/2022.
//

import Foundation


class CitiesViewModel {
    
    var numberOfRows = Box(0)
    private var cities: [(city: City, mangedCity: ManagedCity)] = [] {
        didSet {
            self.numberOfRows.value = cities.count
        }
    }
    
    init() {
        getPreviouslyAddedCities()
    }
    
    func viewModelForCell(at index: Int) -> CityCellViewModel {
        return CityCellViewModel(city: cities[index].city)
    }
    
    private func getPreviouslyAddedCities() {
        
        let managedCities = CoreDataManager.shared.fetch(ofType: ManagedCity.self)
        
        self.cities = managedCities.compactMap {
            guard let cityName = $0.name else { return nil }
            return (city: City(name: cityName), mangedCity: $0)
        }
    }
    
    func addNewCity(cityName: String) {
        let managedCity = ManagedCity(context: CoreDataManager.shared.context)
        managedCity.name = cityName
        CoreDataManager.shared.saveContext()
        self.cities.append((city: City(name: cityName), mangedCity: managedCity))
    }
    
    func deleteCity(at index: Int) {
        let managedCity = self.cities.remove(at: index).mangedCity
        CoreDataManager.shared.context.delete(managedCity)
        CoreDataManager.shared.saveContext()
    }
}
