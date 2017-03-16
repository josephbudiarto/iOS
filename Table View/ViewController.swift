import UIKit

class ViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    var todoArr:[ToDoItem] = [ToDoItem("Cuci mobil", "Mobil A", "Suatu tempat"), ToDoItem("Belajar","Bljr Swift","Rumah"), ToDoItem("Makan","Makan Siang","Kantin")]
    @IBOutlet weak var tv1: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mycell")
            let i = indexPath.row
            cell?.textLabel?.text = todoArr[i].title
            cell?.detailTextLabel?.text = todoArr[i].desc
            return cell!
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func addClick(_ sender: Any) {
        let con = UIAlertController(title: "Add To Do", message: "", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            
            let firstTextField = con.textFields![0] as UITextField
            let secondTextField = con.textFields![1] as UITextField
            let thirdTextField = con.textFields![2] as UITextField
            
            self.todoArr.append(ToDoItem(firstTextField.text!,secondTextField.text!,thirdTextField.text!))
            self.tv1.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        con.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Title"
        }
        con.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Description"
        }
        con.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Place"
        }
        
        con.addAction(saveAction)
        con.addAction(cancelAction)
        
        self.present(con, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailSegue"){
            let vc = segue.destination as! DetailController
            vc.todoItem = self.todoArr[(tv1.indexPathForSelectedRow?.row)!]
        }
    }
    
}

