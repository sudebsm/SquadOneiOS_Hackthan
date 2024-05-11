//
//  SpendSmartManager.swift
//  SpendSmart
//
//  Created by Bharathimohan on 11/05/24.
//

import Foundation
class  SpendSmartManager {
    static let shared = SpendSmartManager()
    private var spendMoney: [SpendMoney]
    private init(){ spendMoney = []
        loadSpendTransactions()
    }
    
    func addSpendAmount(spendModel: SpendMoney) {
        guard spendModel.amount > 0 else {
            return
        }
        spendMoney.append(spendModel)
        saveSpendAmount()
    }
    
    func getAllSpendTransactions() -> [SpendMoney] {
        return spendMoney
    }
    
    func getSpendTransactions(forCustomerID customerId: String) -> [SpendMoney] {
        return spendMoney.filter { $0.customerId == customerId }
    }
    
    func getSpendTransactions(forDate date: Date) -> [SpendMoney] {
        let calendar = Calendar.current
        let filteredTransactions = spendMoney.filter { calendar.isDate($0.dateTime, inSameDayAs: date) }
        return filteredTransactions
    }
    
    func getSpendTransactions(forMonth month: Int, year: Int) -> [SpendMoney] {
        let calendar = Calendar.current
        print(spendMoney)
        return spendMoney.filter { calendar.component(.month, from: $0.dateTime) == month && calendar.component(.year, from: $0.dateTime) == year
        }
    }
    
    private func saveSpendAmount() {
        do { let encoder = JSONEncoder()
            let data = try encoder.encode(spendMoney)
            try data.write(to: spendTransactionFileURL())
        } catch {
            print("Error saving transactions: \(error.localizedDescription)")
        }
    }
    
    private func loadSpendTransactions() {
        do { let data = try Data(contentsOf: spendTransactionFileURL())
            let decoder = JSONDecoder()
            spendMoney = try decoder.decode([SpendMoney].self, from: data)
        } catch {
            print("Error loading transactions: \(error.localizedDescription)")
        }
    }
    
    private func spendTransactionFileURL() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("spendInformation.json")
    }
}
