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
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        print(dataFilePath!)
        

        loadItems()
        
//        if let items = defaluts.array(forKey: "TodoListArray") as? [item]{
//            itemArray = items
//        }
        
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

        saveItems()
      
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
            
            
            self.saveItems()
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Crete new item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        
        do{
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
            
        }
        catch{
            print(error)
        }
    }
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                try itemArray = decoder.decode([item].self, from: data)
            }
            catch{
                print(error)
            }
        }
    }

}
