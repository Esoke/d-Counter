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
    }


    func playSound(resource:String) {
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
        playSound(resource: PLUS_SOUND)
    }

    @IBAction func minusPressed(_ sender: Any) {
        count -= 1
        updateCount()
        playSound(resource: MINUS_SOUND)
        
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
    

       // count = Int(countField.text!) ?? count

    
    
    
    
}

