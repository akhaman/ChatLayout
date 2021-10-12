//
//  Sequence+.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 12.10.2021.
//

import Foundation

struct WrappedSequence<Wrapped: Sequence, Element>: Sequence {
    typealias IteratorFunction = (inout Wrapped.Iterator) -> Element?

    private let wrapped: Wrapped
    private let iterator: IteratorFunction

    init(wrapping wrapped: Wrapped, iterator: @escaping IteratorFunction) {
        self.wrapped = wrapped
        self.iterator = iterator
    }

    func makeIterator() -> AnyIterator<Element> {
        var wrappedIterator = wrapped.makeIterator()
        return AnyIterator { self.iterator(&wrappedIterator) }
    }
}

extension Sequence {
    typealias Segment = (previous: Element?, current: Element, next: Element?)

    var segmented: WrappedSequence<Self, Segment> {
        var previous: Element?
        var current: Element?
        var endReached = false

        let wrappedSequence = WrappedSequence<Self, Segment>(wrapping: self) { iterator in
            guard !endReached, let element = current ?? iterator.next() else {
                return nil
            }

            let next = iterator.next()
            let segment = (previous, element, next)

            previous = element
            current = next
            endReached = next == nil

            return segment
        }

        return wrappedSequence
    }
}
