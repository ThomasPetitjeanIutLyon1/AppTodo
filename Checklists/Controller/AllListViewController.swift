//
//  AllListViewController.swift
//  Checklists
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class AllListViewController:UITableViewController {
    
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showChecklistsItem"){
            if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell){
                let controller = segue.destination as! ChecklistViewController
                controller.list = DataModel.instance.lists[indexPath.row]
            }
        }
        if (segue.identifier == "AddCheckList"){
                let controller = (segue.destination as! UINavigationController).topViewController as! ListDetailViewController
                controller.delegate = self
        }
        if (segue.identifier == "EditCheckList"){
            if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell){
                let controller = (segue.destination as! UINavigationController).topViewController as! ListDetailViewController
                controller.checklistToEdit = DataModel.instance.lists[indexPath.row]
                controller.delegate = self
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DataModel.instance.sortChecklists()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.instance.lists.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistsListItem", for: indexPath)
        cell.textLabel?.text = DataModel.instance.lists[indexPath.row].name
        if DataModel.instance.lists[indexPath.row].items.count == 0 {
            cell.detailTextLabel?.text = "(No Item)"
        }
        else if DataModel.instance.lists[indexPath.row].uncheckedItemsCount == 0 {
            cell.detailTextLabel?.text = "All Done!"
        }
        else if DataModel.instance.lists[indexPath.row].uncheckedItemsCount > 0 {
            cell.detailTextLabel?.text = "\(DataModel.instance.lists[indexPath.row].uncheckedItemsCount)" + " remaining"
        }
        return cell
    }
}

extension AllListViewController: ListDetailViewControllerDelegate {
   
    
    func listItemDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func listItemDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: Checklist) {
        DataModel.instance.lists.append(item)
        tableView.insertRows(at: [IndexPath(row: DataModel.instance.lists.count - 1, section: 0)], with: .none)
        self.dismiss(animated: true, completion: nil)
    }
    
    func listItemDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: Checklist) {
        tableView.reloadRows(at: [IndexPath(row: DataModel.instance.lists.index(where: { $0 === item })!, section: 0)], with: .none)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
