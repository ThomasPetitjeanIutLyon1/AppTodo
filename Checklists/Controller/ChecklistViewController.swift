//
//  ChecklistViewController.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var list : [ChecklistItem]?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        list = [ChecklistItem(text: "salut"),ChecklistItem(text: "sss", checked: true),ChecklistItem(text: "theo", checked: false)]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.list?.count)!;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath);
        configureText(for: cell, withItem: (list?[indexPath.row])!)
        configureCheckmark(for: cell, withItem: (list?[indexPath.row])!)
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        list![indexPath.row].toggleChecked()
        let cell = tableView.cellForRow(at: indexPath)
        configureCheckmark(for: cell!, withItem: list![indexPath.row])
        
    }
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: ChecklistItem){
        cell.accessoryType = (item.checked ? .checkmark : .none)
    }
    
    func configureText(for cell: UITableViewCell, withItem item: ChecklistItem){
        cell.textLabel?.text = item.text;

    }
}

