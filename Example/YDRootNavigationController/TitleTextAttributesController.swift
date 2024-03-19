//
//  TitleTextAttributesController.swift
//  YDRootNavigationController _Example
//
//  Created by One on 2024/3/15.
//  Copyright © 2024 jsone All rights reserved.
//

import UIKit

class TitleTextAttributesController: UIViewController {
    
    override var navigationBarAppearence: YDNavigationBarAppearence {
        YDNavigationBarAppearence(titleTextAttributes: [NSAttributedString.Key.foregroundColor: UIColor.randomColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "titleTextAttributes"
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
