//
//  AppUtils.swift
//  SpendSmart
//
//  Created by Abinash Reddy on 11/05/24.
//

import Foundation

class AppUtils {
    static let shared = AppUtils()
    
    private init() {
        
    }
    
    func getDateAndTimeCustomFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    
}
