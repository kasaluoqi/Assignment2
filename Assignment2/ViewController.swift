//
//  ViewController.swift
//  Assignment2
//
//  Created by Sam on 2018/9/17.
//  Copyright © 2018年 Sam. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var temp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().signInAnonymously(
            completion: {(user, error) in
                if error != nil
                {
                    print(error ?? "Error")
                }
                return
        })
        
        // Do any additional setup after loading the view, typically from a nib.
        let ref = Database.database().reference().child("raspio")
        
        ref.observe(.childAdded, with: { snapshot in
//            print(snapshot.value as Any)
//            guard
            let data = snapshot.value as! [String: AnyObject]
            guard
                let altimeter = data["altimeter"] as? Double,
                let barometer = data["barometer"] as? Double,
                let thermometer = data["thermometer"] as? Double,
                let red = data["red"] as? Int,
                let green = data["green"] as? Int,
                let blue = data["blue"] as? Int else {
                    print("Error")
                    return
            }
            let text = "Temperature: " + String(format:"%f", thermometer) + " RGB: " + String(red) + " ," + String(green) + " ," + String(blue)
            self.temp.text = text
        })
        
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "showHistory" {
//            if let controller = segue.destination as? HistoryController {
//               
//            }
//        }
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

