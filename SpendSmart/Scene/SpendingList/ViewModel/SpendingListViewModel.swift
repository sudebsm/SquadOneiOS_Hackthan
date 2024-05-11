//
//  SpendingListViewModel.swift
//  HCLTask
//
//  Created by Abinash Reddy on 11/05/24.
//

import Foundation
 
class SpendingListViewModel {
    var spendListDataSource = [SpendMoney]()
    
    func fetchAllTransactions(customerId: String, completion: @escaping (Bool) -> Void) {
            let allSpendingList = SpendSmartManager.shared.getSpendTransactions(forCustomerID: customerId)
            self.spendListDataSource = allSpendingList
           completion(allSpendingList.count > 0 ? true : false)
    }
}


