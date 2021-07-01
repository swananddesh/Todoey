//
//  ViewController.swift
//  Todoey
//
//  Created by Swanand Deshpande on 28/06/21.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Buy Milk", "Buy Maggie", "Buy Fruits"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    // MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(itemArray[indexPath.row])")
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark // Add checkmark as an accessory to selected row.
        }
        
        tableView.deselectRow(at: indexPath, animated: true) // Row highlight.
    }
    

    // MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        // Create Alert
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        // Action button for user to click once he/she enters ToDo item
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            
            self.itemArray.append(textField.text!)
            self.tableView.reloadData() // Refresh tableview once new item is added.
            
        }
        
        // Add TextField to alert so that user can enter his/her ToDo item
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item" // Hint
            textField = alertTextField
        }
        
        // Add action to alert
        alert.addAction(action)
        
        // Show alert
        present(alert, animated: true, completion: nil)
    }
    
}

