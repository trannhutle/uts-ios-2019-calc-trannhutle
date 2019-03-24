//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation


var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program

print("the application starts")

print(args)

//print(Int(args[0])!)


func  createInfixExpressionTree(expressionStr: String) ->BinaryTreeNode{

    let expression_array = expressionStr.components(separatedBy: " ")
    var operatorStack = Stack<BinaryTreeNode>()
    var nodeStack = Stack<BinaryTreeNode>()

    for ex in expression_array{
        if (Helpers.isOperand(input: ex)){
            nodeStack.push(BinaryTreeNode(nodeData: ex))
        }else if (Helpers.isOperator(input: ex)){

            while(operatorStack.count() > 0 && Helpers.getOperatorPriority(op: operatorStack.peek()!.nodeValue) >= Helpers.getOperatorPriority(op: ex)){
                let node = operatorStack.pop()!;
                node.rightNode = nodeStack.pop()!
                node.leftNode = nodeStack.pop()!
                nodeStack.push(node)
            }
            operatorStack.push(BinaryTreeNode(nodeData: ex))
        }
    }
    
    while(operatorStack.count() > 0){
        let node = operatorStack.pop()!;
        node.rightNode = nodeStack.pop()!
        node.leftNode = nodeStack.pop()!
        nodeStack.push(node)
    }
    return nodeStack.peek()!
}


func evaluateExpression(node: BinaryTreeNode) throws -> Float{
    var result: Float = 0.0
    
    if node.isLeaf(){
        result = Float(node.nodeValue)!
    }else{
        let x = try evaluateExpression(node: node.leftNode!)
        let y = try evaluateExpression(node: node.rightNode!)
        switch node.nodeValue {
        case "+": result = x + y;
        break;
        case "-": result = x - y;
        break;
        case "*": result = x * y;
        break;
        case "/":
            if y == 0{
                throw CalcError.deviveZero("Devide zero")
            }else{
                result = x / y;
            }
        break;
        case "%": result = x.truncatingRemainder(dividingBy: y);
        break;
        default:
            print("go to default function")
        }
    }
    return result
}

//var returnValue = createInfixExpressionTree(expressionStr: "-9 -5 / 2 + 1")
var returnValue = createInfixExpressionTree(expressionStr: "-9 - 5 / 0 + 1")
//var returnValue = createInfixExpressionTree(expressionStr: "+20 / 3")
do{
    print (try evaluateExpression(node: returnValue))
}
catch CalcError.deviveZero(let errorMessage){
    print(errorMessage)
}


