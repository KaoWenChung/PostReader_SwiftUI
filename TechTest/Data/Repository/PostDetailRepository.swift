//
//  PostDetailRepository.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

final class PostDetailRepository {

    private let dataTransferService: DataTransferServiceType
    private let cache: PostsResponseStorageType

    init(dataTransferService: DataTransferServiceType, cache: PostsResponseStorageType) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }
}
// TODO: saveRecentQuery
extension PostDetailRepository: PostDetailRepositoryType {
    func saveRecentQuery(query: PostsRequest, completion: @escaping (Result<PostsRequest, Error>) -> Void) {
        
    }
    
    func fetchPostDetail(withID id: Int) async throws -> Post {
        let endpoint = APIEndpoints.getPostDetail(withID: id)
        let (data, _) = try await dataTransferService.request(with: endpoint)
        return data
    }
}
