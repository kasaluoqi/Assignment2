//
//  Record.swift
//  Assignment2
//
//  Created by Sam on 2018/9/18.
//  Copyright © 2018年 Sam. All rights reserved.
//

import UIKit

class Record: NSObject {
    var red: Int?
    var green: Int?
    var blue: Int?
    var altimeter: Double?
    var barometer: Double?
    var thermometer: Double?
    init(red: Int, green: Int, blue: Int, altimeter: Double, barometer: Double, thermometer: Double) {
        self.red = red
        self.green = green
        self.blue = blue
        self.altimeter = altimeter
        self.barometer = barometer
        self.thermometer = thermometer
    }
    
    func toAnyObject() -> Any {
        return [
            "red": red!,
            "green": green!,
            "blue": blue!,
            "altimeter": altimeter!,
            "barometer": barometer!,
            "thermometer": thermometer!
        ]
    }
}
