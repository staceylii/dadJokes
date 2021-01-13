//
//  ViewController.swift
//  dad jokes
//
//  Created by Stacey Li on 11/3/20.
//

import UIKit
import CoreData
import AVFoundation

class HomeViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var playMusic: Bool!
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var missedLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        design of label
        missedLabel.isHidden = true
        missedLabel.layer.masksToBounds = true
        missedLabel.layer.cornerRadius = 5
        
//        testing purposes
//        print(missedLabel.alpha)
//        print("View has loaded")
//        print(UserDefaults.standard.string(forKey: "Name")!)
    }
    
//    putting userdefaults in separate function will allow it to update asap
    override func viewWillAppear(_ animated: Bool) {
        let music = UserDefaults.standard.bool(forKey: "music")
        playMusic = music
//        print("HANNAH MONTANA MUSIC: ", playMusic!)
        let name = UserDefaults.standard.string(forKey: "Name") ?? ""
        let dadlocation = location()
        let welcomeName = "Get in " + name + ", " + dadlocation
        let welcome = "Get a load of this guy 😎"
        
        if UserDefaults.standard.string(forKey: "Name") == nil || UserDefaults.standard.string(forKey: "Name") == "" || UserDefaults.standard.string(forKey: "Location") == nil{
            self.displayLabel.text = welcome
        } else {
            self.displayLabel.text = welcomeName
        }
    }
    
//    takes location userdefaults to turn it into a sentence
    func location() -> String{
        let location = UserDefaults.standard.string(forKey: "Location")
        var response: String?
        
        if location == "Home Depot" {
            response = "we're going to Home Depot."
        } else if location == "barbecue" {
            response = "we're going to find other dads to compare barbecues with."
        } else if location == "fishing" {
            response = "we're going fishing."
        } else if location == "sleeping on the couch" {
            response = "we're going to find a couch to sleep on."
        }
            else if location == "shopping for Nike Air Monarchs" {
            response = "we're going " + location! + "."
        }
        return response ?? "we're mowing the lawn."
    }
    
    @IBAction func jokeButtonPressed(sender: UIButton){
        print("joke button pressed")
    //        play hannah montana music
        if playMusic == true || playMusic == nil {
            if let soundURL = Bundle.main.url(forResource: "iOS_yeah", withExtension: "mp3", subdirectory: "Audio") {
                    
                        do {
                            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                            print("played joke audio")
                        }
                        catch {
                            print(error)
                        }
                        
                        audioPlayer.play()
                    }else{
                        print("Unable to locate audio file")
                    }
        }
//      transition to joke
//        self.performSegue(withIdentifier: "JokeViewSegue", sender: self)
    }
    
    @IBAction func memButtonPressed(sender: UIButton){
        print("mem joke button pressed")
        //        play hannah montana music
        if playMusic == true || playMusic == nil{
            if let soundURL = Bundle.main.url(forResource: "iOS_mems", withExtension: "mp3", subdirectory: "Audio") {
                    
                        do {
                            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                            print("played mem audio")
                        }
                        catch {
                            print(error)
                        }
                        
                        audioPlayer.play()
                    }else{
                        print("Unable to locate audio file")
                    }
        }
    }
    
//    animate label when they miss a joke
    @IBAction func missedButtonPressed(sender: UIButton){
        print("missed joke button pressed")
        //        play hannah montana music
        if playMusic || playMusic == nil{
            if let soundURL = Bundle.main.url(forResource: "iOS_missed", withExtension: "mp3", subdirectory: "Audio") {
                    
                        do {
                            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                            print("played missed audio")
                        }
                        catch {
                            print(error)
                        }
                        
                        audioPlayer.play()
                    }else{
                        print("Unable to locate audio file")
                    }
        }
        animateLabel()
    }
    
//    set alpha to 1 when this function is called so it appears with each button click
    func animateLabel(){
        missedLabel.isHidden = false
        self.missedLabel.alpha = 1
        missedLabel.text = "Go back to the pond if you're going to be such a silly goose."
        UIView.animate(withDuration: 8, animations: { () -> Void in
            self.missedLabel.alpha = 0
        })
    }
    
    @IBAction func settingsButtonPressed(sender: UIButton){
        print("settings joke button pressed")
        //        play hannah montana music
        if playMusic == true || playMusic == nil{
            if let soundURL = Bundle.main.url(forResource: "iOS_settings", withExtension: "mp3", subdirectory: "Audio") {
                    
                        do {
                            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                            print("played settings audio")
                        }
                        catch {
                            print(error)
                        }
                        
                        audioPlayer.play()
                    }else{
                        print("Unable to locate audio file")
                    }
        }
    }
    
}

