//
//  AppDelegate.swift
//  TechTest
//
//  Created by Alex Jackson on 01/03/2021.
//

import SwiftUI

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    let appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        appFlowCoordinator = AppFlowCoordinator(appDIContainer: appDIContainer)
        let rootViewController = appFlowCoordinator?.start()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }
}
