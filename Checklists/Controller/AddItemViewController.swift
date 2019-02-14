//
//  AddItemViewController.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {

    @IBOutlet weak var textField: UITextField!
    @IBAction func Done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        print(textField.text)
    }
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
