//
//  SnapViewModel.swift
//  SpendSmart
//
//  Created by Sudeb on 11/05/24.
//
import XCTest
@testable import SpendSmart


final class SnapViewModelTests: XCTestCase {
    var snapVM: SnapViewModel!
    var transactionManager: SpendSmartManager!

    override func setUpWithError() throws {
        transactionManager = SpendSmartManager.shared
        snapVM = SnapViewModel()

        saveTransaction()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchDataByTransactionTypeCredit(){
        
        snapVM.fetchDataAll(type: "Credit") { status in
            if status {
                XCTAssertNotEqual(self.snapVM.spendListDataSource.count,0)
            }
        }
    }
    
    func testFetchDataByTransactionTypeDebit(){
        
        snapVM.fetchDataAll(type: "Debit") { status in
            if status {
                XCTAssertNotEqual(self.snapVM.spendListDataSource.count,0)
            }
        }
    }
    
    func testFetchDataByMonth(){
        
        snapVM.fetchDataByMonth(customerId: "123", month: 5, year: 2024) { status in
            if status {
                XCTAssertNotEqual(self.snapVM.spendListDataSource.count,0)
            }
        }
         
    }
    
    func saveTransaction() {
        // Given
        let transaction1 = SpendMoney(customerId: "123", description: "Test Transaction", amount: 50.0, paymentType: "Debit", transactionType: "", dateTime: Date())
        
        let transaction2 = SpendMoney(customerId: "123", description: "Test Transaction", amount: 50.0, paymentType: "Credit", transactionType: "", dateTime: Date())
        
        // When
        self.transactionManager.addSpendAmount(spendModel: transaction1)
        self.transactionManager.addSpendAmount(spendModel: transaction2)
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
