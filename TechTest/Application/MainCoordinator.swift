//
//  MainCoordinator.swift
//  TechTest
//
//  Created by wyn on 2022/11/29.
//

import SwiftUI

enum AppFlow {
    case MostViewed
    case Favorites
}

protocol MainBaseCoordinator: CoordinatorType {
//    var homeCoordinator: HomeBaseCoordinator { get }
//    var ordersCoordinator: OrdersBaseCoordinator { get }
    func moveTo(flow: AppFlow)
}

final class MainCoordinator {
    
}
