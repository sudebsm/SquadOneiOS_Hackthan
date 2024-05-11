//
//  TransactionModel.swift
//  SpendAnalyzer
//
//  Created by Hymavathi parimi on 11/05/24.
//

import Foundation

enum PaymentType {
    case makePayment
    case recievePayment
}

enum Sectiontypes {
    case customerId
    case amount
    case transactionDescripition
    case paymentType
    case date
    
    func getTitle() -> String {
        switch self {
        case .customerId:
            return "Customer Id"
        case .amount:
            return "Amount"
        case .transactionDescripition:
            return "Transaction Descripition"
        case .paymentType:
            return ""
        case .date:
            return "Date"
        }
    }
}

struct TransactionModel {
    var sectionType: Sectiontypes = .customerId
    var inputText: String?
    var showError: Bool = false
    var errorText: String?
    var date: Date?
    var paymentType: PaymentType = .makePayment
}
