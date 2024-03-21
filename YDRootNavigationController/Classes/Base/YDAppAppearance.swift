//
//  YDAppAppearance.swift
//  YDRootNavigationController 
//
//  Created by One on 2024/3/14.
//

import UIKit

/// 全局默认配置
public protocol YDAppAppearanceProtocol {
    var barItemNormalTitleTextAttributes: [NSAttributedString.Key : Any]? { get }
    var barItemHighlightedTitleTextAttributes: [NSAttributedString.Key : Any]? { get }
    var barItemDisableTitleTextAttributes: [NSAttributedString.Key : Any]? { get }
    /// 导航栏标题文字属性
    var titleTextAttributes: [NSAttributedString.Key: Any]? { get }
    /// 导航栏背景颜色
    var navigationBarBackgroundColor: UIColor? { get }
    /// 导航栏背景图片
    var navigationBarBackgroundImage: UIImage? { get }
    var navigationBarShadowColor: UIColor? { get }
    /// 工具栏背景颜色
    var toolBarBackgroundColor: UIColor? { get }
    var toolBarShadowColor: UIColor? { get }
    var tabBarBackgroundColor: UIColor? { get }
    var tabBarShadowColor: UIColor? { get }
    /// 返回按钮图片
    var backItemImage: UIImage? { get }
    /// 返回按钮图片内边距
    var backItemImageInsets: UIEdgeInsets? { get }
    var isHidesBackItem: Bool { get }
    /// 设置是否隐藏导航栏（默认关闭）
    var prefersNavigationBarHidden: Bool { get }
    /// （默认打开）设置导航栏控制器push时，是否隐藏标签栏（当导航栏控制器是标签栏控制器的子控制器时）
    var isHidesBottomBarWhenPushed: Bool { get }
    /// 设置侧滑返回手势是否开启（默认打开）
    var isInteractivePopGestureEnabled: Bool { get }
    /// 设置全屏返回手势是否开启（默认关闭）
    var isFullScreenPopGestureEnabled: Bool { get }
}

public extension YDAppAppearanceProtocol {
    var barItemNormalTitleTextAttributes: [NSAttributedString.Key : Any]? { nil }
    var barItemHighlightedTitleTextAttributes: [NSAttributedString.Key : Any]? { nil }
    var barItemDisableTitleTextAttributes: [NSAttributedString.Key : Any]? { nil }
    var titleTextAttributes: [NSAttributedString.Key: Any]? { nil }
    var navigationBarBackgroundColor: UIColor? { nil }
    var navigationBarBackgroundImage: UIImage? { nil }
    var navigationBarShadowColor: UIColor? { nil }
    var toolBarBackgroundColor: UIColor? { nil }
    var toolBarShadowColor: UIColor? { nil }
    var tabBarBackgroundColor: UIColor? { nil }
    var tabBarShadowColor: UIColor? { nil }
    var backItemImage: UIImage? { nil }
    var backItemImageInsets: UIEdgeInsets? { nil }
    var isHidesBackItem: Bool { false }
    var prefersNavigationBarHidden: Bool { false }
    var isHidesBottomBarWhenPushed: Bool { true }
    var isInteractivePopGestureEnabled: Bool { true }
    var isFullScreenPopGestureEnabled: Bool { false }
    
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
            if let navigationBarBackgroundImage = self.navigationBarBackgroundImage {// 设置背景图片
                navBarApp.backgroundImage = navigationBarBackgroundImage
                navBarApp.backgroundColor = .clear
            } else if let navigationBarBackgroundColor = self.navigationBarBackgroundColor {// 设置背景颜色
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
            if let navigationBarBackgroundImage = self.navigationBarBackgroundImage {
                UINavigationBar.appearance().setBackgroundImage(navigationBarBackgroundImage, for: .default)
                UINavigationBar.appearance().backgroundColor = .clear
            } else if let navigationBarBackgroundColor = self.navigationBarBackgroundColor {
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
