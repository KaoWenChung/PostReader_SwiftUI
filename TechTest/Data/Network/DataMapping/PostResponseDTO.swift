//
//  PostResponseDTO.swift
//  TechTest
//
//  Created by wyn on 2022/12/1.
//

struct PostResponseDTO: Codable {
    let id: Int
    let title: String
    let body: String
}

extension PostResponseDTO {
    func toDomain() -> Post {
        return .init(id: id,
                     title: title,
                     body: body)
    }
}

extension Array where Element == PostResponseDTO {
    func toDomain() -> [Post] {
        self.map { $0.toDomain() }
    }
}
