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
    func realQueue() -> OperationQueue
}

extension OperationQueue: OperationQueueProtocol {
    public func realQueue() -> OperationQueue {
        return self
    }
}

