//
//  UserDataHelper.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/17/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class UserDataHelper{
     var listOfUsers = [User]()
     var appDel:AppDelegate!
     var entityDescription:NSEntityDescription!
     var managedObjectContext:NSManagedObjectContext!
    init() {
        appDel=UIApplication.shared.delegate as? AppDelegate
        managedObjectContext=appDel.persistentContainer.viewContext
    }
    func saveUserDetails (user : User) {
        entityDescription=NSEntityDescription.entity(forEntityName:"Users", in: managedObjectContext)
        let userObj=NSManagedObject(entity: entityDescription, insertInto: managedObjectContext)
        userObj.setValue(user.name, forKey:Keys.name.rawValue)
        userObj.setValue(user.emailId, forKey:Keys.email.rawValue)
        userObj.setValue(user.password, forKey:Keys.password.rawValue)
        userObj.setValue(user.phNumber, forKey:Keys.phnNumber.rawValue)
        userObj.setValue(user.gender, forKey:Keys.gender.rawValue)
        do{
            try managedObjectContext.save()
//            print(users)
            listOfUsers.append(user)
            print("DONE USER SAVED TO COREDATA")
        }catch{
            print("ERROR SAVING TO COREDATA")
            
        }
        
    }
    func isUserExist(userMail:String,userPassword:String)-> Bool{
        var result = false
        entityDescription=NSEntityDescription.entity(forEntityName:"Users", in: managedObjectContext)
        let frequest=NSFetchRequest<NSFetchRequestResult>(entityName:"Users")
        frequest.predicate=NSPredicate(format: "email = %@",userMail)
        do{
            var fetchArray=try managedObjectContext.fetch(frequest)
            print(fetchArray)
            for i in 0..<fetchArray.count{
                let mngObj2=fetchArray[i] as! NSManagedObject
                let dBEmail=mngObj2.value(forKey:Keys.email.rawValue) as! String
                let dBPassword = mngObj2.value(forKey:Keys.password.rawValue) as! String
                if  userMail == dBEmail && userPassword == dBPassword {
                    print("User Exist")
                    result = true
                }
            }
        }catch{
            print("error in fetching")
        }
        return result
    }
    func deleteAllUsers(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(batchDeleteRequest)
            print("Deleted all objects from coredata")
            
        } catch {
            print("Error deleting all data from coredata")
        }
    }
    
}
extension UserDataHelper{
    enum Keys:String {
        case name = "name"
        case email = "email"
        case gender = "gender"
        case phnNumber = "mobile"
        case password = "password"
    }
}
