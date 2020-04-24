//
//  CharityListController.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import Foundation

class CharityListController{
    
    //let viewModel : CharityListViewModel
    var viewModels = Observable<[RowViewModel]>(value: [])
    var charityListManager = OMDataManager()
    
//    init(viewModel: CharityListViewModel = CharityListViewModel()) {
//        self.viewModel = viewModel
//    }
    
    init(charityManager: OMDataManager = OMDataManager()) {
        self.charityListManager = charityManager
    }
    
    //API call
    func start(){
        //Webservice api call
        charityListManager.getCharitiesList { (charities, errorDescription) in
            if let error = errorDescription{
                print(error)
                self.viewModels.onErrorHandling?(error)
            }
            if let charities = charities{
                self.buildViewModels(charities: charities)
            }
        }
        //pass values and build view models
        //buildViewModels()
    }
    
    func buildViewModels(charities : [Charity]){
        //self.viewModel.value
        var viewModels = [RowViewModel]()
        for charity in charities{
            let charityListModel = CharityListViewModel(imageUrl: charity.logo_url, charityName: charity.name)
            charityListModel.cellPressed = { [weak self] in
                self?.handleCellPressed(charityListModel: charityListModel)
            }
            viewModels.append(charityListModel)
        }
        self.viewModels.value = viewModels
    }
    
    private func handleCellPressed(charityListModel: CharityListViewModel){
        //handle cell press
    }
}
