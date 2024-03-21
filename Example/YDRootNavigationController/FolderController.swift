//
//  FolderController.swift
//  YDRootNavigationController_Example
//
//  Created by One on 2024/3/20.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class FolderController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Folder"
        view.backgroundColor = .randomColor
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
