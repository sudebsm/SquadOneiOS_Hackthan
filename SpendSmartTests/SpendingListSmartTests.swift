//
//  SpendingListSmartTests.swift
//  SpendSmartTests
//
//  Created by Abinash Reddy on 11/05/24.
//

import XCTest
@testable import SpendSmart

final class SpendingListSmartTests: XCTestCase {
    var spendingVM: SpendingListViewModel!
    var transactionManager: SpendSmartManager!

    override func setUpWithError() throws {
        spendingVM = SpendingListViewModel()
        transactionManager = SpendSmartManager.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetTransactionsForCustomerID() {
        // Given
        let customerId = "123"
        let transaction = SpendMoney(customerId: customerId, description: "Test Transaction", amount: 50.0, paymentType: "Debit", transactionType: "", dateTime: Date())
        transactionManager.addSpendAmount(spendModel: transaction)
        
        // When
        let filteredTransactions = transactionManager.getSpendTransactions(forCustomerID: customerId)
        
        // Then
        XCTAssertEqual(filteredTransactions.first?.customerId, customerId)
        spendingVM.fetchAllTransactions(customerId: customerId) { _ in
            
        }
        XCTAssertNotEqual(spendingVM.spendListDataSource.count, 0)
    }

}
