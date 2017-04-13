import UIKit
import CoreData

class coreDataController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var newUserText: UITextField!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var newPassText: UITextField!
    var userArr:[users]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        isi()
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
        userText.text = "" //reset isi textfield untuk isian berikutnya
        passwordText.text = ""  //reset isi textfield untuk isian berikutnya
        isi()
        table.reloadData()

    }
    @IBAction func editButton(_ sender: UIButton) {
        guard let appDel: AppDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDel.persistentContainer.viewContext
        let edit:String = userText.text!
        let pass:String = passwordText.text!
        let newuser:String = newUserText.text!
        let newpass:String = newPassText.text!
        do {
            let request = NSFetchRequest<NSManagedObject>(entityName: "Users")
            let results = try context.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
            if results.count > 0 {
                for items in results as! [NSManagedObject] {
                    let name = items.value(forKeyPath: "usernames")
                    let password = items.value(forKeyPath: "password")
                    if name as! String == edit && password as! String == pass{
                        //edit data where usernames="justin", set to "justinus"
                        items.setValue(newuser, forKeyPath: "usernames")
                        items.setValue(newpass, forKey: "password")
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
        isi()
        table.reloadData()
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
        isi()
        table.reloadData()
    }
    func isi()->Void{
        userArr.removeAll()
        //retrieve the data
        guard let appDel: AppDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDel.persistentContainer.viewContext
        do {
            let request = NSFetchRequest<NSManagedObject>(entityName: "Users")
            let results = try context.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
            if results.count > 0 {
                for items in results as! [NSManagedObject] {
                    let name = items.value(forKeyPath: "usernames") as! String
                    let pass = items.value(forKeyPath: "password") as! String
                    userArr.append(users(name,pass))
                    print(name, pass)
                } //end of for items
            } //end of if
        } catch {
            print("ada error")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let i = indexPath.row
        cell?.textLabel?.text = userArr[i].username
        cell?.detailTextLabel?.text = userArr[i].password
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let appDel: AppDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDel.persistentContainer.viewContext
        let userdel:String = userArr[indexPath.row].username
        let passdel:String = userArr[indexPath.row].password
        do {
            let request = NSFetchRequest<NSManagedObject>(entityName: "Users")
            let results = try context.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
            if results.count > 0 {
                for items in results as! [NSManagedObject] {
                    let name = items.value(forKeyPath: "usernames")
                    let pass = items.value(forKeyPath: "password")
                    if name as! String == userdel && pass as! String == passdel {
                        //delete
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
        isi()
        table.reloadData()
    }

}
