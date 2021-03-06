//
//  CityHistoryViewController.swift
//  Weather
//
//  Created by mac on 06/04/2022.
//

import UIKit

class CityHistoryViewController: UIViewController {
    
    static let storyBoard = UIStoryboard(name: "Weather", bundle: nil)
    static let storyBoardIdentifier = String(describing: CityHistoryViewController.self)
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var historyTableView: UITableView!
    
    //MARK:- Property Injected Items
    var viewModel: CityHistoryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTableView.register(HistoryTableViewCell.nib(), forCellReuseIdentifier: HistoryTableViewCell.reuseIdentifier)
        historyTableView.dataSource = self
        historyTableView.delegate = self
        
        viewModel.cityName.bind { [weak self] in
            self?.cityNameLabel.text = $0
        }
        
        viewModel.numberOfRows.bind { [weak self] _ in
            self?.historyTableView.reloadData()
        }
        
        viewModel.route.bind { [weak self] route in
            guard let route = route else { return }
            self?.navigateByUsing(route: route)
        }
    }
    
    private func navigateByUsing(route: HistoryViewRoutes) {
        func navigateToCityWeatherDetails(_ cityWeatherDetailsViewModel: CityWeatherDetailsViewModel) {
            let cityWeatherDetailsViewController = CityWeatherDetailsViewController.storyBoard.instantiateViewController(withIdentifier: CityWeatherDetailsViewController.storyBoardIdentifier) as! CityWeatherDetailsViewController
            cityWeatherDetailsViewController.viewModel = cityWeatherDetailsViewModel
            self.present(cityWeatherDetailsViewController, animated: true)
        }
        
        switch route {
        case let .weatherDetailsForCity(cityWeatherDetailsViewModel):
            navigateToCityWeatherDetails(cityWeatherDetailsViewModel)
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension CityHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.reuseIdentifier) as! HistoryTableViewCell
        cell.configure(viewModel: viewModel.viewModelForCell(at: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows.value
    }

}

extension CityHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectHistory(at: indexPath.row)
    }
    
}
