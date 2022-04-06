//
//  HistoryTableViewCell.swift
//  Weather
//
//  Created by mac on 06/04/2022.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    static let reuseIdentifier = String(describing: HistoryTableViewCell.self)

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempratureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: HistoryTableViewCell.self), bundle: nil)
    }
    
    func configure() {
        
    }
    
}
