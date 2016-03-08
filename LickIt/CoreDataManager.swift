//
//  CoreDataManager.swift
//  LickIt
//
//  Created by MBP on 15/06/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import Foundation
import CoreData

private let _sharedCoreDataManager = CoreDataManager()
class CoreDataManager {
    class var sharedInstance : CoreDataManager{
        return _sharedCoreDataManager
    }
    var persistanceStoreCoordinator : NSPersistentStoreCoordinator
    var managedObjectContext : NSManagedObjectContext
    
    
    init (){
        let modelUrl = NSBundle.mainBundle().URLForResource("RecipeModel", withExtension: "momd")
        let model = NSManagedObjectModel(contentsOfURL: modelUrl!)
        self.persistanceStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model!)
        
        let url = try? NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
        try? self.persistanceStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url?.URLByAppendingPathComponent("SavedRecipes.sqlite"), options: [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true])
        
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        self.managedObjectContext.persistentStoreCoordinator = self.persistanceStoreCoordinator
    }
    
    func saveObject(object: NSManagedObject){
        self.managedObjectContext.insertObject(object)
 //       self.managedObjectContext.save(nil)
    }
    
}