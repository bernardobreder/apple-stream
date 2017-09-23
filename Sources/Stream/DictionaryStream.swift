//
//  DictionaryStream.swift
//  Stream
//
//  Created by Bernardo Breder on 27/01/17.
//
//

import Foundation

extension Dictionary {
    
    public var stream: DictionaryStream<Key, Value> {
        var iterator = self.makeIterator()
        return DictionaryStream<Key, Value> { iterator.next() }
    }
    
}

public struct DictionaryElementStream<Element> {
    
    let iterator: () -> Element
    
    public init(_ iterator: @escaping () -> Element) {
        self.iterator = iterator
    }
    
    public func consume() -> Element {
        return iterator()
    }
    
}

public struct DictionaryStream<Key: Hashable, Value> {
    
    let iterator: () -> (Key, Value)?
    
    public init(_ iterator: @escaping () -> (Key, Value)?) {
        self.iterator = iterator
    }
    
    public func mapKeys<T>(_ f: @escaping (Key, Value) -> T) -> DictionaryStream<T, Value> {
        return DictionaryStream<T, Value> {
            guard let (key, value) = self.iterator() else { return nil }
            return (f(key, value), value)
        }
    }
    
    public func mapValues<T>(_ f: @escaping (Key, Value) -> T) -> DictionaryStream<Key, T> {
        return DictionaryStream<Key, T> {
            guard let (key, value) = self.iterator() else { return nil }
            return (key, f(key, value))
        }
    }
    
    public func keys(_ f: @escaping (Key, Value) -> Key = {(k,v) in k}) -> ArrayStream<Key> {
        return ArrayStream<Key> {
            guard let (key, value) = self.iterator() else { return nil }
            return f(key, value)
        }
    }

    public func values(_ f: @escaping (Key, Value) -> Value = {(k,v) in v}) -> ArrayStream<Value> {
        return ArrayStream<Value> {
            guard let (key, value) = self.iterator() else { return nil }
            return f(key, value)
        }
    }
    
    public func filter(_ f: @escaping (Key, Value) -> Bool) -> DictionaryStream<Key, Value> {
        return DictionaryStream<Key, Value> {
            while let (key, value) = self.iterator() {
                if f(key, value) { return (key, value) }
            }
            return nil
        }
    }
    
    public var first: (key: Key, value: Value)? {
        while let (key, value) = iterator() {
            return (key, value)
        }
        return nil
    }
    
    public func consume() -> [Key: Value] {
        var result: [Key: Value] = [:]
        while let (key, value) = iterator() {
            result[key] = value
        }
        return result
    }
    
}
