//
//  ChecklistViewController.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var delegate : ChecklistViewControllerDelegate?;
    
    var documentDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    var dataFileUrl: URL {
        return documentDirectory.appendingPathComponent("Checklists").appendingPathExtension("json")
    }
    
    
    var itemTab : [ChecklistItem] = []
    var list : Checklist!
    
    var listTitle: String?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addItem"){
            let controller = (segue.destination as! UINavigationController).topViewController as! ItemDetailViewController
            controller.delegate = self
        }
        if (segue.identifier == "editItem"){
            if let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell){
                let controller = (segue.destination as! UINavigationController).topViewController as! ItemDetailViewController
                controller.itemToEdit = itemTab[indexPath.row]
                controller.delegate = self
            }
        }
    }
    
    override func awakeFromNib() {
        //loadChecklistItems()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = list.name
       
        self.itemTab = list.items
        
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.itemTab.count);
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ChecklistItemCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath);
        configureText(for: cell as! ChecklistItemCell, withItem: (itemTab[indexPath.row]))
        configureCheckmark(for: cell as! ChecklistItemCell, withItem: (itemTab[indexPath.row]))
        return cell as! ChecklistItemCell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        itemTab[indexPath.row].toggleChecked()
        let cell = tableView.cellForRow(at: indexPath)
        configureCheckmark(for: cell! as! ChecklistItemCell, withItem: itemTab[indexPath.row])
        
    }
    
    func configureCheckmark(for cell: ChecklistItemCell, withItem item: ChecklistItem){
        cell.cellCheckmark.isHidden = item.checked
    }
    
    func configureText(for cell: ChecklistItemCell, withItem item: ChecklistItem){
        cell.cellLabel?.text = item.text;
    }
    
    @IBAction func addDummyTodo(_ sender: Any) {
        itemTab.append(ChecklistItem(text: "Dummy"))
        tableView.insertRows(at: [IndexPath(row: (self.itemTab.count) - 1 , section: 0)]  , with: .none)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.itemTab.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath],  with: .none)
        
    }
    
    func saveChecklistItems(){
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let data = try? encoder.encode(itemTab)
    
        try? data?.write(to: dataFileUrl)
        
    }
    
    func loadChecklistItems(){
        let decoder = JSONDecoder()
        itemTab = try! decoder.decode([ChecklistItem].self, from: try! Data(contentsOf: dataFileUrl))
    }
}

extension ChecklistViewController : ItemDetailViewControllerDelegate{
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
        tableView.reloadRows(at: [IndexPath(row: itemTab.index(where: { $0 === item })!, section: 0)], with: .none)
        saveChecklistItems()
        self.dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        itemTab.append(ChecklistItem(text: item.text))
        tableView.insertRows(at: [IndexPath(row: (self.itemTab.count) - 1 , section: 0)]  , with: .none)
        //saveChecklistItems()
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
protocol ChecklistViewControllerDelegate : class {
    
}
