//
//  CoreManager.swift
//  Pixverse
//
//  Created by KazbekMusaev on 02.07.2025.
//

import Foundation
import CoreData

final class CoreManager {
    
    static let shared = CoreManager()
    var posts = [VideoModel]()
    
    private init() {
        readData()
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CDVideo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: Create Core Data
    func createData(videoModel: SaveVideoModel, pathToFiles: String) {
        let createData = VideoModel(context: persistentContainer.viewContext)
        createData.name = videoModel.name
        createData.date = videoModel.date
        createData.pathToFiles = pathToFiles
        createData.favorite = false
        saveContext()
        readData()
    }
    
    //MARK: Read Core Data
    
    func readData () {
        let post = VideoModel.fetchRequest()
        if let posts = try? persistentContainer.viewContext.fetch(post) {
            self.posts = posts
        }
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil, userInfo: nil)
    }
    
    func isPostSavedInCoreData() -> Bool {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<VideoModel> = VideoModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@")
        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            print("Error fetching post: \(error)")
            return false
        }
    }
    
}
