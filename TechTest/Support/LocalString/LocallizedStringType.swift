//
//  LocalString.swift
//  TechTest
//
//  Created by wyn on 2022/12/1.
//

import Foundation

protocol LocallizedStringType {}

extension LocallizedStringType {
    var prefix: String { return "\(type(of: self))" }
    var text: String {
        return NSLocalizedString(prefix + "." + String(describing: self), comment: "")
    }
}
