//
//  ShadowColorController.swift
//  YDRootNavigationController _Example
//
//  Created by One on 2024/3/16.
//  Copyright © 2024 jsone All rights reserved.
//

import UIKit

class ShadowColorController: UIViewController {

    override var navigationBarAppearence: YDNavigationBarAppearence {
        YDNavigationBarAppearence(shadowColor: .randomColor)
    }
    
    override var backItemType: YDBackItemType { backType }
    
    var backType: YDBackItemType = .default()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
