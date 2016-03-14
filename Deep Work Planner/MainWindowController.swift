//
//  MainWindowController.swift
//  Deep Work Planner
//
//  Created by Juan Carlos Fontecha on 3/13/16.
//  Copyright © 2016 Juan Carlos Fontecha. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        window?.titleVisibility = .Hidden
        window?.titlebarAppearsTransparent = true
        window?.styleMask |= NSFullSizeContentViewWindowMask
        window?.movableByWindowBackground = true
    }

}
