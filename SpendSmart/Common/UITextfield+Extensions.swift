//
//  UITextfield+Extensions.swift
//  SpendAnalyzer
//
//  Created by Hymavathi parimi on 11/05/24.
//

import Foundation
import UIKit

extension UITextField {
    func addInputViewDatePicker(target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width

        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        self.inputView = datePicker

        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([flexibleSpace, doneBarButton], animated: false)

        self.inputAccessoryView = toolBar
    }
}
