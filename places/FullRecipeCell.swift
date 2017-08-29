//
//  FullRecipeCell.swift
//  places
//
//  Created by Adrian Loarri on 15/07/2017.
//  Copyright © 2017 Adrian Loarri. All rights reserved.
//

import UIKit

class FullRecipeCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!

    @IBOutlet var thumbnailmageView: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
