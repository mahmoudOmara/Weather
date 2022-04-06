//
//  CityWeatherDetailsViewController.swift
//  Weather
//
//  Created by mac on 06/04/2022.
//

import UIKit

class CityWeatherDetailsViewController: UIViewController {

    static let storyBoard = UIStoryboard(name: "Weather", bundle: nil)
    static let storyBoardIdentifier = String(describing: CityWeatherDetailsViewController.self)
    
    //MARK:- Property Injected Items
    var viewModel: CityWeatherDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
