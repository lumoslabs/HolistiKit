//
//  NotificationCentering.swift
//  UIKitFringes
//
//  Created by Jinwoo Baek on 4/10/19.
//  Copyright © 2019 solidcell. All rights reserved.
//

import Foundation

public protocol NotificationCentering {
    func post(name: NSNotification.Name, object: Any?)
    func removeObserver(_ observer: Any)
    func removeObserver(_ observer: Any, name aName: NSNotification.Name?, object anObject: Any?)
    func addObserver(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?, object anObject: Any?)
    func addObserver(forName name: NSNotification.Name?, object obj: Any?, queue: OperationQueueProtocol?, using block: @escaping (Notification) -> Void) -> NSObjectProtocol
}

extension NotificationCenter: NotificationCentering {
    public func addObserver(forName name: NSNotification.Name?, object obj: Any?, queue: OperationQueueProtocol?, using block: @escaping (Notification) -> Void) -> NSObjectProtocol {
        return addObserver(forName: name, object: obj, queue: queue?.realQueue(), using: block)
    }
}
