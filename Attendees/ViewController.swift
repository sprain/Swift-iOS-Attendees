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

    /// MARK: Properties
    @IBOutlet weak var countButton: UIButton!
    
    /// User defaults
    let defaults = UserDefaults.standard
    
    /// Flag whether the app has already been used. Is false for the first usage, the true.
    var inUsage = false
    
    /// The audio played when tapping the count button
    var pop:AVAudioPlayer = AVAudioPlayer()
    
    /// The current counter value
    var counter: Int = 0 {
        didSet {
            countButton.setTitle(String(counter), for: UIControlState.normal)
        }
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide navigation bar
        // We use the navigation controller to simply achieve right-left segues
        self.navigationController?.isNavigationBarHidden = true
        
        // Read data from user defaults
        counter = defaults.integer(forKey: "counter")
        inUsage = defaults.bool(forKey: "isInUsage")
        
        // Load example counts if the app is started the first time
        if (false == inUsage) {
            CountPersister.loadExamples()
            defaults.set(true, forKey: "isInUsage")
        }
        
        // Prepare audio
        prepareAudio()
        
        // Listen to left swipe
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeLeft))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }

    override func viewDidDisappear(_ animated: Bool) {
        defaults.set(counter, forKey: "counter")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: IBActions
    @IBAction func countButtonTouched(_ sender: UIButton) {
        pop.play()
        counter += 1
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        counter = 0
    }
    
    // MARK: Functions
    func prepareAudio() -> Void {
        do {
            let pathPop = Bundle.main.path(forResource: "Pop", ofType: "aiff")
            pop = try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: pathPop!) as URL)
            pop.prepareToPlay()
        } catch {}
    }
    
    func respondToSwipeLeft(gesture: UIGestureRecognizer) {
        if gesture is UISwipeGestureRecognizer {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "List") as? ListViewController
            navigationController?.pushViewController(vc!, animated: true)
        }
    }
}

