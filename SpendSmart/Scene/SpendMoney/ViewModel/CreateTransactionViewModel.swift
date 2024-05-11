//
//  CreateTransactionViewModel.swift
//  SpendAnalyzer
//
//  Created by Hymavathi parimi on 11/05/24.
//

import Foundation

protocol CreateTransactionHandler: AnyObject {
    func showAlert(message: String)
    func showHud()
    func hideHud()
}

final class CreateTransactionViewModel {
    var dataSource: [TransactionModel] = []
    weak var delegate: CreateTransactionHandler?
    
    init(delegate: CreateTransactionHandler?) {
        self.delegate = delegate
        setupInitialData()
    }
    
    func setupInitialData() {
        dataSource = [
            TransactionModel(sectionType: .paymentType),
            TransactionModel(sectionType: .customerId, inputText: nil, errorText: "Please enter valid text"),
            TransactionModel(sectionType: .amount, inputText: nil, errorText: "Please enter valid text"),
            TransactionModel(sectionType: .date, inputText: nil),
            TransactionModel(sectionType: .transactionDescripition, inputText: nil)
        ]
    }
    
    func updateDataSource(index: Int, data: TransactionModel) {
        self.dataSource[index] = data
    }
    
    func validateinputs() -> Bool {
        let mandatoryDataSource = dataSource.filter({$0.sectionType != .transactionDescripition && $0.sectionType != .paymentType})
        return mandatoryDataSource.filter({!(($0.inputText ?? "").isEmpty) && !($0.showError == true)}).count == 3
    }
    
    func saveSpendMoneyData() {
        let paymentType = dataSource.first(where: {$0.sectionType == .paymentType})?.paymentType
        let customerId = dataSource.first(where: {$0.sectionType == .customerId})?.inputText
        let amount = dataSource.first(where: {$0.sectionType == .amount})?.inputText
        let date = dataSource.first(where: {$0.sectionType == .date})?.date
        let transactionDescripition = dataSource.first(where: {$0.sectionType == .transactionDescripition})?.inputText
        let amountVal = Double(amount ?? "") ?? 0.0
        let spendModel = SpendMoney(customerId: customerId ?? "", description: transactionDescripition ?? "", amount: amountVal, paymentType: paymentType == .makePayment ? "Debit" : "Credit", transactionType: "", dateTime: date ?? Date())
        SpendSmartManager.shared.addSpendAmount(spendModel: spendModel)
        delegate?.showAlert(message: "Data Saved Sucessfully:)")
    }
}
