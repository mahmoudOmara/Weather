//
//  CityWeatherDetailsViewController.swift
//  Weather
//
//  Created by mac on 06/04/2022.
//

import UIKit

class CityWeatherDetailsViewController: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var detailsCardView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var dateRecievedOnLabel: UILabel!
    
    static let storyBoard = UIStoryboard(name: "Weather", bundle: nil)
    static let storyBoardIdentifier = String(describing: CityWeatherDetailsViewController.self)
    
    //MARK:- Property Injected Items
    var viewModel: CityWeatherDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        detailsCardView.layer.cornerRadius = 45
        detailsCardView.layer.shadowColor = UIColor.black.cgColor
        detailsCardView.layer.shadowOffset = CGSize(width: -10, height: 10)
        detailsCardView.layer.shadowOpacity = 0.2
        detailsCardView.layer.shadowRadius = 15.0
        
        viewModel.loadingState.bind { [weak self] in
            switch $0 {
            case .loading:
                self?.detailsCardView.isHidden = true
                self?.showLoading()
            case .notLoading:
                self?.detailsCardView.isHidden = false
                self?.hideLoading()
            }
        }
        
        viewModel.cityName.bind { [weak self] in
            self?.cityNameLabel.text = $0
        }
        
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
        
        viewModel.dateRecievedOn.bind { [weak self] in
            self?.dateRecievedOnLabel.text = $0
        }
    }

    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
