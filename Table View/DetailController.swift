import UIKit

class DetailController: UIViewController {
    var todoItem:ToDoItem!
    //tanda seru supaya tidak wajib di initialize
    
    @IBOutlet weak var label_place: UILabel!
    @IBOutlet weak var label_desc: UILabel!
    @IBOutlet weak var title_label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title_label.text = todoItem.title
        label_desc.text = todoItem.desc
        label_place.text = todoItem.place
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
