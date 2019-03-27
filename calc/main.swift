//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation
import Darwin


var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program

func  createInfixExpressionTree(expressionArray: [String]) throws ->BinaryTreeNode{

    var operatorStack = Stack<BinaryTreeNode>()
    var nodeStack = Stack<BinaryTreeNode>()
    var isContainsOperator = false
    
    for ex in expressionArray{
        if (Helpers.isOperand(input: ex)){
            nodeStack.push(BinaryTreeNode(nodeData: ex))
        }else if (Helpers.isOperator(input: ex)){

            while(operatorStack.count() > 0 && Helpers.getOperatorPriority(op: operatorStack.peek()!.nodeValue) >= Helpers.getOperatorPriority(op: ex)){
                if let node: BinaryTreeNode   = operatorStack.pop(){
                    node.rightNode = nodeStack.pop()
                    node.leftNode = nodeStack.pop()
                    nodeStack.push(node)
                }
            }
            operatorStack.push(BinaryTreeNode(nodeData: ex))
            isContainsOperator = true
        }else{
            throw CalcError.inputValueIsText(AppSetting.inputValueIsTextMsg)
        }
    }
    if (!isContainsOperator && nodeStack.count() != 1){
        throw CalcError.noOperator(AppSetting.noOperatorMsg)
    }
    while(operatorStack.count() > 0){
        if let node: BinaryTreeNode   = operatorStack.pop(){
            node.rightNode = nodeStack.pop()
            node.leftNode = nodeStack.pop()
            nodeStack.push(node)
        }
    }
    if let nodePeak = nodeStack.peek(){
        return nodePeak
    }else{
        throw CalcError.emptyInput(AppSetting.emptyInputMsg)
    }
}


func evaluateExpression(node: BinaryTreeNode) throws -> Int{
    var result: Int = 0

    if node.isLeaf(){
        if let input =  Int(node.nodeValue) {
                result = input
        } else{
            throw CalcError.inputValueIsText(AppSetting.inputValueIsTextMsg)
        }
    }else{
        do{
            
            let x =  try evaluateExpression(node: node.leftNode!)
            let y = try evaluateExpression(node: node.rightNode!)
            switch node.nodeValue {
            case AppSetting.plus: result = x + y;
            break;
            case AppSetting.minutes: result = x - y;
            break;
            case AppSetting.multiply: result = x * y;
            break;
            case AppSetting.devide:
                if (y == 0){
                    throw CalcError.deviveZero(AppSetting.deviveZeroMsg)
                }
                result = x / y;
                break;
            case AppSetting.modulo:
                if (y == 0){
                    throw CalcError.deviveZero(AppSetting.deviveZeroMsg)
                }
                result = x % y;
            break;
            default:
                print("go to default function")
            
            }
            
        }catch  CalcError.inputValueIsText(let erroMessage){
            throw CalcError.inputValueIsText(erroMessage)
        }
        
    }
    return result
}


do{
    let returnValue = try createInfixExpressionTree(expressionArray: args)
    let result = try evaluateExpression(node: returnValue)
    print(result)

//    let returnValue = try createInfixExpressionTree(expressionArray: ["50%", "+", "25%"])
//    let result = try evaluateExpression(node: returnValue)
//    print(result)
//
}catch  CalcError.deviveZero(let erroMessage){
    print(erroMessage)
    exit(1)
}
catch  CalcError.inputValueIsText(let erroMessage){
    print (erroMessage)
    exit(1)
}
catch  CalcError.noOperator(let erroMessage){
    print (erroMessage)
    exit(1)
}
catch  CalcError.couldNotFindOperatorNode(let erroMessage){
    print (erroMessage)
    exit(1)
}
catch  CalcError.emptyInput(let erroMessage){
    print (erroMessage)
    exit(1)
}

