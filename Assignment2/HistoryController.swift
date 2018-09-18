//
//  HistoryController.swift
//  Assignment2
//
//  Created by Sam on 2018/9/18.
//  Copyright © 2018年 Sam. All rights reserved.
//

import UIKit
import Firebase

class HistoryController: UITableViewController {

    var records: [Record] = []
    let ref = Database.database().reference().child("raspio")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.backgroundColor = UIColor.lightGray
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        ref.observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot{
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
                    
                    
                    let newRecord = Record(red: red, green: green, blue: blue, altimeter: altimeter, barometer: barometer, thermometer: thermometer)
                    self.records.append(newRecord)
                    
                }
            }
            
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        let record = records[indexPath.row]
        
        cell.backgroundColor = UIColor(red: CGFloat(record.red!)/255, green: CGFloat(record.green!)/255, blue: CGFloat(record.blue!)/255, alpha: 1)
        (cell as! ItemCell).titleTextLabel.textColor = cell.backgroundColor?.isDarkColor == true ? .white : .black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return records.count
    }
    
    
    //show
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
            let record = records[indexPath.row]
        
        let text = "Temperature: " + String(format:"%f", record.thermometer!) + " RGB: " + String(record.red!) + " ," + String(record.green!) + " ," + String(record.blue!)
        
            cell.titleTextLabel.text = text
            //        cell.textLabel?.text = groceryItem.name
        
        return cell
    }
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIColor
{
    var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  lum < 0.50 ? true : false
    }
}
