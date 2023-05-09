//
//  ViewController.swift
//  myMemos
//
//  Created by Александра Кострова on 02.05.2023.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    private var myTableView: UITableView!
    var itemName = ""
    private var namesOfTheNotes = ["First", "Second", "Third", "Fourth", "Fifth"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Memos"
        self.navigationController?.navigationBar.barTintColor = UIColor.green
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                         target: self,
                                         action: #selector(addNewItem))
        addButton.tintColor = .label
        navigationItem.rightBarButtonItem = addButton
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let statusBarHeight = windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let barHeight = statusBarHeight + (self.navigationController?.navigationBar.frame.height ?? 0)
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0,
                                                y: barHeight,
                                                width: displayWidth,
                                                height: displayHeight - barHeight))
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: Keys.cellIdentifier)
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
    }
    
    // MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: Keys.cellIdentifier, for: indexPath as IndexPath)
        cell.textLabel!.text = "\(namesOfTheNotes[indexPath.row])"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesOfTheNotes.count
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
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            self.namesOfTheNotes.append(self.itemName)
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in alertTextField.placeholder = "Create new item"
            self.itemName = alertTextField.text ?? "Not your item"
        }
        present(alert, animated: true, completion: nil)
    }

}
