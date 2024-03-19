//
//  MyAppAppearance.swift
//  YDRootNavigationController _Example
//
//  Created by One on 2024/3/14.
//  Copyright © 2024 jsone All rights reserved.
//

import UIKit

class MyAppAppearance: YDAppAppearanceProtocol {
    var navigationBarShadowColor: UIColor? { .red }
    var titleTextAttributes: [NSAttributedString.Key : Any]? { [NSAttributedString.Key.foregroundColor: UIColor.blue] }
    var backItemImage: UIImage? { UIImage(named: "nav_back_black_button") }
    var backItemImageInsets: UIEdgeInsets? { UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 0) }
}
