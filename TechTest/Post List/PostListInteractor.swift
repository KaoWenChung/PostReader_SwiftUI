//
// Created by Alex Jackson on 01/03/2021.
//

import Dispatch

final class PostListInteractor {

    weak var view: PostListViewing?

    func fetchAllPosts() {
        Post.loadAll { [self] result in
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    view?.display(posts)
                }
            case .failure:
                // TODO: - Handle the error
                break
            }
        }
    }
}
