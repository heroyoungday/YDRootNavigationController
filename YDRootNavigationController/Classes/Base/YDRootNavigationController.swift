//
//  YDRootNavigationController .swift
//  YDRootNavigationController 
//
//  Created by One on 2022/10/31.
//

import UIKit

open class YDRootNavigationController: UINavigationController {
    /// 全局默认设置
    static var appAppearance: YDAppAppearanceProtocol = YDAppAppearance()
    private let kBackItemTag = 1000
    /// 供外部设置实现delegate
    private weak var _delegate: UINavigationControllerDelegate?
    
    lazy var fullScreenPopGestureRecognizer: UIPanGestureRecognizer = {
        let gestureRecognizer = UIPanGestureRecognizer()
        gestureRecognizer.maximumNumberOfTouches = 1
        gestureRecognizer.delegate = self
        return gestureRecognizer
    }()
    
    override public var delegate: UINavigationControllerDelegate? {
        get { super.delegate }
        set { _delegate = newValue }
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override public init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        commonInit()
    }
    
    override public init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        commonInit()
    }
    
    private func commonInit() {
        super.delegate = self
        
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let topViewController = self.topViewController else { return }
        setNavigationBarHidden(topViewController.prefersNavigationBarHidden, animated: animated)
    }
    
    override open var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
    
    override open var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    /// 黑色
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = viewController.isHidesBottomBarWhenPushed
        }
        super.pushViewController(viewController, animated: true)
    }
    
    override open func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        if let vc = viewControllers.last, viewControllers.count > 1 {
            vc.hidesBottomBarWhenPushed = vc.isHidesBottomBarWhenPushed
        }
        super.setViewControllers(viewControllers, animated: animated)
    }
    // MARK: - Private
    func getBackItem(_ vc: UIViewController) -> UIBarButtonItem? {
        var backItem: UIBarButtonItem?
        if let customItem = vc.backItem {
            backItem = customItem
        } else {
            let backItemType = vc.backItemType
            switch backItemType.style {
            case .default:
                setDefaultBackItem()
            case .title(let title, let titleTextAttributes):
                let backBarItem = UIBarButtonItem(title: title, style: .plain, target: vc, action: #selector(backItemAction(_:)))
                backBarItem.setTitleTextAttributes(titleTextAttributes, for: .normal)
                backItem = backBarItem
            case .image(let image, let imageInsets, let tintColor):
                if let backImage = image {
                    let backBarItem = UIBarButtonItem(image: backImage, style: .plain, target: vc, action: #selector(backItemAction(_:)))
                    if let tintColor = tintColor {
                        backBarItem.tintColor = tintColor
                    }
                    backBarItem.imageInsets = imageInsets
                    backItem = backBarItem
                } else {
                    setDefaultBackItem()
                }
            case .all(let title, let titleTextAttributes, let image, let imageInsets):
                let backButton = UIButton(type: .roundedRect)
                let attributedTitle = NSMutableAttributedString(string: title ?? "", attributes: titleTextAttributes)
                var backImage = Self.appAppearance.backItemImage
                if let image = image { backImage = image }
                if let image = backImage {
                    let attach = NSTextAttachment()
                    attach.image = image
                    attach.bounds = CGRect(x: 0, y: -6, width: image.size.width, height: image.size.height)
                    let attributedImage = NSAttributedString(attachment: attach)
                    attributedTitle.insert(attributedImage, at: 0)
                }
                backButton.setAttributedTitle(attributedTitle, for: .normal)
                backButton.contentEdgeInsets = imageInsets ?? UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
                backButton.addTarget(vc, action: #selector(backItemAction(_:)), for: .touchUpInside)
                let backBarItem = UIBarButtonItem(customView: backButton)
                backItem = backBarItem
            }
            
            func setDefaultBackItem() {
                guard let image = Self.appAppearance.backItemImage else { return }
                let backButton = UIButton(type: .roundedRect)
                backButton.setImage(image, for: .normal)
                backButton.frame = CGRect(x: 0, y: 0, width: 24, height: 44)
                backButton.imageEdgeInsets = Self.appAppearance.backItemImageInsets ?? .zero
                backButton.addTarget(vc, action: #selector(backItemAction(_:)), for: .touchUpInside)
                let backBarItem = UIBarButtonItem(customView: backButton)
                backItem = backBarItem
            }
        }
        return backItem
    }
    // MARK: - Public
    /// 设置侧滑返回手势是否开启（用于控制器显示后动态设置）
    /// - Parameter enable: 是否开启
    func setInteractivePopGesture(_ isEnabled: Bool) {
        if viewControllers.count > 1 {
            if let popGestureRecognizer = interactivePopGestureRecognizer {
                popGestureRecognizer.isEnabled = isEnabled
                if isEnabled {
                    popGestureRecognizer.delegate = self
                }
            }
        } else {
            interactivePopGestureRecognizer?.delegate = nil
            interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    func setFullScreenPopGesture(_ isEnabled: Bool) {
        if viewControllers.count > 1 {
            if isEnabled {
                if let gestureRecognizers = interactivePopGestureRecognizer?.view?.gestureRecognizers {
                    if !gestureRecognizers.contains(fullScreenPopGestureRecognizer) {
                        if let targets = self.interactivePopGestureRecognizer?.value(forKey: "targets") as? [AnyObject], let target = targets.first?.value(forKey: "target") {
                            let action = NSSelectorFromString("handleNavigationTransition:")
                            interactivePopGestureRecognizer?.view?.addGestureRecognizer(fullScreenPopGestureRecognizer)
                            fullScreenPopGestureRecognizer.addTarget(target, action: action)
                        }
                    }
                }
                setInteractivePopGesture(false)
            }
            fullScreenPopGestureRecognizer.isEnabled = isEnabled
        } else {
            fullScreenPopGestureRecognizer.isEnabled = false
        }
    }
}

extension YDRootNavigationController: UINavigationControllerDelegate {
    
    open func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        _delegate?.navigationController?(navigationController, willShow: viewController, animated: animated)
        setNavigationBarHidden(viewController.prefersNavigationBarHidden, animated: animated)
        setNavigationBarAppearence(viewController)
        var leftBarButtonItems = viewController.navigationItem.leftBarButtonItems?.filter { $0.tag != kBackItemTag } ?? []
        if viewControllers.count > 1 && !viewController.isHidesBackItem {
            if let backBarItem = getBackItem(viewController) {
                backBarItem.tag = kBackItemTag
                leftBarButtonItems.insert(backBarItem, at: 0)
                viewController.navigationItem.leftBarButtonItems = leftBarButtonItems
            }
        } else {
            viewController.navigationItem.hidesBackButton = true
        }
        
        if let coordinator = topViewController?.transitionCoordinator {
            if #available(iOS 10.0, *) {
                coordinator.notifyWhenInteractionChanges { [weak self] (context) in
                    guard let `self` = self, context.isCancelled, let fromViewController = context.viewController(forKey: .from) else { return }
                    self.setNavigationBarAppearence(fromViewController)
                }
            } else {
                coordinator.notifyWhenInteractionEnds { [weak self] (context) in
                    guard let `self` = self, context.isCancelled, let fromViewController = context.viewController(forKey: .from) else { return }
                    self.setNavigationBarAppearence(fromViewController)
                }
            }
        }
    }
    
    open func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        _delegate?.navigationController?(navigationController, didShow: viewController, animated: animated)
        if navigationBar.isHidden != viewController.prefersNavigationBarHidden {
            navigationBar.isHidden = viewController.prefersNavigationBarHidden
        }
        if viewControllers.count <= 1 {
            fullScreenPopGestureRecognizer.isEnabled = false
            interactivePopGestureRecognizer?.isEnabled = false
        } else {
            if viewController.isFullScreenPopGestureEnabled {
                if let gestureRecognizers = interactivePopGestureRecognizer?.view?.gestureRecognizers {
                    if !gestureRecognizers.contains(fullScreenPopGestureRecognizer) {
                        if let targets = self.interactivePopGestureRecognizer?.value(forKey: "targets") as? [AnyObject], let target = targets.first?.value(forKey: "target") {
                            let action = NSSelectorFromString("handleNavigationTransition:")
                            interactivePopGestureRecognizer?.view?.addGestureRecognizer(fullScreenPopGestureRecognizer)
                            fullScreenPopGestureRecognizer.addTarget(target, action: action)
                        }
                    }
                }
                fullScreenPopGestureRecognizer.isEnabled = true
                setInteractivePopGesture(false)
            } else {
                fullScreenPopGestureRecognizer.isEnabled = false
                setInteractivePopGesture(viewController.isInteractivePopGestureEnabled)
            }
        }
    }
    
    open func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        _delegate?.navigationController?(navigationController, interactionControllerFor: animationController)
    }
    
    open func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        _delegate?.navigationController?(navigationController, animationControllerFor: operation, from: fromVC, to: toVC)
    }
    
//    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
//        _delegate?.navigationControllerSupportedInterfaceOrientations(navigationController)
//    }
//
//    func navigationControllerPreferredInterfaceOrientationForPresentation(_ navigationController: UINavigationController) -> UIInterfaceOrientation {
//        _delegate?.navigationControllerPreferredInterfaceOrientationForPresentation(navigationController)
//    }
}

