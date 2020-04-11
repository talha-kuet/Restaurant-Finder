//
//  Restaurant_FinderTests.swift
//  Restaurant FinderTests
//
//  Created by Musaddique Billah Talha on 3/19/20.
//

import XCTest
@testable import Restaurant_Finder

class Restaurant_FinderTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    func testGoogleApiKey() {
        XCTAssertEqual("AIzaSyCK0ri6Et5HRi9e9uTJVI3R97AwvcZWVA4", Constants.GOOGLE_MAPS_API_KEY, "Google Maps Api Key is not matched. Please have a check")
    }

    func testFourSquarePlaceApiClientID() {
        XCTAssertEqual("2QYQLI5Z10DJHBOAZOMACRVTVQYCU0U5GNHVOP1BKFEAK1E5", Constants.FourSquarePlaceAPI.CLIENT_ID, "Four Square Client ID is not matched. Please have a check")
    }

    func testFourSquarePlaceApiClientSecret() {
        XCTAssertEqual("Y2FT1DMHNPVMWGNMWXDA11BHGUWXLFN3UJQMLF0ZIP3S0N2V", Constants.FourSquarePlaceAPI.CLIENT_SERCET, "Four Square Client Secret is not matched. Please have a check")
    }

    func testFourSquarePlaceApiSearchCategoryID() {
        XCTAssertEqual("4d4b7105d754a06374d81259", Constants.FourSquarePlaceAPI.CATEGORY_FOOD, "Four Square Search Category not matched. It should be Food Category ID. Please have a check")
    }

}
