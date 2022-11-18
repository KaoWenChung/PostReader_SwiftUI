//
//  SavedPostsResponseStorage.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

protocol SavedPostsResponseStorageType {
    func getAllSavedPosts(completion: @escaping ([Post]) -> Void)
}
