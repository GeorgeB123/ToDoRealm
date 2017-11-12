//
//  Task.swift
//  ToDoRealm
//
//  Created by George Bonnici-Carter on 11/11/2017.
//  Copyright © 2017 George Bonnici-Carter. All rights reserved.
//

import RealmSwift

class Task: Object {
    
    @objc dynamic var title = ""
    @objc dynamic var date = NSDate()
    @objc dynamic var priority = 0.0
    @objc dynamic var moreInfo = ""
    
}
