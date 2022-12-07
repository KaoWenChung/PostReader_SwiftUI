//
//  CoreDataSavedPostsResponseStorage.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

import Foundation
import CoreData

final class CoreDataSavedPostsResponseStorage {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }

    // MARK: - Private

    private func findAllPosts(in managedObjectContext: NSManagedObjectContext) throws -> [Post] {
        var workouts: [Post] = []
        let fetchRequest: NSFetchRequest<PostsResponseEntity> = PostsResponseEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(PostsResponseEntity.request.postID), ascending: true)]
        do {
            // Perform Fetch Request
            workouts = try managedObjectContext.fetch(fetchRequest).toDTOs()
        } catch {
            throw error
        }
        return workouts
    }
}

extension CoreDataSavedPostsResponseStorage: SavedPostsResponseStorageType {

    func getAllSavedPosts(completion: @escaping ([Post]) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let value = try self.findAllPosts(in: context)
                completion(value)
            } catch {
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataPostsResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
}

