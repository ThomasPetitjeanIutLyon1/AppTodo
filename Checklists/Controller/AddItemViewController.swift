//
//  AddItemViewController.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    var delegate : AddItemViewControllerDelegate?;

    var itemToEdit : ChecklistItem?
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBAction func Done(_ sender: Any) {
        if itemToEdit != nil {
            itemToEdit?.text = textField.text!;
            delegate?.editItemViewController(self, didFinishEditingItem: itemToEdit!)
        }
        else {
            delegate?.addItemViewControllerDidCancel(self)
            delegate?.addItemViewController(self, didFinishAddingItem: ChecklistItem(text : textField.text ?? ""))
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if itemToEdit != nil {
            self.navigationItem.title = "Edit Item"
            textField.text = itemToEdit?.text
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    @IBAction func Cancel(_ sender: Any) {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nsString = self.textField.text as NSString?
        let newString = nsString?.replacingCharacters(in: range, with: string)
        if newString?.isEmpty ?? true {
            doneButton.isEnabled = false
        } else {
            doneButton.isEnabled = true
        }
        return true
    }
}

protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
    func editItemViewController(_ controller: AddItemViewController, didFinishEditingItem item: ChecklistItem)
}
