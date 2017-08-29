//
//  PlaceCell.swift
//  places
//
//  Created by Adrian Loarri on 13/07/2017.
//  Copyright © 2017 Adrian Loarri. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {

    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var ingredientsLabel: UILabel!
    
    override func awakeFromNib() {

        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
