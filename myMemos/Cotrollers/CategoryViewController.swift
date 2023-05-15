//
//  CategoryViewController.swift
//  myMemos
//
//  Created by Александра Кострова on 14.05.2023.
//

import UIKit
import CoreData

final class CategoryViewController: UITableViewController {

    private var categoriesArray = [Category]()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let request: NSFetchRequest <Category> = Category.fetchRequest()
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCategory))
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Keys.categoryСellIdentifier)
        
        loadCategories()
    }

    // MARK: - Tableview Datasource Methods

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.categoryСellIdentifier,
                                                 for: indexPath as IndexPath)

        let category = categoriesArray[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
//    // MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let memosVC = MemosViewController()
        show(memosVC, sender: self)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            memosVC.selectedCategory = categoriesArray[indexPath.row]
        }
        
        saveCategories()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Data Manipulation Methods

    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }

        self.tableView.reloadData()
    }

    func loadCategories() {

        do {
            categoriesArray = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }

        tableView.reloadData()
    }
    
    // MARK: - Add New Categories
    
    @objc func addNewCategory() {
        
        var categoryTextField = UITextField()

        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add category", style: .default) { _ in
            guard let newCategoryName = categoryTextField.text, !newCategoryName.isEmpty
            else {
                print("There is not a name")
                return
            }

            let newCategory = Category(context: self.context)
            newCategory.name = newCategoryName
            self.categoriesArray.append(newCategory)

            self.saveCategories()
        }

        alert.addTextField { (alertTextField) in alertTextField.placeholder = "Create new category"
            categoryTextField = alertTextField
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
