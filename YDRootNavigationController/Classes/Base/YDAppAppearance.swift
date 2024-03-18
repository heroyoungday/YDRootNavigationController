//
//  YDAppAppearance.swift
//  YDRootNavigationController 
//
//  Created by One on 2024/3/14.
//

import UIKit

public protocol YDAppAppearanceProtocol {
    var barItemNormalTitleTextAttributes: [NSAttributedString.Key : Any]? { get }
    var barItemHighlightedTitleTextAttributes: [NSAttributedString.Key : Any]? { get }
    var barItemDisableTitleTextAttributes: [NSAttributedString.Key : Any]? { get }
    var titleTextAttributes: [NSAttributedString.Key: Any]? { get }
    var navigationBarBackgroundColor: UIColor? { get }
    var navigationBarShadowColor: UIColor? { get }
    var toolBarBackgroundColor: UIColor? { get }
    var toolBarShadowColor: UIColor? { get }
    var tabBarBackgroundColor: UIColor? { get }
    var tabBarShadowColor: UIColor? { get }
    var backItemImage: UIImage? { get }
    var backItemImageInsets: UIEdgeInsets? { get }
}

public extension YDAppAppearanceProtocol {
    var barItemNormalTitleTextAttributes: [NSAttributedString.Key : Any]? { nil }
    var barItemHighlightedTitleTextAttributes: [NSAttributedString.Key : Any]? { nil }
    var barItemDisableTitleTextAttributes: [NSAttributedString.Key : Any]? { nil }
    var titleTextAttributes: [NSAttributedString.Key: Any]? { nil }
    var navigationBarBackgroundColor: UIColor? { nil }
    var navigationBarShadowColor: UIColor? { nil }
    var toolBarBackgroundColor: UIColor? { nil }
    var toolBarShadowColor: UIColor? { nil }
    var tabBarBackgroundColor: UIColor? { nil }
    var tabBarShadowColor: UIColor? { nil }
    var backItemImage: UIImage? { nil }
    var backItemImageInsets: UIEdgeInsets? { nil }
    
    
    func configure() {
        YDRootNavigationController.appAppearance = self
        // setup appearance
        if let barItemNormalTitleTextAttributes = self.barItemNormalTitleTextAttributes {
            UIBarButtonItem.appearance().setTitleTextAttributes(barItemNormalTitleTextAttributes, for: .normal)
            barItemNormalTitleTextAttributes.forEach { (key: NSAttributedString.Key, value: Any) in
                if key == .font {
                    UIBarButtonItem.appearance().setTitleTextAttributes([key: value], for: .highlighted)
                    UIBarButtonItem.appearance().setTitleTextAttributes([key: value], for: .disabled)
                }
            }
        }
        
        if let barItemHighlightedTitleTextAttributes = self.barItemHighlightedTitleTextAttributes {
            UIBarButtonItem.appearance().setTitleTextAttributes(barItemHighlightedTitleTextAttributes, for: .highlighted)
        }
        
        if let barItemDisableTitleTextAttributes = self.barItemDisableTitleTextAttributes {
            UIBarButtonItem.appearance().setTitleTextAttributes(barItemDisableTitleTextAttributes, for: .disabled)
        }
        if #available(iOS 13.0, *) {
            let navBarApp = UINavigationBarAppearance()
            // 移除毛玻璃效果
            navBarApp.configureWithOpaqueBackground()
            // 设置背景颜色
            if let navigationBarBackgroundColor = self.navigationBarBackgroundColor {
                navBarApp.backgroundColor = navigationBarBackgroundColor
            }
            
            if let titleTextAttributes = self.titleTextAttributes {
                navBarApp.titleTextAttributes = titleTextAttributes
            }
            
            // 设置分割线颜色
            if let navigationBarShadowColor = self.navigationBarShadowColor {
                navBarApp.shadowColor = navigationBarShadowColor
            }
            
            if let image = self.backItemImage {
                navBarApp.setBackIndicatorImage(image, transitionMaskImage: image)
            }
            
            UINavigationBar.appearance().scrollEdgeAppearance = navBarApp
            UINavigationBar.appearance().compactAppearance = navBarApp
            UINavigationBar.appearance().standardAppearance = navBarApp
            let tabBarApp = UITabBarAppearance()
            // 移除毛玻璃效果
            tabBarApp.configureWithOpaqueBackground()
            
            if let tabBarShadowColor = self.tabBarShadowColor {
                tabBarApp.shadowColor = tabBarShadowColor
            }
            
            if let tabBarBackgroundColor = self.tabBarBackgroundColor {
                tabBarApp.backgroundColor = tabBarBackgroundColor
            }
            
            UITabBar.appearance().standardAppearance = tabBarApp
            
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarApp
                UITableView.appearance().sectionHeaderTopPadding = 0
                let toolBarApp = UIToolbarAppearance()
                // 移除毛玻璃效果
                toolBarApp.configureWithOpaqueBackground()
                
                if let toolBarBackgroundColor = self.toolBarBackgroundColor {
                    toolBarApp.backgroundColor = toolBarBackgroundColor
                }
                
                if let toolBarShadowColor = self.toolBarShadowColor {
                    toolBarApp.shadowColor = toolBarShadowColor
                }
                
                UIToolbar.appearance().scrollEdgeAppearance = toolBarApp
            } else {
                // Fallback on earlier versions
            }
        } else {
            if let navigationBarBackgroundColor = self.navigationBarBackgroundColor {
                UINavigationBar.appearance().barTintColor = navigationBarBackgroundColor
            }
            
            if let image = self.backItemImage {
                UINavigationBar.appearance().backIndicatorImage = image
                UINavigationBar.appearance().backIndicatorTransitionMaskImage = image
            }
            
            if let navigationBarShadowColor = self.navigationBarShadowColor {
                UINavigationBar.appearance().shadowImage = navigationBarShadowColor.image()
            }
            
            if let titleTextAttributes = self.titleTextAttributes {
                UINavigationBar.appearance().titleTextAttributes = titleTextAttributes
            }
            
            if let tabBarBackgroundColor = self.tabBarBackgroundColor {
                UITabBar.appearance().barTintColor = tabBarBackgroundColor
            }
            
            if let tabBarShadowColor = self.tabBarShadowColor {
                UITabBar.appearance().shadowImage = tabBarShadowColor.image()
            }
        }
    }
}

public class YDAppAppearance: YDAppAppearanceProtocol {
    
    init() {}
}
