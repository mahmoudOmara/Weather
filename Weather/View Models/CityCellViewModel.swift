//
//  CityCellViewModel.swift
//  Weather
//
//  Created by mac on 05/04/2022.
//

import Foundation

class CityCellViewModel {
    let name: Box<String>

    init(city: City) {
        name = Box(city.name)
    }

}
