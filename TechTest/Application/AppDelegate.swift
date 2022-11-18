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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Create the SwiftUI view that provides the window contents.

        // Use a UIHostingController as window root view controller.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: TabbarContentView())
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}
