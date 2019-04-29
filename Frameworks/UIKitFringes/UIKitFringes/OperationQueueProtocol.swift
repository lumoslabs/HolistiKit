//
//  OperationQueueProtocol.swift
//  UIKitFringes
//
//  Created by Jinwoo Baek on 5/21/18.
//  Copyright © 2019 solidcell. All rights reserved.
//

import Foundation

public protocol OperationQueueProtocol {
    func addOperation(_ block: @escaping () -> Swift.Void)
    func addOperation(_ op: Operation)
    var operations: [Operation] {get}
    func realQueue() -> OperationQueue
    var maxConcurrentOperationCount: Int {get set}
    var isSuspended: Bool {get set}
}

extension OperationQueue: OperationQueueProtocol {
    public func realQueue() -> OperationQueue {
        return self
    }
}

