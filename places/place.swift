//
//  place.swift
//  places
//
//  Created by Adrian Loarri on 05/08/2017.
//  Copyright © 2017 Adrian Loarri. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// PARA UTILIZAR COREDATA ES NECESARION DEFINIR LA CLASE COMO UN OBJETO NS Y CAMBIAR LAS VARIABLES CON EL @NSMANAGE Y SE CAMBIAN POR STRINGS OPCIONALES O DEFINIDOS EN EL CASO DE LA IMAGEN SE UTILIZA UN NSDATA

class Place : NSManagedObject {
    @NSManaged var name : String
    @NSManaged var type : String
    @NSManaged var location : String
    @NSManaged var phone : String?
    @NSManaged var website : String?
    @NSManaged var image : NSData?
    @NSManaged var rating : String?
    
}
