//
//  CitiesViewModel.swift
//  Weather
//
//  Created by mac on 05/04/2022.
//

import Foundation


class CitiesViewModel {
    
    
    var route: Box<Route?> = Box(nil)
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
    
    func addNewCityClicked() {
        route.value = .addNewCity
    }
    
    func didSelectCity(at index: Int) {
        let generalCity = cities[index]
        let cityWeatherDetailsViewModel = CityWeatherDetailsViewModel(city: generalCity.city, managedCity: generalCity.mangedCity)
        route.value = .weatherForCity(cityWeatherDetailsViewModel: cityWeatherDetailsViewModel)
    }
    
    func cityDetailDisclosureButtonClicked(at index: Int) {
        let generalCity = cities[index]
        let cityHistoryViewModel = CityHistoryViewModel(city: generalCity.city, managedCity: generalCity.mangedCity)
        route.value = .histoyAboutCity(cityHistoryViewModel: cityHistoryViewModel)
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
