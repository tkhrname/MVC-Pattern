//
//  Task.swift
//  MVC-Pattern
//
//  Created by 渡邊丈洋 on 2019/03/10.
//  Copyright © 2019 渡邊丈洋. All rights reserved.
//

import Foundation

class Task {
    let text: String
    let deadline: Date
    
    init(text: String, deadline: Date) {
        self.text = text
        self.deadline = deadline
    }
    
    //
    init(from dictionary: [String: Any]) {
        self.text = dictionary["text"] as! String
        self.deadline = dictionary["deadline"] as! Date
    }
}
