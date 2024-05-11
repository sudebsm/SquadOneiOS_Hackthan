//
//  TextViewTableViewCell.swift
//  SpendAnalyzer
//
//  Created by Hymavathi parimi on 11/05/24.
//

import UIKit

final class TextViewTableViewCell: UITableViewCell {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.delegate = self
            textView.layer.borderWidth = 1
            textView.layer.borderColor = UIColor.lightGray.cgColor
            textView.layer.cornerRadius = 2
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    private var callBack: ((_ input: String?) -> Void)?
    
    func layout(input: String?, titleLabelText: String, callBack: ((_ input: String?) -> Void)?) {
        self.textView.text = input
        titleLabel.text = titleLabelText
        self.callBack = callBack
    }

}

extension TextViewTableViewCell: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let text = textView.text, !text.isEmpty else {
            callBack?(nil)
            return
        }
        callBack?(text)
    }

}
