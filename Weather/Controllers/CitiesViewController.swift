//
//  CitiesViewController.swift
//  Weather
//
//  Created by mac on 05/04/2022.
//

import UIKit

class CitiesViewController: UIViewController {

    @IBOutlet weak var citiesTableView: UITableView!
    
    let viewModel = CitiesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        citiesTableView.register(CityTableViewCell.nib(), forCellReuseIdentifier: CityTableViewCell.reuseIdentifier)
        citiesTableView.dataSource = self
        citiesTableView.delegate = self
        
        viewModel.numberOfRows.bind { [weak self] _ in
            self?.citiesTableView.reloadData()
        }
        viewModel.route.bind { [weak self] route in
            guard let route = route else { return }
            self?.navigateByUsing(route: route)
        }
    }
    
    private func navigateByUsing(route: AddCityViewRoutes) {
        
        func navigateToAddNewCity() {
            let alert = UIAlertController(title: "Choose city", message: nil, preferredStyle: .alert)
            alert.addTextField()
            
            let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned alert, weak self] _ in
                guard let newcity = alert.textFields?.first?.text else { return }
                self?.viewModel.addNewCity(cityName: newcity)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(submitAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
          }
        
        func navigateToCityWeatherDetails(_ cityWeatherDetailsViewModel: CityWeatherDetailsViewModel) {
            let cityWeatherDetailsViewController = CityWeatherDetailsViewController.storyBoard.instantiateViewController(withIdentifier: CityWeatherDetailsViewController.storyBoardIdentifier) as! CityWeatherDetailsViewController
            cityWeatherDetailsViewController.viewModel = cityWeatherDetailsViewModel
            self.present(cityWeatherDetailsViewController, animated: true)
        }
        
        func navigateToCityHistory(_ cityHistoryViewModel: CityHistoryViewModel) {
            let cityHistoryViewController = CityHistoryViewController.storyBoard.instantiateViewController(withIdentifier: CityHistoryViewController.storyBoardIdentifier) as! CityHistoryViewController
            cityHistoryViewController.viewModel = cityHistoryViewModel
            self.navigationController?.pushViewController(cityHistoryViewController, animated: true)
        }
        
        switch route {
        case .addNewCity:
            navigateToAddNewCity()
        case let .histoyAboutCity(cityHistoryViewModel):
            navigateToCityHistory(cityHistoryViewModel)
        case let .weatherDetailsForCity(cityWeatherDetailsViewModel):
            navigateToCityWeatherDetails(cityWeatherDetailsViewModel)
        }
    }
    
    @IBAction func addCityButtonClicked(_ sender: Any) {
        self.viewModel.addNewCityClicked()
    }
}


extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier) as! CityTableViewCell
        cell.configure(viewModel: viewModel.viewModelForCell(at: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows.value
    }

}

extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectCity(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete  else { return }
        viewModel.deleteCity(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        viewModel.cityDetailDisclosureButtonClicked(at: indexPath.row)
    }
}
