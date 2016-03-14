//
//  TaskTableRowView.swift
//  Test
//
//  Created by Juan Carlos Fontecha on 3/7/16.
//  Copyright © 2016 Juan Carlos Fontecha. All rights reserved.
//

import Cocoa

class TaskTableRowView: NSTableRowView {
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    override func drawSelectionInRect(dirtyRect: NSRect) {
        if selectionHighlightStyle != .None {
            NSColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1).setFill()
            NSRectFill(dirtyRect)
        }
    }
}