extension YDRootNavigationController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == fullScreenPopGestureRecognizer {
            let isLeftToRight = fullScreenPopGestureRecognizer.translation(in: gestureRecognizer.view).x >= 0
            if isLeftToRight {
                return false
            }
        }
        return gestureRecognizer == interactivePopGestureRecognizer
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        gestureRecognizer == interactivePopGestureRecognizer
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let gestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer, gestureRecognizer == fullScreenPopGestureRecognizer else {
            return gestureRecognizer == interactivePopGestureRecognizer
        }
        if viewControllers.count <= 1 {
            return false
        }
        if let _isTransitioning = value(forKey: "_isTransitioning") as? Bool, _isTransitioning {
            return false
        }
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!)
        let isLeftToRight = UIApplication.shared.userInterfaceLayoutDirection == .leftToRight
        let multiplier: CGFloat = isLeftToRight ? 1 : -1;
        if translation.x * multiplier <= 0 {
            return false
        }
        return true
    }
}


public extension UIViewController {
    func setNavigationBar(_ backgroundColor: UIColor? = nil, titleTextAttributes: [NSAttributedString.Key: Any]? = nil, shadowColor: UIColor? = nil) {
        navigationController?.navigationBar.setAppearence(YDNavigationBarAppearence(backgroundColor: backgroundColor, titleTextAttributes: titleTextAttributes, shadowColor: shadowColor))
    }
    
