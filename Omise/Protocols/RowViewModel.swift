//
//  RowViewModel.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import Foundation

import Foundation

protocol RowViewModel{}

protocol ViewModelPressible{
    var cellPressed: (() -> Void)? {get set}
}

protocol CellConfigurable: RowViewModel{
    func setUp(rowViewModel: RowViewModel)
}
