//
//  SavedPostListRepository.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

import Foundation

protocol SavedPostListRepositoryType {
    func fetchPostList(completion: @escaping ([Post]) -> Void)
}
