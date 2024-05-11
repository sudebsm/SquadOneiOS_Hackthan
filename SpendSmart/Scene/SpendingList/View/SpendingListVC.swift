//
//  SpendingListVC.swift
//  HCLTask
//
//  Created by Abinash Reddy on 11/05/24.
//

import UIKit

class SpendingListVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var vwTable: UITableView!
    @IBOutlet weak var lblNoData: UILabel!
    
    //MARK: - Variable Declerations
    var viewModel = SpendingListViewModel()

    //MARK: - ViewContoller LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchSpendingList()
    }
    
    //MARK: - Custom Methods
    static func linkWithStoryboard() -> SpendingListVC? {
        return controller(with: .main,
                          identifier: self.className) as? SpendingListVC
    }

    private func registerNibs() {
        self.vwTable.register(UINib(nibName: SpendingListCell.className, bundle: nil), forCellReuseIdentifier: SpendingListCell.className)
    }
    
    func fetchSpendingList() {
        viewModel.fetchAllTransactions(customerId: "123") { [weak self] status in
            self?.vwTable.isHidden = false
            self?.lblNoData.isHidden = true
            if status {
                self?.vwTable.reloadData()
            } else {
                self?.vwTable.isHidden = true
                self?.lblNoData.isHidden = false
            }
        }
    }

}

//MARK: - UITableViewDataSource & UITableViewDelegate Methods
extension SpendingListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.spendListDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = vwTable.dequeueReusableCell(withIdentifier: SpendingListCell.className, for: indexPath) as? SpendingListCell else { return UITableViewCell()
        }
        cell.setData(data: self.viewModel.spendListDataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppRouter.navigateToSpendDetails(controller: self)
    }
        
}


