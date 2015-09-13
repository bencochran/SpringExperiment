//
//  BounceView.swift
//  Bounce
//
//  Created by Ben Cochran on 9/12/15.
//  Copyright © 2015 Ben Cochran. All rights reserved.
//

import UIKit
import Bouncy

public class BounceView: UIView {
    private var generator: Spring<CGPoint>.Generator? {
        didSet {
            displayLink.paused = (generator == nil)
        }
    }
    
    public var tension: Double = 320 {
        didSet {
            guard var spring = generator?.next() else { return }
            spring.tension = CGPoint(tension)
            generator = spring.generate()
        }
    }
    
    public var friction: Double = 16 {
        didSet {
            guard var spring = generator?.next() else { return }
            spring.friction = CGPoint(friction)
            generator = spring.generate()
        }
    }
    
    private var displayLink: CADisplayLink!
    private let dot = UIView()
    private let target = UIView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .whiteColor()
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        target.bounds = CGRectMake(0, 0, 44, 44)
        target.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.5)
        target.layer.cornerRadius = target.bounds.width / 2
        
        dot.bounds = CGRect(x: 0, y: 0, width: 44, height: 44)
        dot.backgroundColor = .blueColor()
        dot.layer.cornerRadius = dot.bounds.width / 2
        
        addSubview(target)
        addSubview(dot)
        
        displayLink = CADisplayLink(target: self, selector: "tick:")
        displayLink.paused = true
        displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        guard let window = window else {
            generator = nil
            return
        }
        moveTo(window.convertPoint(CGPoint(x: window.bounds.midX, y: window.bounds.midY), toView: self))
    }
    
    @objc private func tick(displayLink: CADisplayLink) {
        guard let spring = generator?.next() else {
            generator = nil
            return
        }
        dot.center = spring.value
    }
    
    public func moveTo(point: CGPoint) {
        generator = nil
        dot.center = point
        target.center = point
    }
    
    public func animateTo(point: CGPoint) {
        target.center = point

        var spring = generator?.next() ?? Spring(from: dot.center, to: point, tension: CGPoint(tension), friction: CGPoint(friction))
        spring.targetValue = point
        generator = spring.generate()
    }
}
