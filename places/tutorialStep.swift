//
//  tutorialStep.swift
//  places
//
//  Created by Adrian Loarri on 24/08/2017.
//  Copyright © 2017 Adrian Loarri. All rights reserved.
//

import Foundation
import UIKit

class tutorialStep: NSObject {
    
    var index = 0
    var heading = " "
    var content = " "
    var image: UIImage!

    init(index: Int, heading: String, content: String, image: UIImage){
        self.index = index
        self.heading = heading
        self.content = content
        self.image = image
    
    }
    
}
