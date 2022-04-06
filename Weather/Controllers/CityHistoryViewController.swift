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

    //MARK:- Property Injected Items
    var viewModel: CityHistoryViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
