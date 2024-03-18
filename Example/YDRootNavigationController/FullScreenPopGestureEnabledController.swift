//
//  FullScreenPopGestureEnabledController.swift
//  YDRootNavigationController _Example
//
//  Created by One on 2024/3/17.
//  Copyright © 2024 jsone All rights reserved.
//

import UIKit

class FullScreenPopGestureEnabledController: UIViewController {

    override var isFullScreenPopGestureEnabled: Bool { fullScreenPopGesture }
    var fullScreenPopGesture: Bool = true {
        didSet {
            fullScreenPopGesture(fullScreenPopGesture)
        }
    }
    @IBOutlet weak var fullScreenPopGestureEnabledSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        fullScreenPopGestureEnabledSwitch.isOn = fullScreenPopGesture
        // Do any additional setup after loading the view.
    }
    
    @IBAction func switchAction(_ sender: Any) {
        guard let sw = sender as? UISwitch else { return }
        fullScreenPopGesture = sw.isOn
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
