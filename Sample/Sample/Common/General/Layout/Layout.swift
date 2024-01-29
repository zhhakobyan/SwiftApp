//
//  Layout.swift
//  Sample
//
//  Created by Zhanna on 27.01.24.
//

import UIKit

protocol LayoutProtocol {
    static var indent8: CGFloat { get }
    static var indent16: CGFloat { get }
    static var indent24: CGFloat { get }
    static var indent32: CGFloat { get }
}

enum ProjectLayout: LayoutProtocol {
    static let indent8: CGFloat = 8
    static let indent16: CGFloat = 16
    static let indent24: CGFloat = 24
    static let indent32: CGFloat = 32
    static let indent40: CGFloat = 40
}
