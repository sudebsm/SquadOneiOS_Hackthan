//
//  SnapShortViewController.swift
//  SpendAnalyzer
//
//  Created by Bharathimohan on 11/05/24.
//

import UIKit
import DGCharts
import iOSDropDown

enum FilterType : String {
    case Credit
    case Debit
    case Months
    case None
}


class SnapShortViewController: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var barChatView: BarChartView!
    @IBOutlet weak var dropDownMonth : UIButton!
    @IBOutlet weak var dropDownSpendType : UIButton!
    var filterType = FilterType.None
    var lastSelection = ""
    //MARK: - Variable Declerations
    var viewModel = SnapViewModel()

    
    let monthsSpendData = [Double]()
    let unitsBought = [Double]()
    let months = ["Jan", "Feb", "Mar","Apr", "May", "Jun","July", "Aug", "Sep","Oct", "Nov", "Dec"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ListTransactionCell", bundle: nil), forCellReuseIdentifier: "ListTransactionCell")
        addDropDown()
       // getDataByMonth(month: 1, year: 2024)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (lastSelection.count > 0) {
            if lastSelection != "" && (lastSelection == "Credit" ||  lastSelection == "Debit") {
                viewModel.fetchDataAll(type: lastSelection) {  _ in
                    self.setChart(dataPoints: self.months, values: self.viewModel.spendListDataSource)
                }
            }else {
                viewModel.fetchDataByMonth(customerId: "123", month: Int(lastSelection) ?? 5, year: 2024) { _ in
                    self.setChart(dataPoints: self.months, values: self.viewModel.spendListDataSource)
                }
            }
        }
    
    }
    
    func getDataByMonth(month: Int, year: Int) {
        viewModel.fetchDataByMonth(customerId: "123", month: month, year: year) { status in
            self.setChart(dataPoints: self.months, values: self.viewModel.spendListDataSource)
        }
    }
    
    func addDropDown(){
        let  dropDown1 = DropDown(frame: dropDownMonth.frame) // set frame
        dropDown1.optionArray = months
        dropDown1.didSelect{(selectedText , index ,id) in
            self.dropDownMonth.setTitle(selectedText, for: .normal)
            dropDown1.textColor = UIColor.clear
            dropDown1.text = ""
            self.getDataByMonth(month: index+1, year: 2024)
            self.tableView.reloadData()
            self.lastSelection = "\(index+1)"
        }
        dropDown1.inputView = dropDownMonth.inputView
        dropDown1.center = dropDownMonth.center
        dropDown1.selectedRowColor = .lightGray
        dropDown1.arrowColor = .clear
        dropDown1.endEditing(true)
        self.view.addSubview(dropDown1)
        
        let  dropDown2 = DropDown(frame: dropDownSpendType.frame) // set frame
        dropDown2.optionArray = ["Credit", "Debit"]
        dropDown2.inputView = dropDownSpendType.inputView
        dropDown2.center = dropDownSpendType.center
        dropDown2.didSelect{(selectedText , index ,id) in
            self.dropDownSpendType.setTitle(selectedText, for: .normal)
            dropDown2.textColor = UIColor.clear
            dropDown2.text = ""
            
            self.viewModel.fetchDataAll(type:(index == 0) ? "Credit" : "Debit") { status in
                self.setChart(dataPoints: self.months, values: self.viewModel.spendListDataSource)
            }
            self.tableView.reloadData()
            self.lastSelection = selectedText
        }
        dropDown2.selectedRowColor = .lightGray
        dropDown2.center = dropDownSpendType.center
        dropDown2.endEditing(true)
        self.view.addSubview(dropDown2)
    }
    
    func setChart(dataPoints: [String], values: [SpendMoney]) {
        var dataEntries: [BarChartDataEntry] = []
        if values.count > 0 {
            for i in 0..<values.count {
                let dataEntry = BarChartDataEntry(x: Double(i+2), y:values[i].amount, data: months )
                dataEntries.append(dataEntry)
            }
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Months")
        
        let chartData = BarChartData()
        chartData.append(chartDataSet)
        barChatView.data = chartData
    }
    
}

extension SnapShortViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.viewModel.spendListDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTransactionCell", for: indexPath) as! ListTransactionCell
        let dataModel = self.viewModel.spendListDataSource[indexPath.row]
        cell.modelData = dataModel
        cell.configCell()
        return cell
        
    }
}

