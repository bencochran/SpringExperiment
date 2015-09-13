//
//  Spring.swift
//  Bouncy
//
//  Created by Ben Cochran on 9/12/15.
//  Copyright © 2015 Ben Cochran. All rights reserved.
//

import Foundation
import Foundation

private let defaultTension = 320.0
private let defaultFriction = 16.0
private let defaultTolerance = 0.0001

///
/// Defines the state of a spring with a generic arithmetic type (generally: `Double` or `CGPoint`, etc)
/// A spring can be iterated over to produce values converging on its `targetValue`, e.g.:
/// 
///     let spring = Spring<Double>(from: 0, to: 1)
///     for state in spring {
///         print(state.value)
///     }
///
/// Or its `generator` can be used directly with a system like `CADisplayLink`.
///
/// A spring is considered “settled” based on a given `tolerance` that can be provided.
/// Currently, it computes its states assuming a FPS of 60.
///
public struct Spring<T:SpringArithmeticType> {
    /// The current value of the spring
    public var value: T
    /// The current force of the spring
    public var force: T
    /// The current speed of the spring (units / second)
    public var speed: T
    /// The target value of the spring
    public var targetValue: T
    
    /// The tension of the spring
    public var tension: T
    /// The friction of the spring
    public var friction: T
    
    /// The tolerance to use when determining if the spring is settled on its final value
    public let tolerance: T
    private let frameDuration: T = T(1.0 / 60.0)
    
    public init(from: T, to: T, initialSpeed: T = T(0), tension: T = T(defaultTension), friction: T = T(defaultFriction), tolerance: T = T(defaultTolerance)) {
        self.value = from
        self.force = from - initialSpeed * frameDuration
        self.speed = initialSpeed
        self.targetValue = to
        self.tension = tension
        self.friction = friction
        self.tolerance = tolerance
    }
    
    private var settled: Bool {
        return abs(value - targetValue) < tolerance &&
            abs(force - targetValue) < tolerance &&
            abs(speed) < tolerance
    }
}

extension Spring : SequenceType {
    public typealias Generator = AnyGenerator<Spring>
    public func generate() -> Generator {
        var spring = self
        return anyGenerator { [tension = tension, friction = friction, frameDuration = frameDuration] in
            if spring.settled {
                return nil
            }
            let previous = spring
            
            let springy = T(0) - tension * (previous.value - spring.targetValue)
            spring.force = previous.value + springy * frameDuration * frameDuration
            spring.speed = max(T(1) - frameDuration * friction, T(0)) * (spring.force - previous.force) / frameDuration
            spring.value = spring.force + spring.speed * frameDuration
            
            return previous
        }
    }
}

