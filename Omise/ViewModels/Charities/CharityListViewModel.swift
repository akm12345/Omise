
//
//  CharityListViewModel.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import Foundation

class CharityListViewModel: RowViewModel, ViewModelPressible{
    var imageUrl: String
    var charityName: String
    var cellPressed: (() -> Void)?
    var onErrorHandling : ((String) -> Void)?
    
    init(imageUrl: String, charityName: String) {
        self.imageUrl = imageUrl
        self.charityName = charityName
    }
}
