//
//  RecipeDetailTableViewCell.swift
//  recipes
//
//  Created by Adrian Loarri on 17/07/2017.
//  Copyright © 2017 Adrian Loarri. Loarri All rights reserved.
//

import UIKit

class PlaceDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var keyLabel: UILabel!

    @IBOutlet var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
