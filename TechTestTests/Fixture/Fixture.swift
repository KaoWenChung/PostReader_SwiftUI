//
//  Posts.swift
//  TechTestTests
//
//  Created by wyn on 2022/12/5.
//

@testable import TechTest
final class Fixture {
    static let posts: [Post] = [Post(id: 0, title: "TitleA", body: "BodyA"),
                                   Post(id: 1, title: "TitleB", body: "BodyB")]
}
