//
//  SnapViewViewModel.swift
//  SnapViewViewModel
//
//  Created by Bharathimohan on 11/05/24.
//

import Foundation
class SnapViewModel {
    var spendListDataSource = [SpendMoney]()
    
    func fetchDataByMonth(customerId: String, month: Int, year: Int, completion: @escaping (Bool) -> Void) {
            self.spendListDataSource.removeAll()
            let allSpendingList = SpendSmartManager.shared.getSpendTransactions(forMonth: month, year: year)
            self.spendListDataSource = allSpendingList
           completion(allSpendingList.count > 0 ? true : false)
    }
    
    func fetchDataAll(type: String, completion: @escaping (Bool) -> Void) {
            self.spendListDataSource.removeAll()
            let allSpendingList = SpendSmartManager.shared.getAllSpendTransactions()
           self.spendListDataSource =  allSpendingList.filter{ $0.paymentType == type}
           completion(allSpendingList.count > 0 ? true : false)
    }
}
