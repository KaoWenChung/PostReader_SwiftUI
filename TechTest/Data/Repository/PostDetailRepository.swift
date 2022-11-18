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
extension PostDetailRepository: PostDetailRepositoryType {
    func save(response: Post, for request: PostsRequest) {
        cache.save(response: response, for: request)
    }

    func delete(_ request: PostsRequest) {
        cache.delete(request)
    }

    func checkSaveStatus(by request: PostsRequest, completion: @escaping (Bool) -> Void) {
        cache.getResponse(for: request) { result in
            if result != nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
 
    func fetchPostDetail(withID id: Int, completion: @escaping (Post) -> Void) {
        let cacheRequest = PostsRequest(id: id)
        cache.getResponse(for: cacheRequest) { result in
            if let result {
                completion(result)
                return
            }
            Task.init {
                let endpoint = APIEndpoints.getPostDetail(withID: id)
                let (data, _) = try await self.dataTransferService.request(with: endpoint)
                completion(data)
            }
            
        }
        
    }
}
