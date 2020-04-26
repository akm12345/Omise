//
//  CharityListController.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import Foundation

/// This class is responsible for managing viewmodels for charity view controller
class CharityListController{
    
    //MARK:- Instance variables
    var viewModels = Observable<[RowViewModel]>(value: [])
    var charityListManager = OMDataManager()
    
    //MARK:- Initializer
    init(charityManager: OMDataManager = OMDataManager()) {
        self.charityListManager = charityManager
    }
    
    //MARK:- Instance methods
    /// This method starts buidilg viewmodels after fetching charities from webservice
    func start(){
        charityListManager.getCharitiesList { (charities, errorDescription) in
            if let error = errorDescription{
                print(error)
                self.viewModels.onErrorHandling?(error)
            }
            if let charities = charities{
                self.buildViewModels(charities: charities)
            }
        }
    }
    
    /// This method parses the charities to their corressponding viewmodel
    func buildViewModels(charities : [Charity]){
        //self.viewModel.value
        var viewModels = [RowViewModel]()
        for charity in charities{
            let charityListModel = CharityListViewModel(imageUrl: charity.logo_url, charityName: charity.name)
            viewModels.append(charityListModel)
        }
        self.viewModels.value = viewModels
    }
}
