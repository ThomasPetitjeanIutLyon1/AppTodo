//
//  ChecklistViewController.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    
    var list : [ChecklistItem] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addItem"){
            let controller = (segue.destination as! UINavigationController).topViewController as! ItemDetailViewController
            controller.delegate = self
        }
        if (segue.identifier == "editItem"){
            if let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell){
                let controller = (segue.destination as! UINavigationController).topViewController as! ItemDetailViewController
                controller.itemToEdit = list[indexPath.row]
                controller.delegate = self
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        list = [ChecklistItem(text: "salut"),ChecklistItem(text: "sss", checked: true),ChecklistItem(text: "theo", checked: false)]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.list.count);
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ChecklistItemCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath);
        configureText(for: cell as! ChecklistItemCell, withItem: (list[indexPath.row]))
        configureCheckmark(for: cell as! ChecklistItemCell, withItem: (list[indexPath.row]))
        return cell as! ChecklistItemCell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        list[indexPath.row].toggleChecked()
        let cell = tableView.cellForRow(at: indexPath)
        configureCheckmark(for: cell! as! ChecklistItemCell, withItem: list[indexPath.row])
        
    }
    
    func configureCheckmark(for cell: ChecklistItemCell, withItem item: ChecklistItem){
        cell.cellCheckmark.isHidden = item.checked
    }
    
    func configureText(for cell: ChecklistItemCell, withItem item: ChecklistItem){
        cell.cellLabel?.text = item.text;
    }
    
    @IBAction func addDummyTodo(_ sender: Any) {
        list.append(ChecklistItem(text: "Dummy"))
        tableView.insertRows(at: [IndexPath(row: (self.list.count) - 1 , section: 0)]  , with: .none)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.list.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath],  with: .none)
        
    }
    
}

extension ChecklistViewController : ItemDetailViewControllerDelegate{
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
        tableView.reloadRows(at: [IndexPath(row: list.index(where: { $0 === item })!, section: 0)], with: .none)
        self.dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        list.append(ChecklistItem(text: item.text))
        tableView.insertRows(at: [IndexPath(row: (self.list.count) - 1 , section: 0)]  , with: .none)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
