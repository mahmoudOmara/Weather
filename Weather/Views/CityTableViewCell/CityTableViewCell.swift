//
//  CityTableViewCell.swift
//  Weather
//
//  Created by mac on 05/04/2022.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: CityTableViewCell.self)
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: CityTableViewCell.self), bundle: nil)
    }
    
    
    func configure(viewModel: CityCellViewModel) {
        nameLabel.text = viewModel.name
    }

}
