//
//  ViewController.swift
//  List Me
//
//  Created by Mayura Mathure on 11/05/19.
//  Copyright © 2019 Mayura Mathure. All rights reserved.
//

import UIKit

class ListMeViewController: UITableViewController {
    
    var itemArray = [item]()
    let defaluts = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem1 = item()
        newItem1.title = "Find Mike"
        itemArray.append(newItem1)
        
        let newItem2 = item()
        newItem2.title = "Buy Eggs"
        itemArray.append(newItem2)
        
        let newItem3 = item()
        newItem3.title = "Destroy Demogorgan"
        itemArray.append(newItem3)
        
        if let items = defaluts.array(forKey: "TodoListArray") as? [item]{
            itemArray = items
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
// THE ABOVE LINE IS THE SAME AS THE BOTTOM CODE
        
//        if itemArray[indexPath.row].done == false{
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)


}
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add a New Item", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("success")
            //print(textField.text)
            let newItem = item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaluts.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Crete new item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
    }
    

}
