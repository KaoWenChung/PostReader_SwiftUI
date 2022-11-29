//
//  AppFlowCoordinator.swift
//  TechTest
//
//  Created by wyn on 2022/11/29.
//

final class AppFlowCoordinator {

    private let appDIContainer: AppDIContainer
    
    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
    }

    func start() {
        // In App Flow we can check if user needs to login, if yes we would run login flow
        let postSceneContainer = appDIContainer.makePostSceneDIContainer()
//        postSceneContainer.makeTabbarContentView(postListView: <#T##View#>, savedPostListView: <#T##View#>)
//        let flow = moviesSceneDIContainer.makeMoviesSearchFlowCoordinator(navigationController: navigationController)
//        flow.start()
    }
}
