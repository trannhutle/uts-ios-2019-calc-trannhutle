//
//  Utils.swift
//  calc
//
//  Created by Tran Nhut Minh An Le on 24/3/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import Foundation
class Helpers{
    
    static func isOperator(input: String) -> Bool{
        if input == AppSetting.plus || input  == AppSetting.minutes || input  == AppSetting.multiply ||
            input  == AppSetting.devide || input  == AppSetting.modulo {
            return true
        }
        return false
    }
    
    static func isOperand(input: String) ->Bool{
        let num = Int(input)
        if num != nil{
            return true
        }
        return false
    }
    
    static func getOperatorPriority(op: String) -> Int {
        if op == AppSetting.multiply || op == AppSetting.devide || op == AppSetting.modulo {
            return 2
        }else{
            return 1
        }
    }

}
