//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Irving Gonzalez on 3/27/18.
//  Copyright © 2018 Crypto Royals. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    //1.) create array
    var categories = [Category]()
    
    //2.) create context to update, destroy, add, remove stuff
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //21 load method called load categories/ does not exist yet but you will create it
        loadCategories()
        
    }
    
    //Mark: - TableView Datasource Methods
    
    // 3 add number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //4 return row count
        return categories.count
    }
    
    //4 add cell for row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //5 check Identifier name by going into main storyboard and add index path
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        //6 add cell text label name
        cell.textLabel?.text = categories[indexPath.row].name
        
        
        //7 return cell
        return cell
    }
    
    
    //Mark: - Data Manipulation Methods
    
    //19 create save categories func
    func saveCategories() {
        
        //20 try to save and do a do/catch block and try to print out the errors
        do {
        try context.save()
        } catch {
            print("Error saving category \(error)")
        }
        
        //21 reload table data
        tableView.reloadData()
    }
    //22 create method load data
    func loadCategories() {
        
        //23 returns array of cateory items and is a braod request(means grab everything
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        //24 then you write this and make it into a try because it might throw errors
        
        do{
        categories = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }
        
        //25 tell table to reload data after fletching all new categories information
        tableView.reloadData()
    }
    
    //Mark: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //12 add var text field / new text field object
        var textField = UITextField()
        
        //8
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        //9 create actoin
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            //15 what happens when user clicks on the plus sign on view controller, add self because its in the brackets
            let newCategory = Category(context: self.context)
            
            //16 adds new category adds from user
            newCategory.name = textField.text!
            
            //17 we are going to grab info from our array
            self.categories.append(newCategory)
            
            //18 create save categories but it doesn't exist yet so create it ;D
            self.saveCategories()
    }
        
        //10 add actoin
        alert.addAction(action)
        
        //11 add text field
        alert.addTextField { (field) in
            
            //13 add new field and text placeholder
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        //14 add animation
        present(alert, animated: true, completion: nil)
        
    }
    //Mark: - Tableview Delegate Methods
    
}
