//
//  SearchClassifiyModel.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/16.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation

//MARK: -- 番剧
class SearchBanModel: NSObject {
    
    var keyword: String?
    var page: Int?
    var banngumi: [SeasonModel]?
    
    override init() {
        super.init()
    }
    init(bangumi: [SeasonModel]) {
        self.banngumi = bangumi
    }
}

//MARK: -- UP主
class SearchUPModel: NSObject {
    var ups: [UPModel]?
    
    override init() {
        super.init()
    }
    init(ups: [UPModel]) {
        self.ups = ups
    }
}
class UPModel: NSObject {
    var cover: String?
    var title: String?
    var sign: String?
    var fans: Int?
    var archives: Int?
    
    init(cover: String, title: String, fans: Int, archives: Int, sign: String) {
        self.cover = cover
        self.title = title
        self.fans = fans
        self.archives = archives
        self.sign = sign
    }
}

//MARK: -- 电影
class SearchMoiveModel: NSObject {
    
}

class SearchSubModel: NSObject {
    
}

