//
//  PreviewImagesContainer.swift
//  Befamily_Preview
//
//  Created by Jung Hwan Park on 2023/01/09.
//

import Foundation
import CoreData

class PreviewImageContainer
{
    let persistentContainer: NSPersistentContainer
    
    init()
    {
        self.persistentContainer = NSPersistentContainer(name: "PreviewImagesDataModel")
        self.persistentContainer.loadPersistentStores
        { _, error in
            print(error?.localizedDescription)
        }
    }
}
