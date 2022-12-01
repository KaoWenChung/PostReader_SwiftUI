//
//  PostCommentRepository.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

final class PostCommentRepository {

    private let dataTransferService: DataTransferServiceType

    init(dataTransferService: DataTransferServiceType) {
        self.dataTransferService = dataTransferService
    }
}

extension PostCommentRepository: PostCommentRepositoryType {
    func fetchPostComment(withID id: Int) async throws -> [Comment] {
        let endpoint = APIEndpoints.getPostComment(withID: id)
        let (data, _) = try await dataTransferService.request(with: endpoint)
        return data.toDomain()
    }
}
