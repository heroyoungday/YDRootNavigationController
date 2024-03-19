//
//  InteractivePopGestureEnabledController.swift
//  YDRootNavigationController _Example
//
//  Created by One on 2024/3/15.
//  Copyright © 2024 jsone All rights reserved.
//

import UIKit

class InteractivePopGestureEnabledController: UIViewController {
    
    override var isInteractivePopGestureEnabled: Bool { interactivePopGesture }
    var interactivePopGesture: Bool = true {
        didSet {
            interactivePopGesture(interactivePopGesture)
        }
    }
    @IBOutlet weak var interactivePopGestureEnabledSwitch: UISwitch!
    
    var enablePopGesture: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "isInteractivePopGestureEnabled"
        interactivePopGestureEnabledSwitch.isOn = interactivePopGesture
    }
    

    @IBAction func replaceAction(_ sender: Any) {
        let vc = PrefersNavigationBarHiddenController()
        navigationController?.pushViewController(vc, animated: true, replace: true)
    }
    @IBAction func switchAction(_ sender: Any) {
        guard let sw = sender as? UISwitch else { return }
        interactivePopGesture = sw.isOn
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
