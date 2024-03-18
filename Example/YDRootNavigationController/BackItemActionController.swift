//
//  BackItemActionController.swift
//  YDRootNavigationController _Example
//
//  Created by One on 2024/3/16.
//  Copyright © 2024 jsone All rights reserved.
//

import UIKit

class BackItemActionController: UIViewController {

    override var isInteractivePopGestureEnabled: Bool { false }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func backItemAction(_ sender: Any?) {
        let alert = UIAlertController(title: "提示", message: "是否确定退出？", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { [weak self] action in
            self?.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .default))
        present(alert, animated: true)
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
