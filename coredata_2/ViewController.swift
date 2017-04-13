//
//  ViewController.swift
//  coredata_2
//
//  Created by IOS on 4/13/17.
//  Copyright © 2017 IOS. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var userText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func insertButton(_ sender: UIButton) {
        guard let appDel: AppDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDel.persistentContainer.viewContext
        
        //add new user
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)!
        let newUser = NSManagedObject(entity: entity, insertInto: context)
        newUser.setValue(userText.text, forKeyPath: "usernames")
        newUser.setValue(passwordText.text, forKeyPath: "password")
        
        //add the info to the entity
        do {
            try context.save()
        } catch {
            print("ada error")
        }
        //retrieve the data
        do {
            let request = NSFetchRequest<NSManagedObject>(entityName: "Users")
            let results = try context.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
            if results.count > 0 {
                for items in results as! [NSManagedObject] {
                    let name = items.value(forKeyPath: "usernames")
                    let password = items.value(forKeyPath: "password")
                    print(name!, password!)
                } //end of for items
            } //end of if
        } catch {
            print("ada error")
        }
        userText.text = "" //reset isi textfield untuk isian berikutnya
        passwordText.text = ""  //reset isi textfield untuk isian berikutnya
    }

    @IBAction func deleteButton(_ sender: UIButton) {
        guard let appDel: AppDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDel.persistentContainer.viewContext
        let del:String = userText.text!
        do {
            let request = NSFetchRequest<NSManagedObject>(entityName: "Users")
            let results = try context.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
            if results.count > 0 {
                for items in results as! [NSManagedObject] {
                    let name = items.value(forKeyPath: "usernames")
                    if name as! String == del {
                        //delete row where usernames="justin"
                        context.delete(items)
                        //don't forget to save
                        do {
                            try context.save()
                        } catch {
                            print("ada error")
                        }
                    }
                } //end of for items
            } //end of if
        } catch {
            print("ada error")
        }
    }

    @IBAction func editButton(_ sender: UIButton) {
        guard let appDel: AppDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDel.persistentContainer.viewContext
        
        do {
            let request = NSFetchRequest<NSManagedObject>(entityName: "Users")
            let results = try context.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
            if results.count > 0 {
                for items in results as! [NSManagedObject] {
                    let name = items.value(forKeyPath: "usernames")
                    if name as! String == "justin" {
                        //edit data where usernames="justin", set to "justinus"
                        items.setValue("justinus", forKeyPath: "usernames")
                        //don't forget to save
                        do {
                            try context.save()
                        } catch {
                            print("ada error")
                        }
                    }
                } //end of for items
            } //end of if
        } catch {
            print("ada error")
        }

    }
    
}

