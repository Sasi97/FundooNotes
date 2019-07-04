//
//  Notes.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/17/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation

struct Note {
    var noteId : Int 
    var title:String?
    var description:String?
    var color:String?
    var isPinned:Bool?
    var isArchived:Bool?
    var remainder:Date?
    
    static var idFactory = 0
    
    static func getUniqueId() -> Int {
        self.idFactory += 1
        
        return self.idFactory
    }
    
    mutating func updateId(noteId : Int) {
        self.noteId = noteId
    }
    
    private init() {
        self.noteId = Note.getUniqueId()
    }
    
    init(title : String, description : String, color:String,isPinned:Bool,isArchived:Bool,remainder: Date) {
        self.init()
        self.title = title
        self.description = description
        self.color = color
        self.isPinned = isPinned
        self.isArchived = isArchived
        self.remainder = remainder 
    }
    
    func toString() {
        print(
            """
            Note Id : \(noteId)
            Note Title : \(title!)
            Note Description : \(description!)
            Note Color : \(color!)
            Note isPinned : \(isPinned!)
            Note isArchived: \(isArchived!)
            Note Remanider : \(remainder)
            """
        )
    }
    
}
