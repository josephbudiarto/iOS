import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var age: UILabel!
    
    @IBOutlet weak var name_text: UITextField!
    
    @IBOutlet weak var age_text: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var text_view: UITextView!
    
    @IBOutlet weak var gender: UISwitch!
    
    @IBOutlet weak var score: UISlider!
    
    @IBOutlet weak var scoreL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        score.value = 0
        sliderChange(score)
        gender.setOn(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sliderChange(_ sender: Any) {
        var val:Float = (sender as! UISlider).value
        val *= 100
        scoreL.text = String(round(val))
    }
    
    
    @IBAction func Switched(_ sender: Any) {
        
    }
    
    @IBAction func ButtonSubmit(_ sender: Any) {
        if(name_text.text?.characters.count == 0 || age_text.text?.characters.count == 0){
            let al = UIAlertController(title: "Error Message", message: "Please insert name and age", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: {(e) in
                    print("you pressed ok")
                })
            al.addAction(ok)
            self.present(al, animated: true, completion: {(e) in print("alert is displayed")})
            return
        }
        
        
        let con = UIAlertController(title: "Confirmation", message: "Do you want to save this?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default, handler: {(e) in
            
            self.text_view.text = self.text_view.text + "Hello, your name is \(self.name_text.text!), age \(self.age_text.text!) and you are \(self.gender.isOn ? "Male" : "Female")\nYour score is \(self.scoreL.text!) \n"
            self.name_text.text = ""
            self.age_text.text = ""
        })
        
        let no = UIAlertAction(title: "No", style: .cancel, handler: {(e) in
            self.name_text.text = ""
            self.age_text.text = ""
        })
        con.addAction(yes)
        con.addAction(no)
        self.present(con, animated: true, completion: {(e) in print("alert is displayed")})
        
    }
}

