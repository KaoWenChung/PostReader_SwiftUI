//
//  PostDetailRepository.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

final class PostDetailRepository {

    private let dataTransferService: DataTransferServiceType

    init(dataTransferService: DataTransferServiceType) {
        self.dataTransferService = dataTransferService
    }
}

extension PostDetailRepository: PostDetailRepositoryType {
    func fetchPostDetail(withID id: Int) async throws -> Post {
        let endpoint = APIEndpoints.getPostDetail(withID: id)
        let (data, _) = try await dataTransferService.request(with: endpoint)
        return data
    }
}
