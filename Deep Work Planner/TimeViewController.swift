//
//  TimeViewController.swift
//  Deep Work Planner
//
//  Created by Juan Carlos Fontecha on 3/14/16.
//  Copyright © 2016 Juan Carlos Fontecha. All rights reserved.
//

import Cocoa

class TimeViewController: NSViewController {

    @IBOutlet weak var visualEffectsView: NSVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        visualEffectsView.material = .Menu
    }
    
}
