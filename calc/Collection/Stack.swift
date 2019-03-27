//
//  stack.swift
//  calc
//
//  Created by Tran Nhut Minh An Le on 24/3/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import Foundation

struct Stack<Element> {
    
    fileprivate var array: [Element] = []
    
    mutating func push(_ element: Element){
        self.array.append(element)
    }
    
    mutating func pop() -> Element?{
        return self.array.popLast()
    }
    
    func peek() -> Element?{
        return self.array.last!
    }
    
    func count() -> Int{
        return self.array.count
    }
    
}
