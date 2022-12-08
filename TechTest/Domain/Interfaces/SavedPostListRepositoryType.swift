//
//  SavedPostListRepository.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

protocol SavedPostListRepositoryType {
    func fetchPostList(completion: @escaping ([Post]) -> Void)
}
