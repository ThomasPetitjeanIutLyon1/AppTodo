//
//  Checklists.swift
//  Checklists
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import Foundation

class Checklist: Codable {
    var name : String
    var items : [ChecklistItem]
    
    var icon : IconAsset
    
    var uncheckedItemsCount: Int {
        var i = 0
        
        for it in items {
            if(it.checked){
                i = i + 1
            }
        }
        return i
    }
    
    init(name : String, items:[ChecklistItem] = []) {
        self.name = name
        self.items = items
        self.icon = IconAsset.NoIcon
    }
    
    
}
