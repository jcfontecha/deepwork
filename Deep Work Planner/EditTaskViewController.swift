//
//  EditTaskViewController.swift
//  Test2
//
//  Created by Juan Carlos Fontecha on 3/12/16.
//  Copyright © 2016 Juan Carlos Fontecha. All rights reserved.
//

import Cocoa

protocol EditTaskPopoverDelegate {
    func editTaskPopover(popover: EditTaskViewController, didEditTask task: Task)
}

class EditTaskViewController: NSViewController {

    var task: Task?
    var delegate: EditTaskPopoverDelegate?
    
    @IBOutlet weak var taskNameTextField: NSTextField!
    @IBOutlet weak var sessionsTextField: NSTextField!
    @IBOutlet weak var sessionsStepper: NSStepper!
    @IBOutlet weak var completedCheckBox: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let task = self.task else { return }
        
        taskNameTextField.stringValue = task.name
        sessionsTextField.stringValue = "\(task.sessions)"
        sessionsStepper.integerValue = task.sessions
        completedCheckBox.state = task.completed ? NSOnState : NSOffState
    }
    
    @IBAction func sessionsStepperChanged(sender: NSStepper) {
        sessionsTextField.integerValue = sessionsStepper.integerValue
    }
    
    @IBAction func saveButtonClicked(sender: AnyObject) {
        saveTask()
        delegate?.editTaskPopover(self, didEditTask: task!)
        dismissController(nil)
    }
    
    func saveTask() {
        if task == nil { task = Task() }
        
        task!.name = taskNameTextField.stringValue
        task!.sessions = sessionsStepper.integerValue
        task!.completed = completedCheckBox.state == NSOnState ? true : false
    }
    
    @IBAction func didEditTaskName(sender: NSTextField) {
        saveButtonClicked(self)
    }
}
