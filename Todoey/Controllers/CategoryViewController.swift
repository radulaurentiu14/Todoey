//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Codehouse on 2/12/19.
//  Copyright © 2019 Codehouse. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        

        
    }
     //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)

//        categories[indexPath.row].done = !categories[indexPath.row].done
//
//        saveCategories()
//
//        tableView.deselectRow(at: indexPath, animated: true)


    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
    
    //MARK: - Add new Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
            var textField = UITextField()
            
            let alert = UIAlertController(title: "Add new Todoey", message: "", preferredStyle: .alert
            )
            let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
                
                
                
                let newCategory = Category(context: self.context)
                newCategory.name = textField.text!
                
                self.categories.append(newCategory)
                
                self.saveCategories()
                
                
                
                
            }
    
            alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new Category"
            
        }
            
            present(alert, animated: true, completion: nil)
            
        }
        
    
   
    
    
    
    //MARK: - Data Manipulation Methods
    
    func saveCategories() {
        
        do {
            try context.save()
        }
            
        catch {
            print("Error saving category \(error)")
            
        }
        self.tableView.reloadData()
        
    }
    
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        
        
        do {
            categories = try context.fetch(request)
        }
        catch {
            print( "Error fetching data from context \(error)")
        }
        tableView.reloadData()
        
    }
    
}
