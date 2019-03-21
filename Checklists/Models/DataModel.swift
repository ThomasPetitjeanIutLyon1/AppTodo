//
//  DataModel.swift
//  Checklists
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import Foundation

class DataModel {
    static var instance = DataModel()
    var lists : [Checklist] = []
    
    var documentDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    var dataFileUrl: URL {
        return documentDirectory.appendingPathComponent("Checklists").appendingPathExtension("json")
    }
    
    init() {
        loadChecklistItems()
    }
    
    func saveChecklistItems(){
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let data = try? encoder.encode(lists)
        
        try? data?.write(to: dataFileUrl)
        
    }
    
    func loadChecklistItems() {
        if let data = try? Data(contentsOf: dataFileUrl),
            let list = try? JSONDecoder().decode([Checklist].self, from: data) {
            self.lists = list
        }
    }
}
