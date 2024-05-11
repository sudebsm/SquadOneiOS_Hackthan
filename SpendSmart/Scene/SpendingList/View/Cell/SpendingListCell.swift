//
//  SpendingListCell.swift
//  HCLTask
//
//  Created by Abinash Reddy on 11/05/24.
//

import UIKit

class SpendingListCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var vwHighlight: UIView!
    @IBOutlet weak var spendAmount: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var vwImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpView()
    }
    
    //MARK: - Custom Methods
    private func setUpView() {
        self.vwHighlight.layer.borderWidth = 1
        self.vwHighlight.layer.cornerRadius = 10
        self.vwHighlight.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    func setData(data: SpendMoney) {
        self.spendAmount.text = String(data.amount)
        let date = AppUtils.shared.getDateAndTimeCustomFormat(date: data.dateTime)
        self.lblDate.text = date
        self.lblDesc.text = data.description
        
        switch data.transactionType {
        case "Debit":
            self.vwImg.image = UIImage(named: "send")
            self.vwImg.tintColor = UIColor.systemRed
        case "Credit":
            self.vwImg.image = UIImage(named: "recieve")
            self.vwImg.tintColor = UIColor.systemBlue
        default:
            break
        }
    }

}
