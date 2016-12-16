//
//  FuzzySearchModel.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/7.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation

class FuzzySearchModel: NSObject {
    var keyword: String?
    var eachData: [EachModel]?
    
    override init() {
        super.init()
    }
    init(eachData: [EachModel]) {
        self.eachData = eachData
    }
}

class EachModel: NSObject {
    var name: String?
    
    init(name: String) {
        self.name = name
    }
}