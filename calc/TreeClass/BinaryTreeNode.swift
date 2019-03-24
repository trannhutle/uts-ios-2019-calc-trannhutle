//
//  File.swift
//  calc
//
//  Created by Tran Nhut Minh An Le on 24/3/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import Foundation

class BinaryTreeNode {
    var leftNode: BinaryTreeNode?
    var rightNode: BinaryTreeNode?
    var nodeValue: String
    
    func isLeaf() -> Bool{
        return self.rightNode == nil && self.leftNode == nil
    }

    init(nodeData: String) {
        self.nodeValue = nodeData
        self.rightNode = nil
        self.leftNode = nil
    }
}
