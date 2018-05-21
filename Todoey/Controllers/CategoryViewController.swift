//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Jessica Parish on 12/04/2018.
//  Copyright © 2018 Jessica Parish. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var catArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadCats()
    }
    
    //MARK: - TableView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let cat = catArray[indexPath.row]
        cell.textLabel?.text = cat.name
        
        // Ternary Operator
        // value = condition ? valueIfTrue : valueIfFalse
        
        // cell.accessoryType = cat.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveCats() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCats(with request : NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            catArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    
    //MARK: - Add New Categories
    
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //what will happen when the user clicks the add category button on our UIAlert
            let newCat = Category(context: self.context)
            newCat.name = textField.text!
            //newItem.done = false
            self.catArray.append(newCat)
            self.saveCats()
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add New Category"
        }
        present(alert, animated: true, completion: nil)
    }
    
    
    
    //MARK: - TableView Delegate Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = catArray[indexPath.row]
        }
    }
    
}


