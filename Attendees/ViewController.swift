//
//  ViewController.swift
//  Attendees
//
//  Created by Manuel Reinhard on 01.10.16.
//  Copyright © 2016 Manuel Reinhard. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var countButton: UIButton!
    
    let defaults = UserDefaults.standard
    var pop:AVAudioPlayer = AVAudioPlayer()
    var count: Int = 0 {
        didSet {
            countButton.setTitle(String(count), for: UIControlState.normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        count = defaults.integer(forKey: "Count")
       
        do {
            let pathPop = Bundle.main.path(forResource: "Pop", ofType: "aiff")
            pop = try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: pathPop!) as URL)
            pop.prepareToPlay()
        } catch {}
    }

    override func viewDidDisappear(_ animated: Bool) {
        defaults.set(count, forKey: "Count")
    }
    
    @IBAction func countButtonTouched(_ sender: UIButton) {
        pop.play()
        count += 1
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        count = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

