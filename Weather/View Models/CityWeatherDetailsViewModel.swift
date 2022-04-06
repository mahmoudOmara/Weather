//
//  CityWeatherDetailsViewModel.swift
//  Weather
//
//  Created by mac on 06/04/2022.
//

import Foundation
import UIKit.UIImage

class CityWeatherDetailsViewModel {
    
    enum LoadingState {
        case loading, notLoading
    }
    
    private let city: City
    private let managedCity: ManagedCity
    
    private let numbersFormatter: NumberFormatter = {
      let tempFormatter = NumberFormatter()
      tempFormatter.numberStyle = .none
      tempFormatter.maximumFractionDigits = 2
      return tempFormatter
    }()
    
    private let dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd.MM.yyyy - HH:mm"
      return dateFormatter
    }()
    
    let icon: Box<UIImage?> = Box(nil)
    let description = Box("")
    let temp = Box("")
    let humidity = Box("")
    let wind = Box("")
    let dateRecievedOn = Box("")
    let loadingState = Box(LoadingState.notLoading)
    
    init(city: City, managedCity: ManagedCity) {
        self.city = city
        self.managedCity = managedCity
        
        self.loadingState.value = .loading
        OpenWeatherService.getWeatherDataForCity(self.city.name) { [weak self] weatherInfo, error in
            guard let self = self else { return }
            guard let weatherInfo = weatherInfo else { return }
            self.loadingState.value = .notLoading
            let iconURL = "https://openweathermap.org/img/w/\(weatherInfo.icon).png"
            if let imageData = try? Data(contentsOf: URL(string: iconURL)!) {
                self.icon.value = UIImage(data: imageData)
            }
            self.description.value = weatherInfo.descritption
            self.temp.value = (self.numbersFormatter.string(from: weatherInfo.temp as NSNumber) ?? "") + "° C"
            self.humidity.value = (self.numbersFormatter.string(from: weatherInfo.humidity as NSNumber) ?? "") + "%"
            self.wind.value =  (self.numbersFormatter.string(from: weatherInfo.wind as NSNumber) ?? "") + " km/h"
            self.dateRecievedOn.value = "Weather information for London received on " + self.dateFormatter.string(from: weatherInfo.dateRecieved)
        }
    }
}
