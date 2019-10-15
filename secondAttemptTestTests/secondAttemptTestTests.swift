//
//  secondAttemptTestTests.swift
//  secondAttemptTestTests
//
//  Created by Bruno Augusto Constantino on 9/30/19.
//  Copyright © 2019 Bruno Augusto Constantino. All rights reserved.
//

import XCTest
@testable import secondAttemptTest

class secondAttemptTestTests: XCTestCase {
    
    private var vc = MainViewController()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateInitialViewController() as! MainViewController
        let _ = vc.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testIfElementsExists() {
        setUp()
        let textView = vc.inputedUrl
        let tableView = vc.tableViewAlias
        XCTAssertTrue(textView != nil)
        XCTAssertTrue(tableView != nil)
    }
    
    func testJSONMapping() throws {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "apiAnswer", withExtension: "json") else {
            XCTFail("Missing file: User.json")
            return
        }

        let json = try Data(contentsOf: url)
        let linkAliasData = try? JSONDecoder().decode(LinkAliasType.self, from: json)

        XCTAssertEqual(linkAliasData?.alias, "97750")
        XCTAssertEqual(linkAliasData?._links.`self`, "teste")
        XCTAssertEqual(linkAliasData?._links.short, "https://url.com/short/97750")
    }

    func testIfButtonIsWorking() {
        setUp()
        let tableView = vc.tableViewAlias

        vc.inputedUrl.text = "teste"
        vc.getAlias((Any).self)
        sleep(4)
        vc.getAlias((Any).self)
        sleep(4)

        let numberOfRows = tableView?.numberOfRows(inSection: 0)

        XCTAssertEqual(numberOfRows, 1)
    }
}
