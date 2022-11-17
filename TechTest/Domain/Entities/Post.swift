//
// Created by Alex Jackson on 01/03/2021.
//

struct Post: Identifiable, Equatable, Codable {
    let id: Int
    var title: String
    var body: String
}
