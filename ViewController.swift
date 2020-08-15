//
//  ViewController.swift
//  FlashLight
//
//  Created by Chanmin on 2020/08/15.
//  Copyright © 2020 kim. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //Interface Builder
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var flashImageView: UIImageView!
    
    var isOn=false
    var clickSound: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSound()
    }
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()

                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }

                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    func prepareSound(){
        let path = Bundle.main.path(forResource: "switch.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            clickSound = try AVAudioPlayer(contentsOf: url)
            clickSound?.prepareToPlay()
        } catch {
            // couldn't load file :(
        }
    }
    
    
    @IBAction func switchTapped(_ sender: Any) {
        isOn = !isOn
        clickSound?.play()
        toggleTorch(on: isOn)
      
        flashImageView.image=isOn ? #imageLiteral(resourceName: "onBG") :#imageLiteral(resourceName: "offBG")
        switchButton.setImage(isOn ? #imageLiteral(resourceName: "onSwitch") : #imageLiteral(resourceName: "offSwitch"), for: .normal)
       
    }
    
}

