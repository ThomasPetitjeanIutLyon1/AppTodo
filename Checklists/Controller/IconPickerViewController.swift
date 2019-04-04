//
//  IconPickerViewController.swift
//  Checklists
//
//  Created by lpiem on 04/04/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class IconPickerViewController: UITableViewController {

    var delegate : IconPickerViewControllerDelegate?
    var icons : [IconAsset] = IconAsset.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate!.listIconPickerViewControllerDidFinishSelectingIcon(self, icon : icons[indexPath.row])
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconSelectionCell", for: indexPath)
        cell.textLabel?.text = icons[indexPath.row].rawValue
        cell.imageView?.image = icons[indexPath.row].image
        return cell
    }

    

}

protocol IconPickerViewControllerDelegate {
    func listIconPickerViewControllerDidCancel(_ controller: IconPickerViewController)
    func listIconPickerViewControllerDidFinishSelectingIcon(_ controller: IconPickerViewController,  icon: IconAsset)
}
