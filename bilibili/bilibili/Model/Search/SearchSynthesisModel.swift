//
//  SearchSynthesisModel.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/7.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation

class SearchSynthesisModel: NSObject {
    var archives: [ArchiveModel]?
    var seasons: [SeasonModel]?
    var keyword: String?
    var page: Int?
    
    override init() {
        super.init()
    }
    init(archives: [ArchiveModel], seasons: [SeasonModel]) {
        self.archives = archives
        self.seasons = seasons
    }
}

class ArchiveModel: NSObject {
    var author: String?
    var cover: String?
    var danmaku: Int?
    var play: Int?
    var title: String?
    var duration: String?
    
    init(author: String, cover: String, danmaku: Int, play: Int, title: String, duration: String) {
        self.author = author
        self.cover = cover
        self.danmaku = danmaku
        self.play = play
        self.title = title
        self.duration = duration
    }
}

class SeasonModel: NSObject {
    var cat_desc: String?
    var cover: String?
    var index: String?
    var newest_season: String?
    var title: String?
    var goto: String?
    
    init(cat_desc: String, cover: String, index: String, newest_season: String, title: String, goto: String) {
        self.cat_desc = cat_desc
        self.cover = cover
        self.index = index
        self.newest_season = newest_season
        self.title = title
        self.goto = goto
    }
}