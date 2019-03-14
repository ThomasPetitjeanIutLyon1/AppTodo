//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController, UITextFieldDelegate {
    
    var delegate : ListDetailViewControllerDelegate?;
    
    var checklistToEdit : Checklist?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBAction func donePressed(_ sender: Any) {
        if checklistToEdit != nil {
            checklistToEdit?.name = textField.text!;
            delegate?.listItemDetailViewController(self, didFinishEditingItem: checklistToEdit!)
        }
        else {
            delegate?.listItemDetailViewControllerDidCancel(self)
            delegate?.listItemDetailViewController(self, didFinishAddingItem: Checklist(name : textField.text ?? ""))
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        delegate?.listItemDetailViewControllerDidCancel(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if checklistToEdit != nil {
            self.navigationItem.title = "Edit Item"
            textField.text = checklistToEdit?.name
        }
    }
}

protocol ListDetailViewControllerDelegate : class {
    func listItemDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listItemDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: Checklist)
    func listItemDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: Checklist)
}
