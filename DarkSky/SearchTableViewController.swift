//
//  SearchTableViewController.swift
//  DarkSky
//
//  Created by IOS on 4/20/17.
//  Copyright © 2017 IOS. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController,UISearchBarDelegate {

    var search:String = ""
    var url:Int = 0
    var cellArr:[Result] = []
    var filteredArr:[Result] = []
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(url == 0){
            doSearchPeter(search: search)
        }else{
            doSearchJohn(search: search)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tableView.reloadData()
        view.endEditing(true)
    }

    // MARK: - Search Bar source
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filteredArr = cellArr.filter({(search:Result) in
            return search.name.lowercased().contains((searchBar.text?.lowercased())!)
        })
        tableView.reloadData()
        view.endEditing(true) // dismiss keyboard
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        filteredArr = cellArr.filter({(search:Result) in
            return search.name.lowercased().contains((searchBar.text?.lowercased())!)
        })
        tableView.reloadData()
        view.endEditing(true)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        tableView.reloadData()
        view.endEditing(true)
        return false
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if((searchBar.text?.characters.count)! > 0){
            return filteredArr.count
        }
        return cellArr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as UITableViewCell!{
            if((searchBar.text?.characters.count)! > 0){
                cell.textLabel?.text = filteredArr[indexPath.row].name
                cell.detailTextLabel?.text = filteredArr[indexPath.row].login
            }else{
                cell.textLabel?.text = cellArr[indexPath.row].name
                cell.detailTextLabel?.text = cellArr[indexPath.row].login
            }
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        tableView.reloadData()
        view.endEditing(true)
    }

    func doSearchPeter( search:String) {
        let session = URLSession.shared
        let myURL = NSURL(string: "http://peter.petra.ac.id/~justin/finger.php?s=\(search)")!
        let dataTask = session.dataTask(with: myURL as URL) { (data, response, error) -> Void in
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                let results = jsonData.object(forKey: "hasil") as! NSArray
                DispatchQueue.main.async {
                    for value in results {
                        let logins = (value as AnyObject)["login"] as! String
                        let names = (value as AnyObject)["nama"] as! String
                        let units = (value as AnyObject)["unit"] as! String
                        self.cellArr.append(Result(logins,names,units))
                        self.tableView.reloadData()
                        print(logins, names, units)
                    }
                }
            } catch {
                print("error: \(error)")
            }
        }
        dataTask.resume()
    }
    func doSearchJohn( search:String) {
        let session = URLSession.shared
        let myURL = NSURL(string: "http://john.petra.ac.id/~justin/finger.php?s=\(search)")!
        let dataTask = session.dataTask(with: myURL as URL) { (data, response, error) -> Void in
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                let results = jsonData.object(forKey: "hasil") as! NSArray
                DispatchQueue.main.async {
                    for value in results {
                        let logins = (value as AnyObject)["login"] as! String
                        let names = (value as AnyObject)["nama"] as! String
                        let units = (value as AnyObject)["unit"] as! String
                        self.cellArr.append(Result(logins,names,units))
                        self.tableView.reloadData()
                        print(logins, names, units)
                    }
                }
            } catch {
                print("error: \(error)")
            }
        }
        dataTask.resume()
    }
}
