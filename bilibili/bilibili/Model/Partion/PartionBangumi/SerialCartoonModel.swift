//
//  SerialCartoonModel.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/21.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation

class SerialCartoonModel: NSObject {
    var recCartoon: [RecCartoonModel]?
    var newCartoon: [NewCartoonModel]?
    
    override init() {
        super.init()
    }
    init(recCartoon: [RecCartoonModel], newCartoon: [NewCartoonModel]) {
        self.recCartoon = recCartoon
        self.newCartoon = newCartoon
    }
}

class RecCartoonModel: NSObject {
    var cover: String?
    var title: String?
    var name: String?
    var play: Int?
    var danmaku: Int?
    
    init(cover: String, title: String, name: String, play: Int, danmaku: Int) {
        self.cover = cover
        self.title = title
        self.name = name
        self.play = play
        self.danmaku = danmaku
    }
}

class NewCartoonModel: NSObject {
    var cover: String?
    var title: String?
    var name: String?
    var play: Int?
    var danmaku: Int?
    
    init(cover: String, title: String, name: String, play: Int, danmaku: Int) {
        self.cover = cover
        self.title = title
        self.name = name
        self.play = play
        self.danmaku = danmaku
    }
}