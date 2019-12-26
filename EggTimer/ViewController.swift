//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    //IOBOutlets
    @IBOutlet weak var secondsRemainingLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //Variables
    let eggTimes = ["Soft":3, "Medium": 4, "Hard":60]
    var secondsRemaining : Int = 0
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0

    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate() //Stops the timer if another egg is tapped
        progressBar.setProgress(0, animated: true)
        

        let hardness = sender.currentTitle! //Get the total amount of seconds
        
        titleLabel.text = hardness
        //Set the total time and secondsRemaining variables
        totalTime = eggTimes[hardness]!
        secondsPassed = 0
        secondsRemaining = totalTime
        secondsRemainingLabel.text = String(secondsRemaining)+"s"
        
        //Start the timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
    }
    
    @objc func update() {
        
        print("COUNTER: \(secondsRemaining)")
        
        if secondsPassed < totalTime {
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            print("PERCENTAGE PROGRESS: \(percentageProgress)")
            progressBar.setProgress(percentageProgress, animated: true)
            secondsRemaining -= 1
            secondsRemainingLabel.text = String(secondsRemaining)+"s"
        }
        
        if(secondsPassed == totalTime){
            timer.invalidate()
            secondsRemainingLabel.text = "Done!"
            playSound()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
}
