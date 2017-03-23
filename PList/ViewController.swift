import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var userT: UITextField!
    @IBOutlet weak var passT: UITextField!
    @IBOutlet weak var volS: UISlider!
    @IBOutlet weak var autoPlayS: UISwitch!
    @IBOutlet weak var founderTV: UITableView!
    @IBOutlet weak var welcomeS: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //password asterixed
        passT.isSecureTextEntry = true
        //username
        userT.text = getUd().value(forKey: "user") as! String?
        //volume check if nill
        if let vol = getUd().value(forKey: "volume") as? Float{
            volS.value = vol
        }else{
            volS.value = 0.9
        }
        //autoPlay check if nill
        if let apOn = getUd().value(forKey: "autoPlay") as? Bool{
            autoPlayS.setOn(apOn, animated: true)
        }else{
            autoPlayS.setOn(true, animated: true)
        }
        
        //Welcome switch
        if let on = getUd().value(forKey: "toggle") as? Bool{
            welcomeS.setOn(on, animated: true)
        }else{
            welcomeS.setOn(false, animated: true)
        }
        if(getUd().value(forKey: "welcome") as? Bool)!{
            welcomeS.setOn(false, animated: true)
        }else{
            welcomeS.setOn(true, animated: true)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func alertAppear(){
        let con = UIAlertController(title: "Welcome", message: "Welcome to My App", preferredStyle: .alert)
            
        let ok = UIAlertAction(title: "ok", style: .default, handler: {(e) in
            })
            
        con.addAction(ok)
        self.present(con, animated: true, completion: {(e) in print("alert is displayed")})
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var welcome = false
        if let alreadyWelcome = getUd().value(forKey: "welcome") as? Bool{
            if(!alreadyWelcome){
                welcome = true
                getUd().set(true, forKey: "welcome")
            }else{
                welcome = false
            }
        }else{
            welcome = true
        }
        if(welcome){
            alertAppear()
            print("Tidak ada isinya")
        }else{
            print("Ada isinya")
        }
        
    }
    
    func getUd()->UserDefaults{
        return UserDefaults.standard
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        let ud = getUd()
        //forKey untuk nama variable nya
        ud.set(userT.text, forKey: "user")
    }

    @IBAction func volChanged(_ sender: Any) {
    }
    
    @IBAction func autoPlayChanged(_ sender: Any) {
    }
    
    @IBAction func welcomeChanged(_ sender: Any) {
        if(welcomeS.isOn){
            print("On")
            getUd().set(false, forKey: "welcome")
            getUd().set(true, forKey: "toggle")
        }else{
            print("Off")
            getUd().set(true, forKey: "welcome")
            getUd().set(false, forKey: "toggle")
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! myCell
        cell.nameL.text = "Joe"
        cell.phoneL.text = "08785170"
        cell.companyL.text = "Faspay"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

