//
//  DisplayTasksExtensions.swift
//  ToDoRealm
//
//  Created by George Bonnici-Carter on 12/11/2017.
//  Copyright © 2017 George Bonnici-Carter. All rights reserved.
//
import RealmSwift
import UIKit

//MARK: Update Search Results Delegate
extension DisplayTasksController  {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty{
            isSearching = true
            filteredTasks = tasks?.filter("SELF.title CONTAINS [c]%@", searchText)
        } else {
            isSearching = false
            filteredTasks = tasks
        }
        self.tableView.reloadData()
    }
    
}

//MARK: Search Bar Delegate

extension DisplayTasksController {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterSearchController(searchBar: searchBar)
    }
    
    func filterSearchController(searchBar: UISearchBar){
        guard let scopeString = searchBar.scopeButtonTitles?[searchBar.selectedScopeButtonIndex] else { return }
        if scopeString == Constants.scopeButtonPriority{
            isSearching = true
            filteredTasks = tasks?.sorted(byKeyPath: "priority", ascending: false)
        }else if scopeString == Constants.scopeButtonDate{
            isSearching = true
            filteredTasks = tasks?.sorted(byKeyPath: "date", ascending: false)
        }
        tableView.reloadData()
    }

}

//MARK: Private Methods

extension DisplayTasksController {
    
    func searchControllerInitializers() {
        searchController.searchBar.delegate = self
        searchController.searchBar.scopeButtonTitles = Constants.differentSearchButtonCriteria
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext=true
        self.navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        self.navigationItem.hidesSearchBarWhenScrolling = false;
    }
    
    func dateFormatterConfig() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateFormat = Constants.dateFormat
        return dateFormatter
    }
}
