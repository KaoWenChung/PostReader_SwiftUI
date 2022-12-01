//
//  CommentResponseDTO.swift
//  TechTest
//
//  Created by wyn on 2022/12/1.
//

struct CommentResponseDTO: Codable {
    let id: Int
    let name: String
    let body: String
}

extension CommentResponseDTO {
    func toDomain() -> Comment {
        return .init(id: id,
                     name: name,
                     body: body)
    }
}

extension Array where Element == CommentResponseDTO {
    func toDomain() -> [Comment] {
        self.map { $0.toDomain() }
    }
}
