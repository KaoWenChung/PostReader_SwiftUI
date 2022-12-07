//
//  CoreDataPostsResponseStorage.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

import Foundation
import CoreData

final class CoreDataPostsResponseStorage {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }

    // MARK: - Private

    private func fetchRequest(for requestDto: PostsRequest) -> NSFetchRequest<PostsRequestEntity> {
        let request: NSFetchRequest = PostsRequestEntity.fetchRequest()
        request.predicate = NSPredicate(format: "postID = %ld", requestDto.postId)
        return request
    }

    private func deleteResponse(for requestDto: PostsRequest, in context: NSManagedObjectContext) {
        let request = fetchRequest(for: requestDto)

        do {
            guard let result = try context.fetch(request).first,
                  let response = result.response else { return }
            context.delete(response)
            context.delete(result)
        } catch {
            print(error)
        }
    }
}

extension CoreDataPostsResponseStorage: PostsResponseStorageType {

    func getResponse(for requestDto: PostsRequest, completion: @escaping (Post?) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest = self.fetchRequest(for: requestDto)
                let requestEntity = try context.fetch(fetchRequest).first

                completion(requestEntity?.response?.toDTO())
            } catch {
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataPostsResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }

    func save(response responseDto: Post, for requestDto: PostsRequest) {
        coreDataStorage.performBackgroundTask { context in
            do {
                self.deleteResponse(for: requestDto, in: context)

                let requestEntity = requestDto.toEntity(in: context)
                requestEntity.response = responseDto.toEntity(in: context)

                try context.save()
            } catch {
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataPostsResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }

    func delete(_ request: PostsRequest) {
        coreDataStorage.performBackgroundTask { context in
            do {
                self.deleteResponse(for: request, in: context)
                try context.save()
            } catch {
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataPostsResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
}

