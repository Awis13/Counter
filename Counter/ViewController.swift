//
//  ViewController.swift
//  Counter
//
//  Created by Nikolay Postnikov on 01.07.2020.
//  Copyright © 2020 Nikolay Postnikov. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
   
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    
    var player: AVAudioPlayer!
    var timer = Timer()
    var selectedTime = 10
    let secondsArray = [10, 15, 20, 30, 60]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return secondsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(secondsArray[row])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        counterLabel.text = String(secondsArray[row])
        selectedTime = secondsArray[row]
        timer.invalidate()
        
    }
    
    
    
    override func viewDidLoad() {
        counterLabel.text = String(selectedTime)
        picker.delegate = self
        super.viewDidLoad()
        button.layer.cornerRadius = 5
        button.setTitle("Start counter", for: .normal)
        
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateCounter() {
       
        if selectedTime > 0 {
            selectedTime = selectedTime - 1
            counterLabel.text = String(selectedTime)
        } else {
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            timer.invalidate()
        }
        
        
    }
    
}

