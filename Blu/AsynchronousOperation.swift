//
//  AsynchronousOperation.swift
//  Blu
//
//  Created by Aranza Manriquez Alonso on 25/12/24.
//

import Foundation

public class AsynchronousOperation: Operation {

    private let stateLock = NSLock()
    
    private var _executing: Bool = false
    
    override private(set) public var isExecuting: Bool {
        get {
            return stateLock.withCriticalScope { _executing }
        }
        set {
            willChangeValue(forKey: "isExecuting")
            stateLock.withCriticalScope { _executing = newValue }
        didChangeValue(forKey: "isExecuting")
        }
    }
    
    private var _finished: Bool = false
    override private (set) public var isFinished: Bool {
        get {
            return stateLock.withCriticalScope { _finished }
        }
        set {
            willChangeValue(forKey: "isFinished")
            stateLock.withCriticalScope { _finished = newValue }
        didChangeValue(forKey: "isFinished")
        }
    }

    public func completeOperation() {
        if isExecuting {
            isExecuting = false
        }
        if !isFinished {
            isFinished = true
        }
    }
    
        override public func start() {
        if isCancelled {
        isFinished = true
        return
        }
        isExecuting = true
        main()
    }

    override public func main() {
        fatalError("subclasses must override ⁠ main ⁠")
    }

}

extension NSLocking {
    
    func withCriticalScope<T>(block: () throws -> T) rethrows -> T {
        lock()
        defer {
            unlock()
        }
        return try block()
    }
}
