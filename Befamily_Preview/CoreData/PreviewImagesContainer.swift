//
//  PreviewImagesContainer.swift
//  Befamily_Preview
//
//  Created by Jung Hwan Park on 2023/01/09.
//

import Foundation
import CoreData
import UIKit

class PreviewImageContainer
{
    let persistentContainer: NSPersistentContainer
    
    static let shared = PreviewImageContainer()
    
    var viewContext: NSManagedObjectContext
    {
        return persistentContainer.viewContext
    }
    
    func saveData()
    {
        do
        {
            try viewContext.save()
        }
        catch
        {
            print(error.localizedDescription)
            viewContext.rollback()
        }
    }
    
    func fetchSavedImages() -> [PreviewImage]
    {
        let request: NSFetchRequest<PreviewImage> = PreviewImage.fetchRequest()
        do
        {
            return try viewContext.fetch(request)
        }
        catch
        {
            print(error.localizedDescription)
            return []
        }
    }
    
    private init()
    {
        self.persistentContainer = NSPersistentContainer(name: "PreviewImagesDataModel")
        self.persistentContainer.loadPersistentStores
        { _, error in
            print(error?.localizedDescription)
        }
    }
}
