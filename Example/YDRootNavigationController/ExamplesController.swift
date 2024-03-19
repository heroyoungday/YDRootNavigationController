//
//  ExamplesController.swift
//  YDRootNavigationController _Example
//
//  Created by One on 2024/3/14.
//  Copyright © 2024 jsone All rights reserved.
//

import UIKit

class ExamplesController: UITableViewController {

    @IBOutlet weak var interactivePopGestureEnabledSwitch: UISwitch!
    @IBOutlet weak var fullScreenPopGestureEnabledSwitch: UISwitch!
    @IBOutlet weak var prefersNavigationBarHiddenSwitch: UISwitch!
    @IBOutlet weak var isHidesBottomBarWhenPushedSwitch: UISwitch!
    @IBOutlet weak var isHidesBackItemSwitch: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 6
        case 1:
            return 5
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "View_Controller_Protocol"
        case 1:
            return "Navigation_Bar_Appearence"
        default:
            return nil
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch segue.destination {
        case is InteractivePopGestureEnabledController:
            guard let vc = segue.destination as? InteractivePopGestureEnabledController else { return }
            vc.interactivePopGesture = interactivePopGestureEnabledSwitch.isOn
        case is FullScreenPopGestureEnabledController:
            guard let vc = segue.destination as? FullScreenPopGestureEnabledController else { return }
            vc.fullScreenPopGesture = fullScreenPopGestureEnabledSwitch.isOn
        case is PrefersNavigationBarHiddenController:
            guard let vc = segue.destination as? PrefersNavigationBarHiddenController else { return }
            vc.isHiddenNavigationBar = prefersNavigationBarHiddenSwitch.isOn
        case is IsHidesBottomBarWhenPushedController:
            guard let vc = segue.destination as? IsHidesBottomBarWhenPushedController else { return }
            vc.isHiddenBottomBarWhenPushed = isHidesBottomBarWhenPushedSwitch.isOn
        case is IsHidesBackItemController:
            guard let vc = segue.destination as? IsHidesBackItemController else { return }
            vc.isHiddenBackItem = isHidesBackItemSwitch.isOn
        default:
            break
        }
    }

}
