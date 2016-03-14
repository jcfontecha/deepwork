//
//  TaskListViewController.swift
//  Test2
//
//  Created by Juan Carlos Fontecha on 3/8/16.
//  Copyright © 2016 Juan Carlos Fontecha. All rights reserved.
//

import Cocoa

class TaskListViewController: NSViewController, TaskTableCellViewDelegate, EditTaskPopoverDelegate {
    
    // Model
    var tasks = [Task]()
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var addButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Para reordenar arrastrando
        tableView.registerForDraggedTypes([rowType, NSFilenamesPboardType])
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d, yyyy"
        //dateLabel.stringValue = dateFormatter.stringFromDate(NSDate())
    }
    
    @IBAction func addButtonTapped(sender: NSButton) {
        tasks.append(Task(name: "Untitled"))
        tableView.insertRowsAtIndexes(NSIndexSet(index: tableView.numberOfRows), withAnimation: .SlideLeft)
        let cell = tableView.viewAtColumn(0, row: tableView.numberOfRows - 1, makeIfNecessary: true) as! TaskTableCellView
        
        cell.delegate = self
        makeEditable(cell)
    }
    
    func makeEditable(cellView: TaskTableCellView) {
        if !cellView.taskLabel.editable {
            cellView.taskLabel.editable = true
        }
        
        cellView.taskLabel.becomeFirstResponder()
    }

    @IBAction func doubleClick(sender: NSTableView) {
        let row = tableView.clickedRow
        if row < 0 { return }
        
        tableView.deselectRow(row)
        let cellView = tableView.viewAtColumn(0, row: row, makeIfNecessary: false) as! TaskTableCellView
        makeEditable(cellView)
    }

    // MARK: - EditTaskPopoverDelegate
    
    func editTaskPopover(popover: EditTaskViewController, didEditTask task: Task) {
        tasks.append(task)
        tableView.insertRowsAtIndexes(NSIndexSet(index: tableView.numberOfRows), withAnimation: .SlideLeft)
    }
    
    // MARK: - NSTableViewDataSource
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return tasks.count
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let cell = tableView.makeViewWithIdentifier("TaskCell", owner: nil)
        return cell!.frame.height
    }
    
    // MARK: - TaskTableCellViewDelegate
    
    func cell(cell: NSTableCellView, didFinishEditingTaskName taskName: String) {
        let index = tableView.rowForView(cell)
        tasks[index] = Task(name: taskName)
        
        let cellView = cell as! TaskTableCellView
        cellView.taskLabel.editable = false
    }
    
    func cell(cell: TaskTableCellView, didSelectNumberOfSessions sessions: Int) {
        tasks[tableView.rowForView(cell)].sessions = sessions
        updateDetail()
    }
    
    // MARK: - NSTableViewDelegate
    
    let rowType = "TaskRow"
    
    func tableView(tableView: NSTableView, writeRowsWithIndexes rowIndexes: NSIndexSet, toPasteboard pboard: NSPasteboard) -> Bool {
        
        let data = NSKeyedArchiver.archivedDataWithRootObject([rowIndexes])
        pboard.declareTypes([rowType], owner:self)
        pboard.setData(data, forType:rowType)
        
        return true
    }
    
    func tableView(tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableViewDropOperation) -> NSDragOperation {
        
        tableView.setDropRow(row, dropOperation: NSTableViewDropOperation.Above)
        return NSDragOperation.Move
    }
    
    func tableView(tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableViewDropOperation) -> Bool {
        
        let pboard = info.draggingPasteboard()
        let rowData = pboard.dataForType(rowType)
        
        if rowData != nil {
            let rowIndexes = NSKeyedUnarchiver.unarchiveObjectWithData(rowData!) as! Array<NSIndexSet>
            let dragRow = rowIndexes[0].firstIndex
            
            if dragRow == row { return true }
            
            tasks.insert(tasks[dragRow], atIndex: row)
            tasks.removeAtIndex(dragRow > row ? dragRow + 1 : dragRow)
            
            tableView.noteNumberOfRowsChanged()
            tableView.reloadData()
            
            return true
        }
        
        return false
    }
    
    func tableView(tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return TaskTableRowView()
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if let cell = tableView.makeViewWithIdentifier("TaskCell", owner: nil) as? TaskTableCellView {
            cell.taskName = tasks[row].name
            cell.delegate = self
            return cell
        }
        
        return nil
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        updateDetail()
    }
    
    func updateDetail() {
        if tableView.selectedRow < 0 {
            //detailViewController?.task = nil
        } else if tableView.selectedRow < tasks.count {
            //detailViewController?.task = tasks[tableView.selectedRow]
        }
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addTask" {
            let destVC = segue.destinationController as! EditTaskViewController
            destVC.delegate = self
        }
    }
}
