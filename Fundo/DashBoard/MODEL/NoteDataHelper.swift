//
//  NoteDataHelper.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/17/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class NoteDataHelper{
    var appDel:AppDelegate!
    var entityDescription:NSEntityDescription!
    var managedObjectContext:NSManagedObjectContext!
    init() {
        appDel = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = appDel.persistentContainer.viewContext
    }
    
    func saveNote(note:Note)  {
        entityDescription=NSEntityDescription.entity(forEntityName:"Notes", in: managedObjectContext)
        let noteObj=NSManagedObject(entity: entityDescription, insertInto: managedObjectContext)
        noteObj.setValue(note.title, forKey: Keys.title.rawValue)
        noteObj.setValue(note.description, forKey: Keys.description.rawValue)
        noteObj.setValue(note.noteId, forKey: Keys.noteId.rawValue)
        noteObj.setValue(note.color, forKey: Keys.color.rawValue)
        noteObj.setValue(note.isPinned, forKey: Keys.pinned.rawValue)
        noteObj.setValue(note.isArchived, forKey: Keys.archived.rawValue)
        noteObj.setValue(note.remainder, forKey: Keys.remainder.rawValue)
        do{
            try managedObjectContext.save()
            print(noteObj)
            note.toString()
            print(getAllNotes().count)
            print("DONE NOTE SAVED TO COREDATA")
        }catch{
            print("ERROR SAVING TO COREDATA")
        }
        
      // deleteAllNotes()
    }
    func deleteAllNotes(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(batchDeleteRequest)
            print("Deleted all objects from coredata")
            
        } catch {
            print("Error deleting all data from coredata")
        }
    }
    func getAllNotes() -> [Note] {
        var listOfNotes = [Note]()
        let fetchedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        do{
            let listOfDBNotes = try managedObjectContext.fetch(fetchedRequest) as! [NSManagedObject]
            for dbNote in listOfDBNotes {
                let noteId = dbNote.value(forKey: Keys.noteId.rawValue) as! Int
                let noteTitle = dbNote.value(forKey: Keys.title.rawValue) as! String
                let noteDesc = dbNote.value(forKey: Keys.description.rawValue) as! String
                let noteColor = dbNote.value(forKey: Keys.color.rawValue) as! String
                let noteIsPinned = dbNote.value(forKey: Keys.pinned.rawValue) as! Bool
                let noteIsArchived = dbNote.value(forKey: Keys.archived.rawValue) as! Bool
                let noteRemainder = dbNote.value(forKey: Keys.remainder.rawValue) as! Date
                var foundNote = Note.init(title: noteTitle, description: noteDesc, color: noteColor, isPinned: noteIsPinned,isArchived: noteIsArchived,remainder: noteRemainder)
                foundNote.updateId(noteId: noteId)
                listOfNotes.append(foundNote)
            }
        }catch{
            print("ERROR IN FETCHING")
        }
        
        return listOfNotes
    }
    func getPinnedNotes() -> [Note] {
        var listOfNotes = [Note]()
        let fetchedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        fetchedRequest.predicate = NSPredicate(format: "isPinned == TRUE")

        do{
            let listOfDBNotes = try managedObjectContext.fetch(fetchedRequest) as! [NSManagedObject]
            for dbNote in listOfDBNotes {
                let noteId = dbNote.value(forKey: Keys.noteId.rawValue) as! Int
                let noteTitle = dbNote.value(forKey: Keys.title.rawValue) as! String
                let noteDesc = dbNote.value(forKey: Keys.description.rawValue) as! String
                let noteColor = dbNote.value(forKey: Keys.color.rawValue) as! String
                let noteIsPinned = dbNote.value(forKey: Keys.pinned.rawValue) as! Bool
                let noteIsArchived = dbNote.value(forKey: Keys.archived.rawValue) as! Bool
                let noteRemainder = dbNote.value(forKey: Keys.remainder.rawValue) as! Date
                var foundNote = Note.init(title: noteTitle, description: noteDesc, color: noteColor, isPinned: noteIsPinned,isArchived: noteIsArchived,remainder: noteRemainder)
                foundNote.updateId(noteId: noteId)
                listOfNotes.append(foundNote)
            }
        }catch{
            print("ERROR IN FETCHING")
        }
        
        return listOfNotes
    }
    
    
    func updateNote(updateNote : Note) {
        entityDescription=NSEntityDescription.entity(forEntityName:"Notes", in: managedObjectContext)
       let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        fr.predicate = NSPredicate(format: "noteId == %i",(updateNote.noteId))
        
        do {
            var fetchArray = try managedObjectContext.fetch(fr)
            print(fetchArray)
            for i in 0..<fetchArray.count{
                let mngObj = fetchArray[i] as! NSManagedObject
//            var fetchArray = try managedObjectContext.fetch(fr)
//            print(fetchArray)
//                let mngObj = fetchArray[indexPath.row] as! NSManagedObject
                 mngObj.setValue(updateNote.title, forKey: Keys.title.rawValue)
                mngObj.setValue(updateNote.description ?? "", forKey: Keys.description.rawValue)
                mngObj.setValue(updateNote.color ?? "", forKey: Keys.color.rawValue)
                mngObj.setValue(updateNote.isPinned , forKey: Keys.pinned.rawValue)
                do{
                    try managedObjectContext.save()
//                    fetchArray[indexPath.row] = mngObj
                }catch{
                    print("error in updating")
                }
            }
        }catch{
                
        }
        
    }
}
extension NoteDataHelper {
    enum Keys:String {
        case title = "title"
        case description = "notes"
        case noteId = "noteId"
        case color = "color"
        case pinned = "isPinned"
        case archived = "isArchived"
        case remainder = "remainder"
    }
}
