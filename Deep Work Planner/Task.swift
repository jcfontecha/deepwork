//
//  Task.swift
//  Test2
//
//  Created by Juan Carlos Fontecha on 3/8/16.
//  Copyright © 2016 Juan Carlos Fontecha. All rights reserved.
//

import Foundation

class Task: NSObject {
    var name = ""
    var sessions = 1
    var sessionsCompleted = 0
    var completed = false
    
    override init() {
        super.init()
    }
    
    convenience init(name: String) {
        self.init();
        self.name = name
    }
    
    func nextSession() -> Bool {
        return sessionsCompleted < sessions
    }
}