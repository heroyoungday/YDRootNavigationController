#
# Be sure to run `pod lib lint YDRootNavigationController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YDRootNavigationController'
  s.version          = '0.1.1'
  s.summary          = 'Supports setting the global default navigation bar style, and supports each view controller to have its own navigation bar style.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  More and more applications, while having a global navigation bar style, also require each view controller to customize the navigation bar style.

  This project just helps developers to solve this problem in an efficient way, developers use this navigation controller in a simple way, just like you used to set the status bar of the view controller, and
  You can provide a separate navigation bar style for each view controller, including slide back gestures, status bar styles, tab bar show and hide states, and more.
                       DESC

  s.homepage         = 'https://github.com/heroyoungday/YDRootNavigationController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jsone' => 'heroyoungday@gmail.com' }
  s.source           = { :git => 'https://github.com/heroyoungday/YDRootNavigationController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  s.swift_version = '5'
  
  s.default_subspec = "File"
  
  s.subspec "File" do |ss|
    ss.source_files = 'YDRootNavigationController/Classes/**/*'
    ss.dependency 'YDRootNavigationController/Resources'
  end
  # 资源依赖
  s.subspec "Resources" do |ss|
    ss.resource_bundles = {
      'YDRootNavigationController' => ['YDRootNavigationController/Assets/Images.xcassets']
    }
  end
  
  # s.source_files = 'YDRootNavigationController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'YDRootNavigationController' => ['YDRootNavigationController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
