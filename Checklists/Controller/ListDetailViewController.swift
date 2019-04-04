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
    
    var iconEdit : IconAsset?
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var iconTextField: UILabel!
    
    @IBAction func donePressed(_ sender: Any) {
        if checklistToEdit != nil {
            checklistToEdit?.name = textField.text!;
            delegate?.listItemDetailViewController(self, didFinishEditingItem: checklistToEdit!)
        }
        else {
            delegate?.listItemDetailViewController(self, didFinishAddingItem: Checklist(name : textField.text ?? "",icon : iconEdit ?? IconAsset.Folder))
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
            iconImage.image = checklistToEdit?.icon.image
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "iconPickerSegue" {
            let controller = segue.destination as! IconPickerViewController
            controller.delegate = self
        }
    }
}

extension ListDetailViewController : IconPickerViewControllerDelegate {
    func listIconPickerViewControllerDidCancel(_ controller: IconPickerViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func listIconPickerViewControllerDidFinishSelectingIcon(_ controller: IconPickerViewController, icon: IconAsset) {
        iconTextField.text = icon.rawValue
        iconImage.image = icon.image
        iconEdit = icon
        navigationController?.popViewController(animated: true)
    }
    
    
}

protocol ListDetailViewControllerDelegate : class {
    func listItemDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listItemDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: Checklist)
    func listItemDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: Checklist)
}
