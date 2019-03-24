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
        if input == "+" || input  == "-" || input  == "*" ||
            input  == "/" || input  == "%" {
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
        if op == "*" || op == "/" || op == "%" {
            return 2
        }else{
            return 1
        }
    }

}
