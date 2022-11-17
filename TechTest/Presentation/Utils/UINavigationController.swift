//
//  UINavigation.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//

import Foundation
extension UINavigationController {
    // Remove back button text
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
