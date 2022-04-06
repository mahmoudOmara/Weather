//
//  Route.swift
//  Weather
//
//  Created by mac on 06/04/2022.
//

import Foundation

enum Route {
    case addNewCity
    case histoyAboutCity(cityHistoryViewModel: CityHistoryViewModel)
    case weatherForCity(cityWeatherDetailsViewModel: CityWeatherDetailsViewModel)
}
