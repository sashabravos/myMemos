//
//  CategoryViewController.swift
//  myMemos
//
//  Created by Александра Кострова on 14.05.2023.
//

import UIKit

final class CategoryViewController: UITableViewController {

    let testArray = ["a", "b", "c", "d"]
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        button.tintColor = .label
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // setup navigationBar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Memos"
        navigationItem.rightBarButtonItem = addButton
        
        // register cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Keys.memosCellIdentifier)
    }

    // MARK: - Tableview data source

    
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

    // MARK: - Add New Items
    
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
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
