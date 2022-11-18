//
//  PostsResponseEntity+Mapping.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

import Foundation
import CoreData

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

extension PostsRequestDTO {
    func toEntity(in context: NSManagedObjectContext) -> PostsRequestEntity {
        let entity: PostsRequestEntity = .init(context: context)
        entity.postID = Int32(id)
        return entity
    }
}
