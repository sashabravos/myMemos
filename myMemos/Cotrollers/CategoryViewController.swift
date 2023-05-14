//
//  CategoryViewController.swift
//  myMemos
//
//  Created by Александра Кострова on 14.05.2023.
//

import UIKit
import CoreData

final class CategoryViewController: UITableViewController {

    let testArray = ["a", "b", "c", "d"]
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        button.tintColor = .label
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//         self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // setup navigationBar
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Memos"
        navigationItem.rightBarButtonItem = addButton
        
        // register cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Keys.memosCellIdentifier)
    }

    // MARK: - Tableview Datasource Methods

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.memosCellIdentifier, for: indexPath as IndexPath)
        cell.textLabel!.text = "\(testArray[indexPath.row])"
        return cell
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
//    // MARK: - Tableview Delegate Methods
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//        
//        saveItems()
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    // MARK: - Add New Categories
    
    @objc func addNewItem() {
        
//        var addItemTextField = UITextField()
//
//        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
//
//        let action = UIAlertAction(title: "Add item", style: .default) { _ in
//            guard let newItemName = addItemTextField.text, !newItemName.isEmpty else {
//                print("There is not a name")
//                return
//            }
//
//            let newItem = Item(context: self.context)
//            newItem.title = newItemName
//            newItem.done = false
//            self.itemArray.append(newItem)
//
//            self.saveItems()
//        }
//
//        alert.addTextField { (alertTextField) in alertTextField.placeholder = "Create new item"
//            addItemTextField = alertTextField
//        }
//
//        alert.addAction(action)
//        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Data Manipulation Methods

}
