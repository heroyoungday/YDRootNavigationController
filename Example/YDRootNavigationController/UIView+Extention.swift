//
//  UIView+Extention.swift
//  YDRootNavigationController
//
//  Created by One on 2024/3/20.
//

import UIKit

public extension UIView {
    func addCorner(_ corners: YDRectCorner, frame: CGRect? = nil, borderWidth: CGFloat? = nil, borderColor: UIColor? = nil) {
        let rect: CGRect = frame ?? self.bounds
        // 绘制路径
        let path = CGMutablePath()
        let topLeftRadius = corners.topLeft
        let topLeftCenter = CGPoint(x: rect.minX + topLeftRadius, y: rect.minY + topLeftRadius)
        path.addArc(center: topLeftCenter, radius: topLeftRadius, startAngle: Double.pi, endAngle: Double.pi * 1.5, clockwise: false)
        let topRightRadius = corners.topRight
        let topRightCenter = CGPoint(x: rect.maxX - topRightRadius, y: rect.minY + topRightRadius)
        path.addArc(center: topRightCenter, radius: topRightRadius, startAngle: Double.pi * 1.5, endAngle: Double.pi * 2, clockwise: false)
        let bottomRightRadius = max(corners.bottomRight, 0)
        let bottomRightCenter = CGPoint(x: rect.maxX - bottomRightRadius, y: rect.maxY - bottomRightRadius)
        path.addArc(center: bottomRightCenter, radius: bottomRightRadius, startAngle: 0, endAngle: Double.pi * 0.5, clockwise: false)
        let bottomLeftRadius = max(corners.bottomLeft, 0)
        let bottomLeftCenter = CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY - bottomLeftRadius)
        path.addArc(center: bottomLeftCenter, radius: bottomLeftRadius, startAngle: Double.pi * 0.5, endAngle: Double.pi, clockwise: false)
        path.closeSubpath()
        // 给layer添加遮罩
        let layer = CAShapeLayer()
        layer.path = path
        self.layer.mask = layer
        
        if let borderWidth = borderWidth, let borderColor = borderColor {
            // 添加边框
            let borderLayer = CAShapeLayer()
            borderLayer.frame = rect
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.path = path
            borderLayer.lineWidth = borderWidth
            borderLayer.strokeColor = borderColor.cgColor
            self.layer.addSublayer(borderLayer)
        }
//        let shadowLayer = CALayer()
//        shadowLayer.frame = self.frame
//        shadowLayer.shadowColor = UIColor.black.cgColor
//        shadowLayer.shadowRadius = 3
//        shadowLayer.masksToBounds = false
//        shadowLayer.shadowPath = path
//        shadowLayer.shadowOffset = .zero
//        shadowLayer.shadowOpacity = 1
//        self.superview?.layer.insertSublayer(shadowLayer, at: 0)
    }
}

public struct YDRectCorner {
    public var topLeft: CGFloat
    public var topRight: CGFloat
    public var bottomLeft: CGFloat
    public var bottomRight: CGFloat
    // 创建四个角不同半径大小的圆角结构体
    public init(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
    }
    // 创建四个角相同半径大小的圆角结构体
    public init(all cornerRadius: CGFloat) {
        self.init(topLeft: cornerRadius, topRight: cornerRadius, bottomLeft: cornerRadius, bottomRight: cornerRadius)
    }
    
    public init(left: CGFloat = 0, right: CGFloat = 0) {
        self.init(topLeft: left, topRight: right, bottomLeft: left, bottomRight: right)
    }
    
    public init(top: CGFloat = 0, bottom: CGFloat = 0) {
        self.init(topLeft: top, topRight: top, bottomLeft: bottom, bottomRight: bottom)
    }
    
    public init(horizontal: CGFloat) {
        self.init(left: horizontal, right: horizontal)
    }
    
    public init(vertical: CGFloat) {
        self.init(top: vertical, bottom: vertical)
    }
}

public extension UIApplication {
    static var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            let window = key
            if #available(iOS 16.0, *) {
                return window?.safeAreaInsets.top ?? 0
            }
            return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
    static var key: UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.first
        }else {
            return UIApplication.shared.keyWindow
        }
    }
    static var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return key?.safeAreaInsets ?? .zero
        } else {
            return .zero
        }
    }
}

public struct Screen {
    public static let width: CGFloat = UIScreen.main.bounds.width
    public static let height: CGFloat = UIScreen.main.bounds.height
    /// 电池栏高度
    public static let statusBarHeight: CGFloat = UIApplication.statusBarHeight
    /// 导航栏高度
    public static let navigationBarHeight: CGFloat = UIApplication.statusBarHeight + 44
    public static let safeAreaInsets: UIEdgeInsets = UIApplication.safeAreaInsets
    public static let safeAreaInsetsTop: CGFloat = UIApplication.safeAreaInsets.top
    public static let safeAreaInsetsBottom: CGFloat = UIApplication.safeAreaInsets.bottom
}
