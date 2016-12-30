//
//  MineInfoModel.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/23.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation

class MineInfoModel: NSObject {
    var name: String?
    var tag: [TagModel]?
    var favourite: FavouriteModel?
    var season: MineSeasonModel?
    
    override init() {
        super.init()
    }
    
    init(tag: [TagModel], favourite: FavouriteModel, season: MineSeasonModel) {
        self.tag = tag
        self.favourite = favourite
        self.season = season
    }
}
//favourite
class FavouriteModel: NSObject {
    var item: [FavouriteItem]?
    
    init(item: [FavouriteItem]) {
        self.item = item
    }
}
class FavouriteItem: NSObject {
    var name: String?
    var cur_count: Int?
    var pic: String?
    
    init(name: String, cur_count: Int, pic: String) {
        self.name = name
        self.cur_count = cur_count
        self.pic = pic
    }
}
//season
class MineSeasonModel: NSObject {
    var item: [SeasonItem]?
    
    init(item: [SeasonItem]) {
        self.item = item
    }
}
class SeasonItem: NSObject {
    var cover:  String?
    var title: String?
    var newest_ep_index: String?
    var total_count: String?
    
    init(cover: String, title: String, newest_ep_index: String, total_count: String) {
        self.cover = cover
        self.title = title
        self.newest_ep_index = newest_ep_index
        self.total_count = total_count
    }
}
//tag
class TagModel: NSObject {
    var tag_name: String?
    
    init(tag_name: String) {
        self.tag_name = tag_name
    }
}