//
//  ResultCell.swift
//  Restaurant Finder
//
//  Created by Musaddique Billah Talha on 3/22/20.
//

import UIKit
import SDWebImage

class ResultCell: UITableViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var addressLabel: UILabel!
    @IBOutlet weak private var categoryImageView: UIImageView!
    
    static let reuseIdentifier = "ResultCell"
    static let nibName = "ResultCell"
    
    var resultViewModel: ResultCellViewModel? {
        didSet {
            
            guard let result = resultViewModel else {return}
            
            nameLabel.text = result.name
            addressLabel.text = result.address
            categoryImageView.sd_setImage(with: result.categoryIconURL, placeholderImage: UIImage(named: "none"))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = ""
        addressLabel.text = ""
        categoryImageView.image = nil
    }
    
}
