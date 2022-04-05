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
    }
    
}


extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier) as! CityTableViewCell
        cell.configure(viewModel: viewModel.viewModelForCell(at: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

}
