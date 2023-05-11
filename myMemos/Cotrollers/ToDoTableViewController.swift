//
//  ViewController.swift
//  myMemos
//
//  Created by Александра Кострова on 02.05.2023.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        button.tintColor = .label
        return button
    }()
    
    private var itemArray = [Item]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Memos"
        
        navigationItem.rightBarButtonItem = addButton
        
        
        let newItem = Item()
        newItem.title = "Smth"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Smth more"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Smth more more"
        itemArray.append(newItem3)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Keys.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        

//        if let items = defaults.array(forKey: Keys.systemItemArray) as? [String] {
//            itemArray = items
//        }
    }
    
    // MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.cellIdentifier, for: indexPath as IndexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        if item.done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
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
            let newItem = Item()
            newItem.title = newItemName
            self.defaults.set(self.itemArray, forKey: Keys.systemItemArray)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in alertTextField.placeholder = "Create new item"
            addItemTextField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
