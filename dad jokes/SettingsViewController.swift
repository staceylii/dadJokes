//
//  SettingsViewController.swift
//  dad jokes
//
//  Created by Stacey Li on 11/30/20.
// pickerview source: https://www.youtube.com/watch?v=QdLFd3wNqV8

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var musicSwitch: UISwitch!
//    var musicSaved: Bool!
    
    let dadLocations = ["Home Depot", "barbecue", "fishing", "sleeping on the couch", "shopping for Nike Air Monarchs"]
    
    var pickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
//        extend keyboard functions so keyboard goes away on tap
//        source: https://medium.com/infancyit/extend-those-native-classes-208bdf5b36f3
        self.hideKeyboardWhenTappedAround()
//        instantiate userdefault keys
        textField.text = UserDefaults.standard.string(forKey: "Name")
        locationField.text = UserDefaults.standard.string(forKey: "Location")
        pickerView.delegate = self
        pickerView.dataSource = self
//        design of textfields
        textField.textAlignment = .center
        locationField.inputView = pickerView
        locationField.textAlignment = .center
        locationField.placeholder = "location"
//        load in the musicswitch defaults
        musicSwitch.isOn =  UserDefaults.standard.bool(forKey: "music")
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        musicSwitch.isOn = UserDefaults.standard.bool(forKey: "music")
//    }
    
    //pickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }

    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dadLocations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dadLocations[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        locationField.text = dadLocations[row]
        locationField.resignFirstResponder()
    }
    
//    end pickerview delegate
    
//    @IBAction func playMusic(_ sender: UISwitch) {
//        if sender.isOn{
//            UserDefaults.standard.set(true, forKey: "music")
//            print(UserDefaults.standard.bool(forKey: "music"))
//        }
//        else {
//            UserDefaults.standard.set(false, forKey: "music")
//            print(UserDefaults.standard.bool(forKey: "music"))
//        }
////        UserDefaults.standard.set(sender.isOn, forKey: "music")
//    }
    
    @IBAction func saveButton(sender: UIButton) {
           
        let name = textField.text
        let location = locationField.text
        
//        set userdefaults for 2 fields
        UserDefaults.standard.set(name, forKey: "Name")
        UserDefaults.standard.set(location, forKey: "Location")
        print(UserDefaults.standard.string(forKey: "Location")!)
        
//        save the user input in the textfield
        textField.text = name
        textField.resignFirstResponder()
        
//      switch placed here so that if save is not pressed, don't save
        if musicSwitch.isOn{
            UserDefaults.standard.set(true, forKey: "music")
            print(UserDefaults.standard.bool(forKey: "music"))
        }
        else {
            UserDefaults.standard.set(false, forKey: "music")
            print(UserDefaults.standard.bool(forKey: "music"))
        }
        
    }

}

//extend keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

