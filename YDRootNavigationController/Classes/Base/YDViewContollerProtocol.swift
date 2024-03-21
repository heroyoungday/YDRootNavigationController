//
//  YDViewContollerProtocol.swift
//  YDRootNavigationController 
//
//  Created by One on 2024/3/8.
//

import UIKit

@objc public protocol YDViewControllerProtocol {
    var isHidesBackItem: Bool { get }
    var prefersNavigationBarHidden: Bool { get }
    var isHidesBottomBarWhenPushed: Bool { get }
    /// 设置侧滑返回手势是否开启（用于控制器显示前的默认设置）
    var isInteractivePopGestureEnabled: Bool { get }
    /// 设置全屏返回手势是否开启（用于控制器显示前的默认设置）
    var isFullScreenPopGestureEnabled: Bool { get }
    var backItem: UIBarButtonItem? { get }
    var backItemType: YDBackItemType { get }
    var navigationBarAppearence: YDNavigationBarAppearence { get }
    @objc func backItemAction(_ sender: Any?)
}

extension UIViewController: YDViewControllerProtocol {
    open var isHidesBackItem: Bool { YDRootNavigationController.appAppearance.isHidesBackItem }
    open var prefersNavigationBarHidden: Bool { YDRootNavigationController.appAppearance.prefersNavigationBarHidden }
    open var isHidesBottomBarWhenPushed: Bool { YDRootNavigationController.appAppearance.isHidesBottomBarWhenPushed }
    open var isInteractivePopGestureEnabled: Bool { YDRootNavigationController.appAppearance.isInteractivePopGestureEnabled }
    open var isFullScreenPopGestureEnabled: Bool { YDRootNavigationController.appAppearance.isFullScreenPopGestureEnabled }
    open var backItem: UIBarButtonItem? { nil }
    open var backItemType: YDBackItemType { .default() }
    open var navigationBarAppearence: YDNavigationBarAppearence {
        YDNavigationBarAppearence()
    }

    @objc open func backItemAction(_ sender: Any?) {
        navigationController?.popViewController(animated: true)
    }
    
    /// 设置侧滑返回手势是否开启（用于控制器显示后动态设置）
    /// - Parameter enable: 是否开启
    public func interactivePopGesture(_ isEnabled: Bool) {
        guard let navigationController = self.navigationController as? YDRootNavigationController else { return }
        navigationController.setInteractivePopGesture(isEnabled)
    }
    
    /// 设置全屏返回手势是否开启（用于控制器显示后动态设置）
    /// - Parameter enable: 是否开启
    public func fullScreenPopGesture(_ isEnabled: Bool) {
        guard let navigationController = self.navigationController as? YDRootNavigationController else { return }
        navigationController.setFullScreenPopGesture(isEnabled)
    }
}

public extension UINavigationController {
    
    /// 推进控制器是否替换替换当前控制器
    /// - Parameters:
    ///   - viewController: 推进的控制器
    ///   - animated: 是否加动画
    ///   - replace: 是否替换当前控制器
    func pushViewController(_ viewController: UIViewController, animated: Bool, replace: Bool) {
        if replace {
            var vcs: [UIViewController] = []
            for vc in viewControllers.dropLast() {
                vcs.append(vc)
            }
            vcs.append(viewController)
            setViewControllers(vcs, animated: animated)
        } else {
            pushViewController(viewController, animated: animated)
        }
    }
}

public class YDNavigationBarAppearence: NSObject {
    /// 导航栏背景颜色，如果使用全局默认则不传
    private(set) var backgroundColor: UIColor?
    /// 导航栏背景图片，如果使用全局默认则不传
    private(set) var backgroundImage: UIImage?
    /// 导航栏阴影（即底部分割线）颜色，如果使用全局默认则不传
    private(set) var shadowColor: UIColor?
    /// 导航栏标题样式，如果使用全局默认样式则不传
    private(set) var titleTextAttributes: [NSAttributedString.Key: Any]?
    
    /// 初始化方法
    /// - Parameters:
    ///   - backgroundColor: 导航栏背景颜色，如果使用全局默认则不传
    ///   - backgroundImage: 导航栏背景图片，如果使用全局默认则不传
    ///   - titleTextAttributes: 导航栏标题样式，如果使用全局默认样式则不传
    ///   - shadowColor: 导航栏阴影（即底部分割线）颜色，如果使用全局默认则不传
    public init(backgroundColor: UIColor? = nil, backgroundImage: UIImage? = nil, titleTextAttributes: [NSAttributedString.Key: Any]? = nil, shadowColor: UIColor? = nil) {
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.titleTextAttributes = titleTextAttributes
        self.shadowColor = shadowColor
    }
}

public class YDBackItemType: NSObject {
    public enum YDBackItemStyle {
        case `default` // 系统自带的返回按钮（system backItem）
        case title(String?, [NSAttributedString.Key: Any]?)
        case image(UIImage?, UIEdgeInsets, UIColor?)
        case all(String?, [NSAttributedString.Key: Any]?, UIImage?, UIEdgeInsets?)
    }
    public private(set) var style: YDBackItemStyle
    
    private init(style: YDBackItemStyle = .default) {
        self.style = style
    }
    
    public static func `default`() -> YDBackItemType {
        YDBackItemType()
    }
    
    public static func title(_ title: String?, titleTextAttributes: [NSAttributedString.Key: Any]? = nil) -> YDBackItemType {
        YDBackItemType(style: .title(title, titleTextAttributes))
    }
    
    public static func image(_ image: UIImage?, imageInsets: UIEdgeInsets = .zero, tintColor: UIColor? = nil) -> YDBackItemType {
        YDBackItemType(style: .image(image, imageInsets, tintColor))
    }
    
    public static func all(_ title: String? = nil, titleTextAttributes: [NSAttributedString.Key: Any]? = nil, image: UIImage? = nil, contentInsets: UIEdgeInsets? = nil) -> YDBackItemType {
        YDBackItemType(style: .all(title, titleTextAttributes, image, contentInsets))
    }
}


public extension UIColor {
    /// 返回随机颜色
    static var randomColor: UIColor {
        let red = CGFloat(arc4random() % 256 ) / 255.0
        let green = CGFloat(arc4random() % 256) / 255.0
        let blue = CGFloat(arc4random() % 256) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func image(_ size: CGSize = CGSize(width: 1, height: 1), opaque: Bool = false) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, opaque, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
