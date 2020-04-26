
//
//  CharityListViewModel.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import Foundation

/// This is the ViewModel class for CharityListViewController.
class CharityListViewModel: RowViewModel{
    
    //MARK:- Instance variables
    var imageUrl: String
    var charityName: String
    var onErrorHandling : ((String) -> Void)?
    
    //MARK:- Initializer
    init(imageUrl: String, charityName: String) {
        self.imageUrl = imageUrl
        self.charityName = charityName
    }
}
