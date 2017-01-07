//
//  FringesExampleTests.swift
//  FringesExampleTests
//
//  Created by Jesse Farless on 1/6/17.
//  Copyright © 2017 solidcell. All rights reserved.
//

import XCTest
@testable import FringesExample

class FringesExampleTests: XCTestCase {

    var appCoordinator: AppCoordinator!
    
    override func setUp() {
        super.setUp()

        let rootRouter = RootRouter()
        appCoordinator = AppCoordinator(router: rootRouter)
        let window = UIWindow()
        appCoordinator.didFinishLaunching(withWindow: window)
    }
    
    func testExample() {
    }
    
}
