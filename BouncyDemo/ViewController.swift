//
//  ViewController.swift
//  Bounce
//
//  Created by Ben Cochran on 9/12/15.
//  Copyright © 2015 Ben Cochran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private static var numberFormatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    @IBOutlet var bounceView: BounceView!
    @IBOutlet var tensionLabel: UILabel!
    @IBOutlet var frictionLabel: UILabel!
    
    @IBAction func handleGesture(sender: UIGestureRecognizer) {
        bounceView.animateTo(sender.locationInView(bounceView))
    }
    
    @IBAction func handleTension(sender: UISlider) {
        bounceView.tension = Double(sender.value)
        tensionLabel.text = ViewController.numberFormatter.stringFromNumber(sender.value)
    }
    
    @IBAction func handleFriction(sender: UISlider) {
        bounceView.friction = Double(sender.value)
        frictionLabel.text = ViewController.numberFormatter.stringFromNumber(sender.value)
    }
}

