//
//  UNNotificationSettingsProtocol.swift
//  UIKitFringes
//
//  Created by Joshua Escribano on 5/29/19.
//  Copyright © 2019 solidcell. All rights reserved.
//

import Foundation
import UserNotifications

public protocol UNNotificationSettingsProtocol: NSObjectProtocol {
    
    @available(iOS 10.0, *)
    var authorizationStatus: UNAuthorizationStatus { get }
    
    @available(iOS 10.0, *)
    var soundSetting: UNNotificationSetting { get }
    @available(iOS 10.0, *)
    var badgeSetting: UNNotificationSetting { get }
    @available(iOS 10.0, *)
    var alertSetting: UNNotificationSetting { get }
    
    @available(iOS 10.0, *)
    var notificationCenterSetting: UNNotificationSetting { get }
    @available(iOS 10.0, *)
    var lockScreenSetting: UNNotificationSetting { get }
    @available(iOS 10.0, *)
    var carPlaySetting: UNNotificationSetting { get }
    
    @available(iOS 10.0, *)
    var alertStyle: UNAlertStyle { get }
    
    
    @available(iOS 11.0, *)
    var showPreviewsSetting: UNShowPreviewsSetting { get }
    
    
    @available(iOS 12.0, *)
    var criticalAlertSetting: UNNotificationSetting { get }
    
    
    @available(iOS 12.0, *)
    var providesAppNotificationSettings: Bool { get }
}

@available(iOS 10.0, *)
extension UNNotificationSettings: UNNotificationSettingsProtocol {}

public protocol UserNotificationCenterProtocol: NSObjectProtocol {
    @available(iOS 10.0, *)
    func requestAuthorization(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void)
    @available(iOS 10.0, *)
    func setNotificationCategories(_ categories: Set<UNNotificationCategory>)
    @available(iOS 10.0, *)
    func getNotificationSettingsP(completionHandler: @escaping (UNNotificationSettingsProtocol) -> Swift.Void)
    @available(iOS 10.0, *)
    func getPendingNotificationRequests(completionHandler: @escaping ([UNNotificationRequest]) -> Swift.Void)
    func removePendingNotificationRequests(withIdentifiers identifiers: [String])
    func removeAllPendingNotificationRequests()
    @available(iOS 10.0, *)
    func realSelf() -> UNUserNotificationCenter
    
    // MARK: Modified
    
    // This is a copy of the UserNotificationCenter, but since we're declaring it in Swift, we need
    // to adjust some of the interface to be compatible.
    @available(iOS 10.0, *)
    func add(_ request: UNNotificationRequest, withCompletionHandler completionHandler: ((Error?) -> Void)?)
    @available(iOS 10.0, *)
    var delegate: UNUserNotificationCenterDelegate? {get set}
}

@available(iOS 10.0, *)
extension UNUserNotificationCenter: UserNotificationCenterProtocol {
    public func getNotificationSettingsP(completionHandler: @escaping (UNNotificationSettingsProtocol) -> Void) {
        getNotificationSettings(completionHandler: completionHandler)
    }
    
    @available(iOS 10.0, *)
    public func realSelf() -> UNUserNotificationCenter {
        return self
    }
}
