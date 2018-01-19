//
//  ViewController.swift
//  BullsEye
//
//  Created by rohit gupta on 1/14/18.
//  Copyright © 2018 rohit gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //instance variables
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score = 0
    var round = 0
    
    //outlets for slide, labels
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    //@IBOutlet weak var startOverLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//         Do any additional setup after loading the view, typically from a nib.
        startNewRound()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //updates variables and calls a function that spits those changes to the UI
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    //spits the updates labels to UI
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    //resets the game
    @IBAction func startNewGame()
    {
        round = 0
        score = 0
        startNewRound()
    }
    
    //calculates the users performance for each round.
    //Based on the accuracy sends an alert with a text message
    //upon clicking 'OK' the user the game then progresses to the next round
    @IBAction func showAlert() {
        
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference // change let to var
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100 // add this line
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 { // add these lines
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        score += points


        let message = "You scored \(points) points"
        let alert = UIAlertController(title: title,
            message: message,
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default,
                                   handler: { action in
                                    self.startNewRound()
                                   })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    //gets current value of the slider
    @IBAction func sliderMoved(_ slider: UISlider) {
        //print("The value of the slider is now: \(slider.value)")
        currentValue = lroundf(slider.value)
    }
}

