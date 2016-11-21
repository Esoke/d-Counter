//
//  ViewController.swift
//  dCounter
//
//  Created by Esma on 11/20/16.
//  Copyright © 2016 Esma. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {

    var count = 0
    var mute = false
    var player: AVAudioPlayer?
    let MINUS_SOUND = "minusSound"
    let PLUS_SOUND = "clickSound"
    
    @IBOutlet weak var countField: UITextField!
    
    @IBOutlet weak var soundButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //--- add UIToolBar on keyboard and Done button on UIToolBar ---//
        self.addDoneButtonOnKeyboard()
    }


    func playSound(_ resource:String) {
        if mute == false{
            let url = Bundle.main.url(forResource: resource, withExtension: "mp3")!
        
            do {
                player = try AVAudioPlayer(contentsOf: url)
                guard let player = player else { return }
            
                player.prepareToPlay()
                player.play()
            } catch let error {
                print(error.localizedDescription)
            }
            
        }else{
            if player != nil {
                player?.stop()
                player = nil
            }
        }
    }

    
    @IBAction func plusPressed(_ sender: Any) {
        count += 1
        updateCount()
        playSound(PLUS_SOUND)
    }

    @IBAction func minusPressed(_ sender: Any) {
        count -= 1
        updateCount()
        playSound(MINUS_SOUND)
        
    }
    
    @IBAction func soundPressed(_ sender: Any) {
        if soundButton.imageView?.image == (UIImage(named: "speaker")){
            mute = true
            
            if let image = UIImage(named: "mute") {
                soundButton.setImage(image, for: .normal)
                
            }
        }else if soundButton.imageView?.image == (UIImage(named: "mute")){
            mute = false
            
            if let image = UIImage(named: "speaker") {
                soundButton.setImage(image, for: .normal)
            }
        }
    }
    
    func updateCount(){
        countField.text = String(count)
    }
    


    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(ViewController.doneButtonAction))
        
        let items = [flexSpace, done]
  
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.countField.inputAccessoryView = doneToolbar
        
    }
    
    func doneButtonAction()
    {
        self.countField.resignFirstResponder()
        
        count = Int(countField.text!) ?? count
    }
    
    
    
}

