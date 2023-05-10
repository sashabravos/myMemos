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
    
    private var itemArray = ["First", "Second", "Third", "Fourth", "Fifth"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Memos"
        
        navigationItem.rightBarButtonItem = addButton
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Keys.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        if let items = defaults.array(forKey: Keys.systemItemArray) as? [String] {
            itemArray = items
        }
    }
    
    // MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.cellIdentifier, for: indexPath as IndexPath)
        cell.textLabel!.text = "\(itemArray[indexPath.row])"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print("\(myCellsArray[indexPath.row])")
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else { tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark }
        
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
            
            self.itemArray.append(newItemName)
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
