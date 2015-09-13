//
//  UIKitExtensions.swift
//  Bouncy
//
//  Created by Ben Cochran on 9/12/15.
//  Copyright © 2015 Ben Cochran. All rights reserved.
//

import Foundation
import UIKit

// MARK: CGPoint

extension CGPoint: _TwoTupleable {
    public typealias First = CGFloat
    public typealias Second = CGFloat
    public var twoTuple: _TwoTuple<CGFloat, CGFloat> { return _TwoTuple(x, y) }
    public init(twoTuple: _TwoTuple<CGFloat, CGFloat>) {
        self.init(x: twoTuple.first, y: twoTuple.second)
    }
}
extension CGPoint: SpringArithmeticType {
    public init(_ scalar: Double) {
        self.init(x: scalar, y: scalar)
    }
}

// MARK: CGSize

extension CGSize: _TwoTupleable {
    public typealias First = CGFloat
    public typealias Second = CGFloat
    public var twoTuple: _TwoTuple<CGFloat, CGFloat> { return _TwoTuple(width, height) }
    public init(twoTuple: _TwoTuple<CGFloat, CGFloat>) {
        self.init(width: twoTuple.first, height: twoTuple.second)
    }
}
extension CGSize: SpringArithmeticType {
    public init(_ scalar: Double) {
        self.init(width: scalar, height: scalar)
    }
}

// MARK: CGRect

extension CGRect: _TwoTupleable {
    public typealias First = CGPoint
    public typealias Second = CGSize
    public var twoTuple: _TwoTuple<CGPoint, CGSize> { return _TwoTuple(origin, size) }
    public init(twoTuple: _TwoTuple<CGPoint, CGSize>) {
        self.init(origin: twoTuple.first, size: twoTuple.second)
    }
}
extension CGRect: SpringArithmeticType {
    public init(_ scalar: Double) {
        self.init(origin: CGPoint(scalar), size: CGSize(scalar))
    }
}

// MARK: UIOffset

extension UIOffset: _TwoTupleable {
    public typealias First = CGFloat
    public typealias Second = CGFloat
    public var twoTuple: _TwoTuple<CGFloat, CGFloat> { return _TwoTuple(horizontal, vertical) }
    public init(twoTuple: _TwoTuple<CGFloat, CGFloat>) {
        self.init(horizontal: twoTuple.first, vertical: twoTuple.second)
    }
}
extension UIOffset: SpringArithmeticType {
    public init(_ scalar: Double) {
        self.init(horizontal: CGFloat(scalar), vertical: CGFloat(scalar))
    }
}

// MARK: UIEdgeInsets

private extension UIEdgeInsets {
    // Pack top,left and bottom,right into UIOffsets so we can use _TwoTuple
    init(topLeft: UIOffset, bottomRight: UIOffset) {
        self.init(top: topLeft.vertical, left: topLeft.horizontal, bottom: bottomRight.vertical, right: bottomRight.horizontal)
    }
    var topLeft: UIOffset { return UIOffset(horizontal: left, vertical: top) }
    var bottomRight: UIOffset { return UIOffset(horizontal: right, vertical: bottom) }
}

extension UIEdgeInsets: _TwoTupleable {
    public typealias First = UIOffset
    public typealias Second = UIOffset
    public var twoTuple: _TwoTuple<UIOffset, UIOffset> { return _TwoTuple(topLeft, bottomRight) }
    public init(twoTuple: _TwoTuple<UIOffset, UIOffset>) {
        self.init(topLeft: twoTuple.first, bottomRight: twoTuple.second)
    }
}
extension UIEdgeInsets: SpringArithmeticType {
    public init(_ scalar: Double) {
        self.init(topLeft: UIOffset(scalar), bottomRight: UIOffset(scalar))
    }
}

// MARK: CGVector

extension CGVector: _TwoTupleable {
    public typealias First = CGFloat
    public typealias Second = CGFloat
    public var twoTuple: _TwoTuple<CGFloat, CGFloat> { return _TwoTuple(dx, dy) }
    public init(twoTuple: _TwoTuple<CGFloat, CGFloat>) {
        self.init(dx: twoTuple.first, dy: twoTuple.second)
    }
}
extension CGVector: SpringArithmeticType {
    public init(_ scalar: Double) {
        self.init(dx: CGFloat(scalar), dy: CGFloat(scalar))
    }
}

