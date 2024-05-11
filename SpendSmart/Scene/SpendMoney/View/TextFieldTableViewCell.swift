//
//  TextFieldTableViewCell.swift
//  SpendAnalyzer
//
//  Created by Hymavathi parimi on 11/05/24.
//

import UIKit

final class TextFieldTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var sectionType: Sectiontypes = .customerId
    private var callBack: ((_ input: String?, _ showError: Bool) -> Void)?
    
    func layout(input: String?, sectiontype: Sectiontypes, showError: Bool, errorText: String?, callBack: ((_ input: String?, _ showError: Bool) -> Void)?) {
        textField.text = input
        self.sectionType = sectiontype
        self.callBack = callBack
        titleLabel.text = sectiontype.getTitle()
        handleKeyboardType()
        handleErrorState(showError: showError, errorText: errorText)
    }
    
    private func handleKeyboardType() {
        switch sectionType {
        case .amount:
            textField.keyboardType = .decimalPad
        default:
            textField.keyboardType = .default
        }
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
}

extension TextFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            callBack?(nil, true)
            return
        }
        switch sectionType {
        case .amount:
            guard let amount = Int(text), amount > 0 else {
                callBack?(nil, true)
                return
            }
            callBack?(text, false)
        default:
            callBack?(text, false)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
