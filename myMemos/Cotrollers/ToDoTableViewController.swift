//
//  ViewController.swift
//  myMemos
//
//  Created by Александра Кострова on 02.05.2023.
//

import UIKit
import CoreData

class ToDoTableViewController: UITableViewController {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        button.tintColor = .label
        return button
    }()
    
    private var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Memos"
        
        navigationItem.rightBarButtonItem = addButton
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Keys.cellIdentifier)
        print((UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.persistentStoreCoordinator.persistentStores.first?.url)
//        print(dataFilePath)
//        loadItems()
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
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
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
    
    // MARK: - Model Manipulation Methods
    
    func saveItems() {
        do {
            try context.save()
            
        } catch {
            print("Error saving context, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
//    func loadItems() {
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("Error decoding item array, \(error)")
//            }
//        }
//    }
}
