//
//  TupleArithmetic.swift
//  Bouncy
//
//  Created by Ben Cochran on 9/12/15.
//  Copyright © 2015 Ben Cochran. All rights reserved.
//

import Foundation

/// A “private” protocol that allows for conversion of values into a two-value tuple.
/// This is used so standard types (`CGPoint`, `CGRect`, etc) can conform to `SpringArithmeticType`
/// using some protocol extensions to reduce the need for duplicate code.
public protocol _TwoTupleable {
    typealias First: SpringArithmeticType
    typealias Second: SpringArithmeticType
    var twoTuple: _TwoTuple<First, Second> { get }
    init(twoTuple: _TwoTuple<First, Second>)
}

extension _TwoTupleable {
    /// Combine the tuple with another tuple, applying the `firstTransform`
    /// and `secondTransform` to their first and second values, respectively.
    ///
    /// Essentially: `(First,Second) + (First,Second) -> (A,B)` where `+`
    /// represents the application of two functions `(First, First) -> A`
    ///  and `(Second, Second) -> B`.
    ///
    private func combineWith<Other: _TwoTupleable, A, B, Result: _TwoTupleable
        where Other.First == Self.First,
              Other.Second == Self.Second,
              Result.First == A,
              Result.Second == B>
        (other: Other,
         firstTransform: (Self.First, Self.First) -> A,
         secondTransform: (Self.Second, Self.Second) -> B) -> Result
    {
        let tuple = self.twoTuple
        let otherTuple = other.twoTuple
        let newTuple = tuple.combineWith(otherTuple, firstTransform: firstTransform, secondTransform: secondTransform)
        return Result(twoTuple: newTuple)
    }
}

public struct _TwoTuple<First,Second> {
    var first: First
    var second: Second
    
    internal init(_ first: First, _ second: Second) {
        self.first = first
        self.second = second
    }
    
    private func combineWith<A,B>(
        other: _TwoTuple<First, Second>,
        firstTransform: (First, First) -> A,
        secondTransform: (Second, Second) -> B) -> _TwoTuple<A,B>
    {
            let first = firstTransform(self.first, other.first)
            let second = secondTransform(self.second, other.second)
            return _TwoTuple<A,B>(first, second)
            
    }
}

public func *<T: _TwoTupleable>(lhs: T, rhs: T) -> T {
    return lhs.combineWith(rhs, firstTransform: *, secondTransform: *)
}
public func /<T: _TwoTupleable>(lhs: T, rhs: T) -> T {
    return lhs.combineWith(rhs, firstTransform: /, secondTransform: /)
}
public func +<T: _TwoTupleable>(lhs: T, rhs: T) -> T {
    return lhs.combineWith(rhs, firstTransform: +, secondTransform: +)
}
public func -<T: _TwoTupleable>(lhs: T, rhs: T) -> T {
    return lhs.combineWith(rhs, firstTransform: -, secondTransform: -)
}

public func <<T: _TwoTupleable>(lhs: T, rhs: T) -> Bool {
    let leftTuple = lhs.twoTuple
    let rightTuple = rhs.twoTuple
    let newTuple = leftTuple.combineWith(rightTuple, firstTransform: <, secondTransform: <)
    return newTuple.first && newTuple.second
}

extension _TwoTupleable {
    public static func abs(value: Self) -> Self {
        var tuple = value.twoTuple
        tuple.first = Self.First.abs(tuple.first)
        tuple.second = Self.Second.abs(tuple.second)
        return Self(twoTuple: tuple)
    }
}
