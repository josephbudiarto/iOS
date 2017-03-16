//
//  toDoItem.swift
//  Table View
//
//  Created by IOS on 3/16/17.
//  Copyright © 2017 IOS. All rights reserved.
//

import Foundation
class ToDoItem{
    var title:String
    var desc:String
    var place:String
    init(_ t:String, _ d:String, _ p:String){
        title = t
        desc = d
        place = p
    }
}
