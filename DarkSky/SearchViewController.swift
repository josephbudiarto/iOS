import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var switchButton: UISegmentedControl!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "resultSegue"){
            let vs = segue.destination as! SearchTableViewController
            vs.search = self.searchText.text!
            vs.url = self.switchButton.selectedSegmentIndex
        }
    }
    
}
