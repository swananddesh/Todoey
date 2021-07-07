//
//  ViewController.swift
//  Todoey
//
//  Created by Swanand Deshpande on 28/06/21.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard // Create UserDefaults

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let newItem = Item()
        newItem.title = "Buy Milk"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Maggie"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Buy Fruits"
        itemArray.append(newItem3)
        
        // Fetch stored UserDefaults data if any.
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
        
    }
    
    //MARK - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    // MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(itemArray[indexPath.row])")
        
        // Toggle the checkmark on selection.
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        // Refresh the tableView.
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true) // Row highlight.
    }
    

    // MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        // Create Alert
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        // Action button for user to click once he/she enters ToDo item
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            // Add newly created To-Do item to UserDefaults.
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
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

