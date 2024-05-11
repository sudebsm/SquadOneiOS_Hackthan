//
//  CreateTransactionTests.swift
//  SpendSmartTests
//
//  Created by Bharathimohan on 11/05/24.
//

import XCTest
@testable import SpendSmart
final class CreateTransactionTests: XCTestCase {
    var createVM: CreateTransactionViewModel!
    var transactionManager: SpendSmartManager!

    override func setUpWithError() throws {
        transactionManager = SpendSmartManager.shared
        createVM = CreateTransactionViewModel(delegate: nil)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        createVM = nil
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
    
    func testSaveTransactionFail() {
        
        // Given
        let transaction = SpendMoney(customerId: "", description: "", amount: 0.0, paymentType: "", transactionType: "", dateTime: Date())
        
        createVM.dataSource = []
        // When
        createVM.saveSpendMoneyData()
        transactionManager.addSpendAmount(spendModel: transaction)
        
        // Then
        XCTAssertTrue(!transactionManager.getAllSpendTransactions().isEmpty)
    }
    
    func testAmountZeroFail() {
        
        // Given
        let transaction = SpendMoney(customerId: "213", description: "", amount: 0.0, paymentType: "", transactionType: "", dateTime: Date())
        
        createVM.dataSource = []
        // When
        createVM.saveSpendMoneyData()
        transactionManager.addSpendAmount(spendModel: transaction)
        
        // Then
        XCTAssertTrue(!transactionManager.getAllSpendTransactions().isEmpty)
    }
    
    func testEmptyCustomerId() {
        
        // Given
        let transaction = SpendMoney(customerId: "", description: "gts", amount: 0.0, paymentType: "", transactionType: "", dateTime: Date())
        
        createVM.dataSource = []
        // When
        createVM.saveSpendMoneyData()
        transactionManager.addSpendAmount(spendModel: transaction)
        
        // Then
        XCTAssertTrue(!transactionManager.getAllSpendTransactions().isEmpty)
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

}
