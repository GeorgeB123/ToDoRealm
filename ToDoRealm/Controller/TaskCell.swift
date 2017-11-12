//
//  TaskCell.swift
//  ToDoRealm
//
//  Created by George Bonnici-Carter on 11/11/2017.
//  Copyright © 2017 George Bonnici-Carter. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    var priorityColour: Float = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setColour()
    }
    
    func setColour() {
        if priorityColour <= Constants.lowerBounds {
            backgroundColor = UIColor(hue: 0.3222, saturation: 0.4, brightness: 1, alpha: 1.0)
        } else if priorityColour > Constants.lowerBounds && priorityColour <= Constants.upperBounds {
            backgroundColor = UIColor(hue: 0.1667, saturation: 0.4, brightness: 1, alpha: 1.0)
        } else {
            backgroundColor = UIColor(hue: 0.025, saturation: 0.4, brightness: 1, alpha: 1.0)
        }
    }
}
