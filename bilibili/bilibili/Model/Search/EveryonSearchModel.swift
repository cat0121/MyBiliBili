//
//  EveryonSearchModel.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/5.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation

class EveryonSearchModel: NSObject {
    var keywords: [KeywordModel]?
    
    override init() {
        super.init()
    }
    init(keywords: [KeywordModel]) {
        self.keywords = keywords
    }
}

class KeywordModel: NSObject {
    var keyword: String?
    
    init(keyword: String) {
        self.keyword = keyword
    }
}