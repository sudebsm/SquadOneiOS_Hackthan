//
//  CreateTransactionViewController.swift
//  SpendAnalyzer
//
//  Created by Hymavathi parimi on 11/05/24.
//

import UIKit

class CreateTransactionViewController: UIViewController {
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 100
            tableView.tableFooterView = UIView()
            tableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    private var viewModel: CreateTransactionViewModel?
    var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CreateTransactionViewModel(delegate: self)
    }
    
    private func reloadData(index: Int, data: TransactionModel) {
        self.viewModel?.updateDataSource(index: index, data: data)
        self.tableView.reloadData()
    }
}

extension CreateTransactionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var dataSource = viewModel?.dataSource[indexPath.row] else {
            return UITableViewCell()
        }
        switch dataSource.sectionType {
        case .amount:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as? TextFieldTableViewCell else {
                return UITableViewCell()
            }
            cell.layout(input: dataSource.inputText, sectiontype: dataSource.sectionType, showError: dataSource.showError, errorText: dataSource.errorText, callBack: { [weak self] input, errorState in
                guard let self else { return }
                dataSource.inputText = input
                dataSource.showError = errorState
                self.reloadData(index: indexPath.row, data: dataSource)
            })
            return cell
        case .customerId:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as? TextFieldTableViewCell else {
                return UITableViewCell()
            }
            cell.layout(input: dataSource.inputText, sectiontype: dataSource.sectionType, showError: dataSource.showError, errorText: dataSource.errorText, callBack: { [weak self] input, errorState in
                guard let self else { return }
                dataSource.inputText = input
                dataSource.showError = errorState
                self.reloadData(index: indexPath.row, data: dataSource)
            })
            return cell
        case .transactionDescripition:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewTableViewCell", for: indexPath) as? TextViewTableViewCell else {
                return UITableViewCell()
            }
            cell.layout(input: dataSource.inputText, titleLabelText: dataSource.sectionType.getTitle(), callBack: { [weak self] input in
                guard let self else { return }
                dataSource.inputText = input
                self.reloadData(index: indexPath.row, data: dataSource)
            })
            return cell
        case .paymentType:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SegmentsTableViewCell", for: indexPath) as? SegmentsTableViewCell else {
                return UITableViewCell()
            }
            cell.layout(paymentType: dataSource.paymentType) { [weak self] selectedPaymentType in
                guard let self else { return }
                dataSource.paymentType = selectedPaymentType
                self.reloadData(index: indexPath.row, data: dataSource)
            }
            return cell
        case .date:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerTableViewCell", for: indexPath) as? DatePickerTableViewCell else {
                return UITableViewCell()
            }
            cell.layout(title: dataSource.sectionType.getTitle(), input: dataSource.inputText, showError: dataSource.showError, errorText: dataSource.errorText, callBack: { [weak self] input,date in
                guard let self else { return }
                dataSource.date = date
                dataSource.inputText = input
                self.reloadData(index: indexPath.row, data: dataSource)
            })
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        let button = UIButton(type: .custom)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = UIColor.blue.withAlphaComponent(0.8)
        button.layer.cornerRadius = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(button)
        button.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.isEnabled = viewModel?.validateinputs() ?? false
        button.backgroundColor = (viewModel?.validateinputs() ?? false) ? UIColor.blue.withAlphaComponent(0.8) : UIColor.blue.withAlphaComponent(0.2)
        button.addTarget(self, action: #selector(saveTapped(_:)), for: .touchUpInside)
        return footerView
    }
    
    @objc func saveTapped(_ sender: UIButton) {
        
        viewModel?.saveSpendMoneyData()
    }
}

extension CreateTransactionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CreateTransactionViewController: CreateTransactionHandler {
    func showAlert(message: String) {
        ToastManager.shared.makeToast(controller: self, message, completion: { [weak self] _ in
            guard let self else { return }
          
        })
        
        self.viewModel?.dataSource = []
        self.viewModel?.setupInitialData()
        self.tableView.reloadData()
    }
    func showHud() {
        
    }
    
    func hideHud() {
        
    }
    
    
}
