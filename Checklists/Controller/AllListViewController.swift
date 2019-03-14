//
//  AllListViewController.swift
//  Checklists
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class AllListViewController:UITableViewController {
    
    var lists : [Checklist] = []
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showChecklistsItem"){
            if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell){
                let controller = segue.destination as! ChecklistViewController
                controller.list = lists[indexPath.row]
                controller.delegate = self
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
                controller.checklistToEdit = lists[indexPath.row]
                controller.delegate = self
            }
            
        }
    }
    
    override func viewDidLoad() {
        lists = [Checklist(name: "salut"),Checklist(name: "hllo"),Checklist(name: "salut")]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.lists.count);
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistsListItem", for: indexPath)
        cell.textLabel?.text = lists[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        
    }
}

extension AllListViewController : ChecklistViewControllerDelegate {
    
}

extension AllListViewController : ListDetailViewControllerDelegate{
    func listItemDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func listItemDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: Checklist) {
        lists.append(Checklist(name: item.name))
        tableView.insertRows(at: [IndexPath(row: (self.lists.count) - 1 , section: 0)]  , with: .none)
        self.dismiss(animated: true, completion: nil)
    }
    
    func listItemDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: Checklist) {
        tableView.reloadRows(at: [IndexPath(row: lists.index(where: { $0 === item })!, section: 0)], with: .none)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
