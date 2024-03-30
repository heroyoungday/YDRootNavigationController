//
//  BackgroundImageController.swift
//  YDRootNavigationController_Example
//
//  Created by One on 2024/3/30.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class BackgroundImageController: UIViewController {

    override var navigationBarAppearence: YDNavigationBarAppearence { YDNavigationBarAppearence(backgroundImage: UIImage.gradient(colors: [UIColor.systemPink, UIColor.purple], type: .leftToRight, size: CGSize(width: Screen.width, height: Screen.navigationBarHeight))?.addCorner(YDRectCorner(bottomLeft: 20, bottomRight: 20))) }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "backgroundImage"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
