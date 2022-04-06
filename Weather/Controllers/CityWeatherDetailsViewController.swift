//
//  CityWeatherDetailsViewController.swift
//  Weather
//
//  Created by mac on 06/04/2022.
//

import UIKit

class CityWeatherDetailsViewController: UIViewController {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    static let storyBoard = UIStoryboard(name: "Weather", bundle: nil)
    static let storyBoardIdentifier = String(describing: CityWeatherDetailsViewController.self)
    
    //MARK:- Property Injected Items
    var viewModel: CityWeatherDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewModel.icon.bind { [weak self] in
            self?.icon.image = $0
        }
        
        viewModel.description.bind { [weak self] in
            self?.descriptionLabel.text = $0
        }
        
        viewModel.temp.bind { [weak self] in
            self?.tempratureLabel.text = $0
        }
        
        viewModel.humidity.bind { [weak self] in
            self?.humidityLabel.text = $0
        }
        
        viewModel.wind.bind { [weak self] in
            self?.windSpeedLabel.text = $0
        }
    }

}
