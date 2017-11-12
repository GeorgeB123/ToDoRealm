//
//  DisplayTasksController.swift
//  ToDoRealm
//
//  Created by George Bonnici-Carter on 11/11/2017.
//  Copyright © 2017 George Bonnici-Carter. All rights reserved.
//
import RealmSwift
import UIKit

var tasks: Results<Task>?
var filteredTasks: Results<Task>?

class DisplayTasksController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating{
    
    //MARK: Properties
    var isSearching = false
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.toDoAppTitle
        tasks = uiRealm.objects(Task.self)
        searchControllerInitializers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        searchController.isActive = false
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let filtered = filteredTasks?.count, isSearching {
            return filtered
        }
        guard let tasksRemaining = tasks?.count else{
            return 0
        }
        return tasksRemaining
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell else{
            fatalError("Cell does not exist")
        }
        guard var task = tasks?[indexPath.row] else {
            fatalError("No cells")
        }
        if let filtered = filteredTasks?[indexPath.row], (isSearching)  {
            task = filtered
        }
        let dateFormatter = dateFormatterConfig()
        cell.date.text = "\(dateFormatter.string(from: task.date as Date))"
        cell.title.text = task.title
        cell.priorityColour = Float(task.priority)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let editTaskController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TaskEditor") as? TaskEditorController else {
            fatalError("View does not exist")
        }
        guard var currentRow = tasks?[indexPath.row] else {
            fatalError("Row does not exist")
        }
        if let filteredRow = filteredTasks?[indexPath.row], (isSearching)  {
            currentRow = filteredRow
        }
        editTaskController.editingTask = currentRow
        self.navigationController!.pushViewController(editTaskController, animated: true)

    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! uiRealm.write {
                guard let rowToDelete = tasks?[indexPath.row] else {
                    fatalError("row can't be deleted")
                }
                uiRealm.delete(rowToDelete)
            }
            self.tableView.reloadData()
        }
    }
    
    //MARK: Actions
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        guard let addTaskController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TaskEditor") as? TaskEditorController else {
            fatalError("View does not exist")
        }
        self.navigationController!.pushViewController(addTaskController, animated: true)
    }

}




