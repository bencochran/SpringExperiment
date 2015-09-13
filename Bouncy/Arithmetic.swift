//
//  Arithmetic.swift
//  Bouncy
//
//  Created by Ben Cochran on 9/12/15.
//  Copyright © 2015 Ben Cochran. All rights reserved.
//

import Foundation
import UIKit

/// Values that support the necessary arithmetic operations for spring calculations
public protocol SpringArithmeticType: Comparable {
    init(_: Double)
    func *(lhs: Self, rhs: Self) -> Self
    func /(lhs: Self, rhs: Self) -> Self
    func +(lhs: Self, rhs: Self) -> Self
    func -(lhs: Self, rhs: Self) -> Self
    static func abs(value: Self) -> Self
}

extension Double: SpringArithmeticType { }
extension Float: SpringArithmeticType { }
extension CGFloat: SpringArithmeticType { }

public func abs<T : SpringArithmeticType>(x: T) -> T {
    return T.abs(x)
}
