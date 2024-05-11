//
//  DatePickerTableViewCell.swift
//  SpendAnalyzer
//
//  Created by Hymavathi parimi on 11/05/24.
//

import UIKit

final class DatePickerTableViewCell: UITableViewCell {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var textField: UITextField! {
        didSet {
            textField.delegate = self
            textField.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        }
    }

    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    private var date: Date?
    private var callBack: ((_ input: String?,_ date: Date?) -> Void)?

    func layout(title: String, input: String?, showError: Bool, errorText: String?,callBack: ((_ input: String?,_ date: Date?) -> Void)?) {
        textField.text = input
        self.callBack = callBack
        titleLabel.text = title
        
        handleErrorState(showError: showError, errorText: errorText)
    }

    private func handleErrorState(showError: Bool, errorText: String?) {
        if showError {
            errorLabel.isHidden = false
            errorLabel.text = errorText
        } else {
            errorLabel.text = nil
            errorLabel.isHidden = true
        }
    }

    @objc func doneButtonPressed() {
        if let datePicker = self.textField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            date = datePicker.date
            self.textField.text = dateFormatter.string(from: date ?? Date())
        }
        self.textField.resignFirstResponder()
    }
}

extension DatePickerTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        doneButtonPressed()
        callBack?(self.textField.text, date)
    }
}
