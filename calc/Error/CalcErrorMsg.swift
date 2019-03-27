//
//  CalcErrorMsg.swift
//  calc
//
//  Created by Tran Nhut Minh An Le on 25/3/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import Foundation

enum CalcError: Error{
    case deviveZero(String)
    case inputValueIsText(String)
    case noOperator(String)
    case couldNotFindOperatorNode(String)
    case emptyInput(String)
}
