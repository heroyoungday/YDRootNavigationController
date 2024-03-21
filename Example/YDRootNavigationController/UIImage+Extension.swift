//
//  UIImage+Extension.swift
//  YDRootNavigationController
//
//  Created by One on 2024/3/20.
//

import UIKit

public enum YDGradientType {
    case topToBottom
    case leftToRight
    case topLeftToBottomRight
    case topRightToBottomLeft
}

public extension UIImage {
    static func gradient(colors: [UIColor], type: YDGradientType, size: CGSize) -> UIImage? {

        defer {
            UIGraphicsEndImageContext()
        }
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        guard let context = UIGraphicsGetCurrentContext(), !colors.isEmpty else { return nil }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors.map { $0.cgColor} as CFArray, locations: nil)!
        var start: CGPoint
        var end: CGPoint
        switch (type) {
        case .topToBottom:
            start = CGPoint(x: 0.0, y: 0.0)
            end = CGPoint(x: 0.0, y: size.height)
        case .leftToRight:
            start = CGPoint(x: 0.0, y: 0.0)
            end = CGPoint(x: size.width, y: 0.0)
        case .topLeftToBottomRight:
            start = CGPoint(x: 0.0, y: 0.0)
            end = CGPoint(x: size.width, y: size.height)
        case .topRightToBottomLeft:
            start = CGPoint(x: size.width, y: 0.0)
            end = CGPoint(x: 0.0, y: size.height)
        }
        context.drawLinearGradient(gradient, start: start, end: end, options: [])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    
    func addCorner(_ corners: YDRectCorner) -> UIImage? {
        let rect: CGRect = CGRect(origin: .zero, size: size)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        let context = UIGraphicsGetCurrentContext()
        
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
        
        context?.addPath(path)
        context?.clip()
        
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image

    }
    
    func addCorner(size:CGSize) -> UIImage? {
        //开启上下文
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        //赛贝尔路径裁剪
        let path = UIBezierPath.init(ovalIn: rect)
        path.addClip()
        self.draw(in: rect)
        
        //获取结果
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        return resultImage
        }
}
