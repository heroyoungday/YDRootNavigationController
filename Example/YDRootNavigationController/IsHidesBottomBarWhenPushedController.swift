//
//  IsHidesBottomBarWhenPushedController.swift
//  YDRootNavigationController _Example
//
//  Created by One on 2024/3/15.
//  Copyright © 2024 jsone All rights reserved.
//

import UIKit

class IsHidesBottomBarWhenPushedController: UIViewController {

    override var isHidesBottomBarWhenPushed: Bool { isHiddenBottomBarWhenPushed }
    var isHiddenBottomBarWhenPushed: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "isHidesBottomBarWhenPushed"
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
