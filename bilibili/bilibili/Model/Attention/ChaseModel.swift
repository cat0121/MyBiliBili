//
//  ChaseModel.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/1.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation

class ChaseModel: NSObject {
    var chaseDetails: [ChaseDetails]?
    
    override init() {
        super.init()
    }
    init(chaseDetails: [ChaseDetails]) {
        self.chaseDetails = chaseDetails
    }
}

class ChaseDetails: NSObject {
    var cover: String!
    var title: String?
    var newest_ep_index: String?
    var last_ep_index: String?
    
    init(cover: String, title: String, newest_ep_index: String, last_ep_index: String) {
        self.cover = cover
        self.title = title
        self.newest_ep_index = newest_ep_index
        self.last_ep_index = last_ep_index
    }
}