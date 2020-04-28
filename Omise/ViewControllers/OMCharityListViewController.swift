//
//  OMCharityListViewController.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import UIKit
import Foundation

///This view controller class shows the list of all the available charities in a table view
class OMCharityListViewController: OMBaseViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var charityListTableView: UITableView!
    @IBAction func unwindToCharityListVC(_ unwindSegue: UIStoryboardSegue) {}
    
    /// This is used to refresh the charities list
    private let refreshControl = UIRefreshControl()
    
    //MARK:- Instance variables
    var viewModels: Observable<[RowViewModel]>{
        return controller.viewModels
    }
    
    ///CharityListController instance, it is used to fetch all the charities and load viewmodels
    lazy var controller: CharityListController = {
        return CharityListController()
    }()
    
    //MARK:- view lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        viewModels.onErrorHandling = {error in
            self.updateUIAndShowError(errorMessage: error)
        }
        viewModels.valueChanged = { [weak self] (_) in
            self?.hideLoader()
            self?.charityListTableView.reloadData()
        }
        controller.start()
    }
    
    /// This method is used to update the UI in case of any errors while loading charoties like network failure, parsing error etc
    private func updateUIAndShowError(errorMessage: String){
        self.hideLoader()
        self.showAlert(message: errorMessage)
        self.refreshControl.endRefreshing()
        self.refreshControl.isHidden = true
        if self.viewModels.value.count > 0{
            self.charityListTableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    /// This is used to setUp UI like adding pull to refresh, setting table view footer and showing loader.
    func setUp(){
        showLoader()
        if #available(iOS 10.0, *) {
            charityListTableView.refreshControl = refreshControl
        } else {
            charityListTableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(reloadCharities), for: .valueChanged)
        charityListTableView.tableFooterView = UIView()
    }
    
    /// This method reloads the charities again
    @objc private func reloadCharities(_ sender: Any) {
        controller.start()
        refreshControl.endRefreshing()
        refreshControl.isHidden = true
    }
    
    ///Used to pass the selected charityname to the next donation screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? OMCharityDonationViewController{
            destinationVC.charityName = sender as? String
        }
    }
}

//MARK:- UITableViewDataSource methods
extension OMCharityListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModels.value.count == 0{
            tableView.setEmptyTableView(msgPullToRefresh)
        }else{
            tableView.restore()
        }
        return viewModels.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowViewModel = self.viewModels.value[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharityTableViewCell.self), for: indexPath)
        if let cell = cell as? CellConfigurable{
            cell.setUp(rowViewModel: rowViewModel)
        }
        return cell
    }
}

//MARK:- UITableViewDelegate methods
extension OMCharityListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = self.viewModels.value[indexPath.row]
        if let charityListViewModel = viewModel as? CharityListViewModel{
            performSegue(withIdentifier: String(describing:OMCharityDonationViewController.self), sender: charityListViewModel.charityName )
        }
    }
}
