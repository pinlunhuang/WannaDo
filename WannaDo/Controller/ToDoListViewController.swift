//
//  ViewController.swift
//  WannaDo
//
//  Created by 黃品綸 on 2019/4/24.
//  Copyright © 2019 Pinlun Huang. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    var todoItems : Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
//        let newItem = Item()
//        newItem.title = "Get on the Bus to Taichung"
//        todoItems.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Meet isaac"
//        todoItems.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Go to watch Avengers: EndGame"
//        todoItems.append(newItem3)
        
        loadItems()
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            todoItems = items
//        }
        // Do any additional setup after loading the view.
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemContainer", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            //Ternary operator =>
            // value = condition ? valueIfTrue : valueIfFalse
            
            cell.accessoryType = item.done == true ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
//        print(todoItems[indexPath.row])
        
//        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
        
//        context.delete(todoItems[indexPath.row])
//        todoItems.remove(at: indexPath.row)
//        if todoItems[indexPath.row].done == false {
//            todoItems[indexPath.row].done = true
//        } else {
//            todoItems[indexPath.row].done = false
//        }
        
//        saveItems()
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        if let item = todoItems?[indexPath.row] {
            do {
                try self.realm.write {
                    
//                    realm.delete(item)
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New To Do Item!", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items")
                }
                
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems() {
//        do {
//            try context.save()
//        } catch {
//            print("Error saving context, \(error)")
//        }
//        self.tableView.reloadData()
    }
    
    func loadItems() {
        
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
//
//        do {
//            todoItems = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context, \(error)")
//        }
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
    
}


extension ToDoListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        //let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
//        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request, predicate: predicate)
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchBar.text?.count == 0 {
                loadItems()
                
                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                }
                
            }
        }
        
}
