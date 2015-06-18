//
//  IngredientModel.swift
//  LickIt
//
//  Created by MBP on 16/06/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import Foundation
import CoreData
@objc(IngredientModel)
class IngredientModel: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var image: UIImage
    @NSManaged var recipes: NSSet

}
