//
//  TimerViewController.swift
//  Tea Journal
//
//  Created by Polina Fiksson on 07/03/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit
import AVFoundation


class TimerViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var sliderTime: UISlider!
    
    @IBOutlet weak var startB: UIButton!
    @IBOutlet weak var stopB: UIButton!
    
    var seconds = 60
    var timer = Timer()
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timeLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 100)
        
        
        do{
            let audioPath = Bundle.main.path(forResource: "alarm", ofType: "mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        }
        catch{
            //error
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func sliderDragged(_ sender: UISlider) {
        seconds = Int(sender.value)
        let minutes = seconds / 60;
        let seconds2 = seconds % 60;
        timeLabel.text = "\(minutes) : \(seconds2)"
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.counter), userInfo: nil, repeats: true)
        sliderTime.isHidden = true
        startB.isHidden = true
    }
    func counter(){
        seconds -= 1
        let minutes = seconds / 60;
        let seconds2 = seconds % 60;
        timeLabel.text = "\(minutes) : \(seconds2)"
        
        if seconds==0{
            timer.invalidate()
            sliderTime.isHidden = false
            startB.isHidden = false
            timeLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 30)
            timeLabel.text = "Your tea is ready!"
            
            audioPlayer.play()
        }
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        timeLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 100)
        timer.invalidate()
        seconds = 60
        sliderTime.setValue(60, animated: true)
        timeLabel.text = "1 : 0"
        audioPlayer.stop()
        
        
        sliderTime.isHidden = false
        startB.isHidden = false
    }

}
