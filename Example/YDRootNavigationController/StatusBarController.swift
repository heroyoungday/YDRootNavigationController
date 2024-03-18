//
//  StatusBarController.swift
//  YDRootNavigationController _Example
//
//  Created by One on 2024/3/17.
//  Copyright © 2024 jsone All rights reserved.
//

import UIKit

class StatusBarController: UIViewController {
    
    override var navigationBarAppearence: YDNavigationBarAppearence { YDNavigationBarAppearence(backgroundColor: .randomColor) }
    override var preferredStatusBarStyle: UIStatusBarStyle { statusBarStyle }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { statusBarUpdateAnimation }
    override var prefersStatusBarHidden: Bool { statusBarHidden }
    
    var statusBarStyle: UIStatusBarStyle = .lightContent
    
    var statusBarUpdateAnimation: UIStatusBarAnimation = .none
    
    var statusBarHidden: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func styleAction(_ sender: Any) {
        guard let segmentedControl = sender as? UISegmentedControl else { return }
        statusBarStyle = UIStatusBarStyle(rawValue: segmentedControl.selectedSegmentIndex) ?? .default
        UIView.animate(withDuration: 0.5) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    @IBAction func animationAction(_ sender: Any) {
        guard let segmentedControl = sender as? UISegmentedControl else { return }
        statusBarUpdateAnimation = UIStatusBarAnimation(rawValue: segmentedControl.selectedSegmentIndex) ?? .none
    }
    
    @IBAction func hiddenAction(_ sender: Any) {
        guard let sw = sender as? UISwitch else { return }
        statusBarHidden = sw.isOn
        UIView.animate(withDuration: 0.5) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
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
