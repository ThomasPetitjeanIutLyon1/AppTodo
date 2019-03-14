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
