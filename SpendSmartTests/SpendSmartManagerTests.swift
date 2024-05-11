//
//  SpendSmartManagerTests.swift
//  SpendSmartTests
//
//  Created by Bharathimohan on 11/05/24.
//

import XCTest
@testable import SpendSmart

final class SpendSmartManagerTests: XCTestCase {
    var transactionManager: SpendSmartManager!

    override func setUpWithError() throws {
        transactionManager = SpendSmartManager.shared
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testSaveTransaction() {
        
        // Given
        let transaction = SpendMoney(customerId: "123", description: "Test Transaction", amount: 50.0, paymentType: "Debit", transactionType: "", dateTime: Date())
        
        // When
        transactionManager.addSpendAmount(spendModel: transaction)
        
        // Then
        XCTAssertTrue(!transactionManager.getAllSpendTransactions().isEmpty)
    }
    
    func testGetTransaction() {
        // Then
        XCTAssertTrue(!transactionManager.getAllSpendTransactions().isEmpty)
    }
    
    func testGetTransactionsForCustomerID() {
        // Given
        let customerId = "123"
        let transaction = SpendMoney(customerId: customerId, description: "Test Transaction", amount: 50.0, paymentType: "Debit", transactionType: "", dateTime: Date())
        transactionManager.addSpendAmount(spendModel: transaction)
        
        // When
        let filteredTransactions = transactionManager.getSpendTransactions(forCustomerID: customerId)
        
        // Then
        XCTAssertEqual(filteredTransactions.count, 1)
        XCTAssertEqual(filteredTransactions.first?.customerId, customerId)
    }
    
    func testGetTransactionsForDate() { 
        // Given
        let date = Date()
        let transaction = SpendMoney(customerId: "123", description: "Test Transaction", amount: 50.0, paymentType: "Debit", transactionType: "", dateTime: date)
        transactionManager.addSpendAmount(spendModel: transaction)
        // When
        let filteredTransactions = transactionManager.getSpendTransactions(forDate: date)
        // Then
        XCTAssertTrue(filteredTransactions.contains(where: { $0.dateTime == date }))
    }
    
    func testGetTransactionsForMonthAndYear() {
        // Given
        let calendar = Calendar.current
        let month = calendar.component(.month, from: Date())
        let year = calendar.component(.year, from: Date())
        let transaction = SpendMoney(customerId: "123", description: "Test Transaction", amount: 50.0, paymentType: "Debit", transactionType: "", dateTime: Date())
        transactionManager.addSpendAmount(spendModel: transaction)
        
        // When
        let filteredTransactions = transactionManager.getSpendTransactions(forMonth: month, year: year)
        
        // Then
        XCTAssertTrue(!filteredTransactions.isEmpty)
        XCTAssertTrue(filteredTransactions.allSatisfy({ calendar.component(.month, from: $0.dateTime) == month && calendar.component(.year, from: $0.dateTime) == year }))
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
