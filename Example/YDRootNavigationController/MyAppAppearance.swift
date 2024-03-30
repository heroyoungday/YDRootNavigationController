//
//  MyAppAppearance.swift
//  YDRootNavigationController _Example
//
//  Created by One on 2024/3/14.
//  Copyright © 2024 jsone All rights reserved.
//

import UIKit

class MyAppAppearance: YDAppAppearanceProtocol {
//    var navigationBarBackgroundColor: UIColor? { .randomColor }
    var navigationBarShadowColor: UIColor? { .clear }
    var navigationBarBackgroundImage: UIImage? { UIImage.gradient(colors: [UIColor.red, UIColor.blue], type: .leftToRight, size: CGSize(width: Screen.width, height: Screen.navigationBarHeight))?.addCorner(YDRectCorner(bottomRight: 20))}
    var titleTextAttributes: [NSAttributedString.Key : Any]? { [NSAttributedString.Key.foregroundColor: UIColor.white] }
    var backItemImage: UIImage? { UIImage(named: "nav_back_white_button") }
    var backItemImageInsets: UIEdgeInsets? { UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 0) }
}
