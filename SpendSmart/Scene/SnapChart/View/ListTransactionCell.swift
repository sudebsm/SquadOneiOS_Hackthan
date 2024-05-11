//
//  ListTransactionCell.swift
//  SpendAnalizer
//
//  Created by Sudeb on 11/05/24.
//

import UIKit
import Charts

class ListTransactionCell: UITableViewCell {

    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var custLbl: UILabel!
    @IBOutlet var AmountLbl: UILabel!

    var modelData: SpendMoney?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(){
        if let data = modelData {
            dateLbl.text =  getDateAndTimeCustomFormat(date: data.dateTime)
            custLbl.text = data.customerId
            AmountLbl.text = "\(data.amount)"
        }
    }
    
    func getDateAndTimeCustomFormat(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: date)
    }
    
}
