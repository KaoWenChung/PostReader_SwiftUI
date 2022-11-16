//
//  CoreDataStorage.swift
//  TechTest
//
//  Created by wyn on 2022/11/16.
//

import CoreData

enum CoreDataStorageError: Error {
    case readError(Error)
    case saveError(Error)
    case deleteError(Error)
}
