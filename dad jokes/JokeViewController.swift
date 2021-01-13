//
//  JokeViewController.swift
//  dad jokes
//
//  Created by Stacey Li on 11/3/20.
//

import UIKit
import CoreData

class JokeViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var buttonTitle: UIButton!
    var status: Int?
    var joke: String?
    var id: String?
    var previous: String? //sets to previous id
//    container for core data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJoke(url_string: "https://icanhazdadjoke.com")
//        when previous button clicked on launch, show default joke
        previous = "R7UfaahVfFd" 
    }

//    load joke takes in url because there are 2 different API calls
    func loadJoke(url_string: String) {
        let url = URL(string: url_string)!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            self.joke = dataDictionary["joke"] as! String
            self.status = dataDictionary["status"] as! Int
            self.id = dataDictionary["id"] as! String
//            testing purposes
            print("Here is the current joke and id")
            print(self.joke!, self.id!)
            
//            display joke
            DispatchQueue.main.async {
                self.displayLabel.text = self.joke
                        }
           }
        }
        task.resume()
    }
    
//    add joke to the core data
    @IBAction func SaveButtonPressed(sender: UIButton){
        print("Save joke button pressed")

        let entity = NSEntityDescription.entity(forEntityName: "Jokes", in: self.context)
        let newJoke = NSManagedObject(entity: entity!, insertInto: self.context)
        newJoke.setValue(status, forKey: "status")
        newJoke.setValue(id, forKey: "id")
        newJoke.setValue(joke, forKey: "joke")
        do {
            try self.context.save()
          } catch {
           print("Failed saving")
        }
    }
    
    @IBAction func RefreshButtonPressed(sender: UIButton){
        print(" ")
        print(" ")
        print("refresh joke button pressed")
        
        previous = id
        print("here is what i just saved: " + previous!)
        loadJoke(url_string: "https://icanhazdadjoke.com")
        print(" ")
    }
    
//    pass in parameterized API call
    @IBAction func PreviousButtonPressed(sender: UIButton){
        print(" ")
        print(" ")
        print("previous joke button pressed")
        
        let url = "https://icanhazdadjoke.com/j/" + previous!
        previous = id
        print("here is what I just saved: " + previous!)
        print("here is the url" + url)
        loadJoke(url_string: url)
        print(" ")
    }
    
}

