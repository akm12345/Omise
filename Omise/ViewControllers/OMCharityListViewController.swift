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
        self.showLoader()
        self.charityListTableView.tableFooterView = UIView()
        viewModels.onErrorHandling = {error in
            self.showAlert(message: error)
        }
        viewModels.valueChanged = { [weak self] (_) in
            self?.hideLoader()
            self?.charityListTableView.reloadData()
        }
        controller.start()
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
//        if let viewModel = viewModel as? ViewModelPressible{
//            viewModel.cellPressed?()
//        }
        if let charityListViewModel = viewModel as? CharityListViewModel{
            performSegue(withIdentifier: "OMCharityDonationViewController" , sender: charityListViewModel.charityName )
        }
    }
}
