//
//  Route.swift
//  Weather
//
//  Created by mac on 06/04/2022.
//

import Foundation

enum AddCityViewRoutes {
    case addNewCity
    case histoyAboutCity(cityHistoryViewModel: CityHistoryViewModel)
    case weatherDetailsForCity(cityWeatherDetailsViewModel: CityWeatherDetailsViewModel)
}
