//
//  TaskTableCellView.swift
//  Test
//
//  Created by Juan Carlos Fontecha on 3/6/16.
//  Copyright © 2016 Juan Carlos Fontecha. All rights reserved.
//

import Cocoa

protocol TaskTableCellViewDelegate {
    func cell(cell: NSTableCellView, didFinishEditingTaskName taskName: String)
    func cell(cell: TaskTableCellView, didSelectNumberOfSessions sessions: Int)
}

class TaskTableCellView: NSTableCellView {

    var delegate: TaskTableCellViewDelegate?
    var sessions = 1
    var maxSessions = 4
    
    override var backgroundStyle: NSBackgroundStyle {
        get {
            return self.backgroundStyle
        }
        
        set {

        }
    }
    
    var taskName: String = "" {
        didSet {
            taskLabel.stringValue = taskName
        }
    }
    
    @IBOutlet weak var taskLabel: NSTextField!
    
    @IBOutlet weak var sessionsStackView: NSStackView!
    
    @IBOutlet weak var settingsButton: NSButton!
    @IBOutlet weak var settingsButtonTrailingConstraint: NSLayoutConstraint!
    
    func createSessionButton() -> NSButton {
        let buttonFrame = CGRectMake(0, 0, sessionsStackView.frame.size.height, sessionsStackView.frame.size.height)
        let button = NSButton(frame: buttonFrame)
        button.setButtonType(.SwitchButton)
        button.image = NSImage(named: "session_inactive")
        button.alternateImage = NSImage(named: "session_active")
        button.stringValue = ""
        button.title = ""
        (button.cell as! NSButtonCell).imageScaling = .ScaleProportionallyDown
        
        button.target = self
        button.action = "sessionClicked:"
        
        sessionsStackView.addView(button, inGravity: .Bottom)
        
        //button.topAnchor.constraintEqualToAnchor(sessionsStackView.topAnchor).active = true
        //button.bottomAnchor.constraintEqualToAnchor(sessionsStackView.bottomAnchor).active = true
        button.frame.size.height = 13
        button.widthAnchor.constraintEqualToAnchor(button.heightAnchor).active = true
        
        return button
    }
    
    func sessionClicked(sender: AnyObject) {
        
    }
    
    
    @IBAction func didEditTextField(sender: AnyObject) {
        taskName = taskLabel.stringValue
        delegate?.cell(self, didFinishEditingTaskName: taskName)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let area = NSTrackingArea(rect: bounds, options: [.ActiveInKeyWindow, .MouseEnteredAndExited], owner: self, userInfo: nil)
        addTrackingArea(area)
        
        // Hide the button
        settingsButtonTrailingConstraint.constant = -settingsButton.frame.size.width - 8
        
        for _ in 0..<maxSessions {
            createSessionButton()
        }
    }
    
    override func mouseEntered(theEvent: NSEvent) {
        super.mouseEntered(theEvent)
        settingsButtonTrailingConstraint.animator().constant = 8
    }
    
    override func mouseExited(theEvent: NSEvent) {
        super.mouseExited(theEvent)
        settingsButtonTrailingConstraint.animator().constant = -settingsButton.frame.size.width - 8
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
}
