//
//  SegmentsTableViewCell.swift
//  SpendAnalyzer
//
//  Created by Hymavathi parimi on 11/05/24.
//

import UIKit

final class SegmentsTableViewCell: UITableViewCell {
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.paymentType = .makePayment
        case 1:
            self.paymentType = .recievePayment
        default:
            self.paymentType = .makePayment
        }
        callBack?(paymentType)
    }

    private var paymentType: PaymentType! {
        didSet {
            handleSegmentIndex()
        }
    }
    private var callBack: ((_ selectedPaymentType: PaymentType) -> Void)?

    func layout(paymentType: PaymentType, callBack: ((_ selectedPaymentType: PaymentType) -> Void)?) {
        self.paymentType = paymentType
        self.callBack = callBack
    }

    private func handleSegmentIndex() {
        switch paymentType {
        case .makePayment:
            self.segmentControl.selectedSegmentIndex = 0
        case .recievePayment:
            self.segmentControl.selectedSegmentIndex = 1
        case .none:
            self.segmentControl.selectedSegmentIndex = 0
        }
    }
}
