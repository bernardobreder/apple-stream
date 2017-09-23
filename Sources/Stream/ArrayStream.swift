//
//  Stream.swift
//  Stream
//
//  Created by Bernardo Breder on 20/01/17.
//
//

import Foundation

extension Array {
    
    public var stream: ArrayStream<Element> {
        var iterator = self.makeIterator()
        return ArrayStream<Element> { iterator.next() }
    }
    
}

public struct ElementStream<Element> {
    
    let iterator: () -> Element
    
    public init(_ iterator: @escaping () -> Element) {
        self.iterator = iterator
    }
    
    public func consume() -> Element {
        return iterator()
    }
    
}

public struct ArrayStream<Element> {
    
    let iterator: () -> Element?
    
    public init(_ iterator: @escaping () -> Element?) {
        self.iterator = iterator
    }
    
    public func map<T>(_ f: @escaping (Element) -> T) -> ArrayStream<T> {
        return ArrayStream<T> {
            guard let element = self.iterator() else { return nil }
            return f(element)
        }
    }
    
    public func filter(_ f: @escaping (Element) -> Bool) -> ArrayStream<Element> {
        return ArrayStream<Element> {
            while let element = self.iterator() {
                if f(element) { return element }
            }
            return nil
        }
    }
    
    public func concat(_ stream: ArrayStream<Element>) -> ArrayStream<Element> {
        return ArrayStream<Element> {
            while let element = self.iterator() { return element }
            while let element = stream.iterator() { return element }
            return nil
        }
    }
    
    public func reduce(_ initial: Element, _ f: @escaping (Element, Element) -> Element) -> ElementStream<Element> {
        return ElementStream<Element> {
            var result = initial
            while let element = self.iterator() { result = f(result, element) }
            return result
        }
    }
    
    public func dictionary<K, V>(_ f: @escaping (Element) -> (K, V)) -> DictionaryStream<K, V> {
        return DictionaryStream<K, V> {
            guard let element = self.iterator() else { return nil }
            return f(element)
        }
    }
    
    public var first: Element? {
        while let element = iterator() { return element }
        return nil
    }
    
    public func consume() -> [Element] {
        var result: [Element] = []
        while let element = iterator() { result.append(element) }
        return result
    }
    
}

extension ArrayStream where Element: Hashable {
    
    public func set() -> ArrayStream<Element> {
        var set = Set<Element>()
        return ArrayStream<Element> {
            while let element = self.iterator() {
                if !set.contains(element) {
                    set.insert(element)
                    return element
                }
            }
            return nil
        }
    }
    
}

//public protocol ArrayStreamOptionalType {
//    associatedtype Wrapped
//    func map<U>(_ f: (Wrapped) throws -> U) rethrows -> U?
//}
//
//extension Optional: ArrayStreamOptionalType {}
//
//extension ArrayStream where Element: ArrayStreamOptionalType {
//    
//    public func notnil() -> ArrayStream<Element.Wrapped> {
//        return ArrayStream<Element.Wrapped> {
//            while let element = self.iterator() {
//                if let result = element.map({ $0 }) { return result }
//            }
//            return nil
//        }
//    }
//    
//}