    func updateNavigationBarAppearence(_ appearence: YDNavigationBarAppearence? = nil) {
        let navBarApp = appearence ?? navigationBarAppearence
        navigationController?.navigationBar.setAppearence(navBarApp)
    }
}

public extension UINavigationController {
    func setNavigationBarAppearence(_ vc: UIViewController) {
        guard !vc.prefersNavigationBarHidden else { return }
        if vc.navigationBarAppearence.backgroundColor == .clear {
            vc.extendedLayoutIncludesOpaqueBars = true
        }
        navigationBar.setAppearence(vc.navigationBarAppearence)
    }
}


public extension UINavigationBar {
    
    /// 设置导航栏样式
    /// - Parameters:
    ///   - appearence: 导航栏样式数据模型
    ///   - needDefault: 是否未传值的类型使用默认设置
    func setAppearence(_ appearence: YDNavigationBarAppearence, needDefault: Bool = true) {
        if #available(iOS 13.0, *) {
            let navApp = (needDefault ? UINavigationBar.appearance() : self).standardAppearance.copy()
            if let backgroundImage = appearence.backgroundImage {
                navApp.backgroundImage = backgroundImage
            } else if let backgroundColor = appearence.backgroundColor {
                navApp.backgroundColor = backgroundColor
                navApp.backgroundImage = nil
            }
            if let titleTextAttributes = appearence.titleTextAttributes {
                navApp.titleTextAttributes = titleTextAttributes
            }
            if let shadowColor = appearence.shadowColor {
                navApp.shadowColor = shadowColor
            }
            barTintColor = navApp.backgroundColor
            standardAppearance = navApp
            scrollEdgeAppearance = navApp
            compactAppearance = navApp
        } else {
            if let textAttributes = appearence.titleTextAttributes {
                titleTextAttributes = textAttributes
            } else {
                titleTextAttributes = YDRootNavigationController.appAppearance.titleTextAttributes
            }
            if let shadowColor = appearence.shadowColor {
                shadowImage = shadowColor.image()
            } else if let navigationBarShadowColor = YDRootNavigationController.appAppearance.navigationBarShadowColor {
                shadowImage = navigationBarShadowColor.image()
            } else {
                shadowImage = UINavigationBar.appearance().shadowImage
            }
            if let backgroundImage = appearence.backgroundImage {
                setBackgroundImage(backgroundImage, for: .default)
            } else if let backgroundColor = appearence.backgroundColor {
                if backgroundColor == .clear {
                    isTranslucent = true
                    setBackgroundImage(UIImage(), for: .default)
                } else {
                    barTintColor = backgroundColor
                }
            } else if let backgroundColor = YDRootNavigationController.appAppearance.navigationBarBackgroundColor {
                barTintColor = backgroundColor
            } else {
                barTintColor = UINavigationBar.appearance().barTintColor
            }
        }
    }
}
