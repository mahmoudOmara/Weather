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
    }
    
    @IBAction func addCityButtonClicked(_ sender: Any) {
        
        let alert = UIAlertController(
          title: "Choose city",
          message: nil,
          preferredStyle: .alert)
        alert.addTextField()
        
        let submitAction = UIAlertAction(
          title: "Submit",
          style: .default) { [unowned alert, weak self] _ in
            guard let newcity = alert.textFields?.first?.text else { return }
            self?.viewModel.addNewCity(cityName: newcity)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(submitAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
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
    }
}
