//
// Created by Alex Jackson on 01/03/2021.
//

import Foundation

extension Post {
    static func loadAll(_ completion: @escaping (Result<[Post], Error>) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            do {
                let data = data ?? Data()
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }

    static func loadPost(withID postID: Int, completion: @escaping (Result<Post, Error>) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(postID)")!
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            do {
                let data = data ?? Data()
                let post = try JSONDecoder().decode(Post.self, from: data)
                completion(.success(post))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
