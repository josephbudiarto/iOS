//
//  ViewController.swift
//  DarkSky
//
//  Created by IOS on 4/20/17.
//  Copyright © 2017 IOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var wait: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wait.isHidden = false
        self.wait.startAnimating()
        let lat = -7.339306
        let long = 112.738410
        let session = URLSession.shared
        let url = NSURL(string: "https://api.darksky.net/forecast/7e9e4a81d6ba22693f62d9fe5db97567/\(lat),\(long)?units=si")!
        let dataTask = session.dataTask(with: url as URL) { (data, response, error) -> Void in
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                let results = jsonData.object(forKey: "currently") as! NSDictionary
                for (key, value) in results {
                    DispatchQueue.main.async {
                        switch key as! NSString {
                            case "temperature":
                                self.wait.isHidden = true
                                self.wait.stopAnimating()
                                self.temperatureLabel.text = "\(value)°C"
                            case "humidity":
                                self.wait.isHidden = true
                                self.wait.stopAnimating()
                                self.humidityLabel.text = "\((value as! Double)*100)%"
                            default: break
                        }
                    }
                }
            } catch {
                print("error: \(error)")
            }
        }
        dataTask.resume()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

