//
//  RunLoopProtocol.swift
//  UIKitFringes
//
//  Created by Jinwoo Baek on 5/15/19.
//  Copyright © 2019 solidcell. All rights reserved.
//

import Foundation

public protocol RunLoopProtocol {
    func add(_ timer: Timer, forMode mode: RunLoop.Mode)
}

extension RunLoop: RunLoopProtocol {
}
