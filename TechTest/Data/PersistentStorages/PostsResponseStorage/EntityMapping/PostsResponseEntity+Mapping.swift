//
//  PostsResponseEntity+Mapping.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

import Foundation
import CoreData

extension Array where Element == PostsResponseEntity {
    func toDTOs() -> [Post] {
        var result: [Post] = []
        for item in self {
            guard let post = item.toDTO() else { continue }
            result.append(post)
        }
        return result
    }
}
extension PostsResponseEntity {
    func toDTO() -> Post? {
        return .init(id: Int(id), title: title ?? "", body: body ?? "")
    }
}
extension Post {
    func toEntity(in context: NSManagedObjectContext) -> PostsResponseEntity {
        let entity: PostsResponseEntity = .init(context: context)
        entity.body = body
        entity.title = title
        entity.id = Int64(id)
        return entity
    }
}

extension PostsRequest {
    func toEntity(in context: NSManagedObjectContext) -> PostsRequestEntity {
        let entity: PostsRequestEntity = .init(context: context)
        entity.postID = Int64(postId)
        return entity
    }
}
