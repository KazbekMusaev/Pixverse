//
//  VideoModel+CoreDataProperties.swift
//  Pixverse
//
//  Created by KazbekMusaev on 02.07.2025.
//
//

import Foundation
import CoreData

@objc(VideoModel)
public class VideoModel: NSManagedObject {

}

extension VideoModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VideoModel> {
        return NSFetchRequest<VideoModel>(entityName: "VideoModel")
    }

    @NSManaged public var name: String?
    @NSManaged public var sizes: String?
    @NSManaged public var id: UUID?
    @NSManaged public var status: String?
    @NSManaged public var pathToFiles: String?
    @NSManaged public var date: Date?
    @NSManaged public var favorite: Bool

}

extension VideoModel : Identifiable {
    //MARK: Update Core Data
    
    func updateData(pathToVideo: String?, status: String?, favorite: Bool?) {
        if let status {
            self.status = status
        }
        if let pathToVideo {
            self.pathToFiles = pathToVideo
        }
        if let favorite {
            self.favorite = favorite
        }
        try? managedObjectContext?.save()
    }
    
    //MARK: Delete Core Data
    
    func deleteData () {
        managedObjectContext?.delete(self)
        let cManager = CoreManager.shared
        cManager.readData()
        try? managedObjectContext?.save()
    }
}
