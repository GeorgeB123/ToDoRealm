//
//  TaskEditorController.swift
//  ToDoRealm
//
//  Created by George Bonnici-Carter on 11/11/2017.
//  Copyright © 2017 George Bonnici-Carter. All rights reserved.
//
import RealmSwift
import UIKit

class TaskEditorController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var taskTitle:UITextField!
    @IBOutlet weak var taskDescription: UITextView!
    @IBOutlet weak var taskDate: UIDatePicker!
    @IBOutlet weak var taskPriority: UILabel!
    @IBOutlet weak var prioritySlider: UISlider!
    
    var editingTask: Task? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let notEmpty = editingTask {
            self.title = Constants.editTaskTitle
            taskTitle.text = notEmpty.title
            taskDate.date = notEmpty.date as Date
            taskDescription.text = notEmpty.moreInfo
            prioritySlider.value = Float(notEmpty.priority)
            priorityUpdate(sender: prioritySlider)
        } else {
            self.title = Constants.newTaskTitle
            taskPriority.text = Constants.normalPriority
            prioritySlider.minimumTrackTintColor = UIColor.yellow
        }
    }
    
    //MARK: Actions
    
    @IBAction func SaveTask(_ sender: UIBarButtonItem) {
        createOrUpdateTask()
        try! uiRealm.write({ () -> Void in
            //force unwrapping here but I know it will not be nil through previous checks
            uiRealm.add(editingTask!)
        })
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func BackToMainDisplay(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sliderValueDidChange(_ sender: UISlider) {
        priorityUpdate(sender: sender)
    }
    
}

//MARK: Private Functions

extension TaskEditorController {
    
    func createOrUpdateTask() {
        if let notEmpty = editingTask {
            try! uiRealm.write {
                notEmpty.title = taskTitle.text!
                notEmpty.moreInfo = taskDescription.text
                notEmpty.date = taskDate.date as NSDate
                notEmpty.priority = Double(prioritySlider.value)
            }
        }else {
            let taskToSave = Task()
            taskToSave.title = taskTitle.text!
            taskToSave.moreInfo = taskDescription.text
            taskToSave.date = taskDate.date as NSDate
            taskToSave.priority = Double(prioritySlider.value)
            editingTask = taskToSave
        }
    }
    
    func priorityUpdate(sender: UISlider) {
        if sender.value <= Constants.lowerBounds {
            sender.minimumTrackTintColor = UIColor.green
            taskPriority.text = Constants.lowPriority
        } else if sender.value > Constants.lowerBounds && sender.value <= Constants.upperBounds {
            sender.minimumTrackTintColor = UIColor.yellow
            taskPriority.text = Constants.normalPriority
        } else {
            sender.minimumTrackTintColor = UIColor.red
            taskPriority.text = Constants.highPriority
        }
    }
}
