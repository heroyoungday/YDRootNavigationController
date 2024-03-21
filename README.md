# YDRootNavigationController

[![CI Status](https://img.shields.io/travis/heroyoungday/YDRootNavigationController.svg?style=flat)](https://travis-ci.org/heroyoungday/YDRootNavigationController)
[![Version](https://img.shields.io/cocoapods/v/YDRootNavigationController.svg?style=flat)](https://cocoapods.org/pods/YDRootNavigationController)
[![License](https://img.shields.io/cocoapods/l/YDRootNavigationController.svg?style=flat)](https://cocoapods.org/pods/YDRootNavigationController)
[![Platform](https://img.shields.io/cocoapods/p/YDRootNavigationController.svg?style=flat)](https://cocoapods.org/pods/YDRootNavigationController)

## Overview

* Supports setting a globally unified default navigation bar style (for example: backgroundColor, shadowColor, title textAttributes), and supports each view controller to customize the navigation bar style.
* Support global default settings to enable the system's own pop gesture, and support the view controller's own default settings and dynamic settings.
* Support global default setting whether to enable full-screen pop gesture, and support the view controller's own default setting and dynamic setting.
* Support global default settings for whether to display the backBarItem, as well as support for the view controller's own default settings and dynamic settings.
* Support global default settings for whether to display the navigation bar, and support the view controller's own default settings and dynamic settings.
* Support global default settings for whether to display the tab bar, and support the view controller's own default settings and dynamic settings.
* Support setting status bar style and showing hidden status.
* Support custom backBarItem.
* Support customizing the click event of the backBarItem.
* Support `Interface Builder`.



* 支持设置全局统一默认的导航栏样式（例如：导航栏背景颜色、底部分割线颜色、标题文字属性），同时支持每个视图控制器可以自定义导航栏样式
* 支持全局默认设置是否开启系统自带的返回手势，同时支持视图控制器自己默认设置和动态设置
* 支持全局默认设置是否开启全屏返回手势，同时支持视图控制器自己默认设置和动态设置
* 支持全局默认设置是否显示返回按钮，同时支持视图控制器自己默认设置和动态设置
* 支持全局默认设置是否显示导航栏，同时支持视图控制器自己默认设置和动态设置
* 支持全局默认设置是否显示标签栏，同时支持视图控制器自己默认设置和动态设置
* 支持设置状态栏样式和显示隐藏状态
* 支持自定义返回按钮
* 支持自定义返回按钮的点击事件
* 支持`Interface Builder`

## Requirements

* **iOS 12** and up
  
## Installation

YDRootNavigationController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'YDRootNavigationController'
```
## Usage
```swift
class ViewController: UIViewController {
    override var isInteractivePopGestureEnabled: Bool { false }
}
```
![scrreecap](./ScreenShot/返回手势.gif)


## Author

jsone, heroyoungday@gmail.com

## License

YDRootNavigationController is available under the MIT license. See the LICENSE file for more info.
