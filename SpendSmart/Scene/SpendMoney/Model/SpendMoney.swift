//
//  SpendMoneyModel.swift
//  SpendAnalyzer
//
//  Created by Bharathimohan on 11/05/24.
//

import Foundation


struct SpendMoney: Codable {
    var customerId: String
    var description: String
    var amount: Double
    var paymentType: String
    var transactionType: String
    var dateTime: Date 
    init(customerId: String, description: String, amount: Double, paymentType: String, transactionType: String, dateTime: Date){
        self.customerId = customerId
        self.description = description
        self.amount = amount
        self.paymentType = paymentType
        self.transactionType = transactionType
        self.dateTime = dateTime
    }
}
