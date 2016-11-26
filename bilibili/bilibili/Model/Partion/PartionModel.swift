//
//  PartionModel.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/17.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation

class PartionModel: NSObject {
    var name: String?
    
    override init() {
        super.init()
    }
    
    init(name: String) {
        self.name = name
    }
}