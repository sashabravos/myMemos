//
//  ViewController.swift
//  myMemos
//
//  Created by Александра Кострова on 02.05.2023.
//

import UIKit
import CoreData

class ToDoTableViewController: UITableViewController, UISearchBarDelegate {//}, UISearchResultsUpdating {

    private var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    private var searchController: UISearchController = {
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.obscuresBackgroundDuringPresentation = true
//        searchController.searchBar.placeholder = "Search"
//        return searchController
//    }()
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        button.tintColor = .label
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        print((UIApplication.shared.delegate as! AppDelegate)
        //            .persistentContainer.persistentStoreCoordinator.persistentStores.first?.url)
        
        // setup navigationBar
        self.title = "Memos"
        navigationItem.rightBarButtonItem = addButton
        
        // setup searchBar
//        tableView.tableHeaderView = searchController.searchBar
//        searchController.searchBar.delegate = self
//        searchController.searchResultsUpdater = self
//        definesPresentationContext = true
        let searchBar = UISearchBar()
                searchBar.searchBarStyle = .minimal
                searchBar.placeholder = "Search"
                searchBar.tintColor = .black
                searchBar.delegate = self
                navigationItem.titleView = searchBar
        
        // register cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Keys.cellIdentifier)
        
        loadItems()
    }
    
    // MARK: - Add New Items
    
    @objc func addNewItem() {
        
        var addItemTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { _ in
            guard let newItemName = addItemTextField.text, !newItemName.isEmpty else {
                print("There is not a name")
                return
            }
            
            let newItem = Item(context: self.context)
            newItem.title = newItemName
            newItem.done = false
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in alertTextField.placeholder = "Create new item"
            addItemTextField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.cellIdentifier, for: indexPath as IndexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        context.delete(itemArray[indexPath.row])
        //        itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Model Manipulation Methods
    
    func saveItems() {
        do {
            try context.save()
            
        } catch {
            print("Error saving context, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        let request: NSFetchRequest <Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    // MARK: - Search Bar Methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let search = searchController.searchBar
        let request: NSFetchRequest <Item> = Item.fetchRequest()
        print(searchBar.text)

//        print(search.text)
    }
    
//    func updateSearchResults(for searchController: UISearchController) {
////        let request: NSFetchRequest <Item> = Item.fetchRequest()
////
////        print(searchController.searchBar.text)
//        print("update is working")
//    }
}
