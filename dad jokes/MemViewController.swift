//
//  MemViewController.swift
//  dad jokes
//
//  Created by Stacey Li on 11/4/20.
//  source used: https://youtu.be/gWurhFqTsPU

import Foundation
import UIKit
import CoreData

class MemViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items:[Jokes]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        fetchJokes()
    }
    
    func fetchJokes(){
        do {
            self.items = try context.fetch(Jokes.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            print ("failed")
        }
    }
}

//extend the viewcontroller so that it populates cells with jokes
extension MemViewController: UITableViewDataSource, UITableViewDelegate{
    
//    set the number of rows in tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return number of jokes
        return self.items?.count ?? 0
    }
    
//    populate cell with jokes from core data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
//        get joke from array and set label
        let joke_cell = self.items![indexPath.row]
        cell.textLabel?.font = UIFont(name: "Avenir", size: 20)
        cell.textLabel?.text = joke_cell.joke
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        return cell
    }
    
//    delete action
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "unsave") {(action, view, completionHandler) in
            
            let jokeToRemove = self.items![indexPath.row]
            self.context.delete(jokeToRemove)
            do {
                try self.context.save()
            }
            catch {
                print("fail")
            }
            self.fetchJokes()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
