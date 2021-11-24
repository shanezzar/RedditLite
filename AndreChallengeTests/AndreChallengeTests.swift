//
//  AndreChallengeTests.swift
//  AndreChallengeTests
//
//  Created by Shanezzar Sharon on 24/11/2021.
//

import XCTest
@testable import AndreChallenge
import Combine

class AndreChallengeTests: XCTestCase {
    
    // MARK:- variables
    var cancellables = Set<AnyCancellable>()
    
    // MARK:- functions
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellables.removeAll()
    }
    
    func test_NetworkModel_reddits_shouldBeEmpty() {
        // Given
        let networkModel = NetworkModel.shared
        
        // When
        let reddits = networkModel.reddits
        
        // Then
        XCTAssertTrue(reddits.isEmpty)
        XCTAssertEqual(reddits.count, 0)
    }
    
    func test_NetworkModel_fetchData_shouldReturnItems() {
        // Given
        let networkModel = NetworkModel.shared
        
        // When
        let expectation = XCTestExpectation(description: "Should return items within 3 seconds.")
        
        networkModel.$reddits
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        networkModel.fetchData(topic: "fitness")
        
        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertGreaterThan(networkModel.reddits.count, 0)
    }
    
}
