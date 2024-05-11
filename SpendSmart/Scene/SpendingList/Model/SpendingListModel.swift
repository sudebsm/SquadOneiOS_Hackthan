//
//  SpendingListModel.swift
//  HCLTask
//
//  Created by Abinash Reddy on 11/05/24.
//

import Foundation

//MARK: - SpendingType
//enum PaymentType: String {
//    case credit
//    case debit
//}

//MARK: - SpendingListModel
struct SpendingListModel {
    var customerId: String?
    var date: String?
    var description: String?
    var trancationType: PaymentType?
    
    init(customerId: String? = nil, date: String? = nil, description: String? = nil, trancationType: PaymentType? = nil) {
        self.customerId = customerId
        self.date = date
        self.description = description
        self.trancationType = trancationType
    }
    
}
