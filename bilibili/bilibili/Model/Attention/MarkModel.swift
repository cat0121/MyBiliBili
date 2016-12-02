//
//  MarkModel.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/1.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation

class MarkModel: NSObject {
    var additions: [AdditionModel]?
    var page: Int?
    
    override init() {
        super.init()
    }
    init(additions: [AdditionModel], page: Int) {
        self.additions = additions
    }
}

class AdditionModel: NSObject {
    var title: String?
    var pic: String?
    //author
    var UP: String?
    var play: Int?
    //video_review
    var danmaku: Int?
    
    init(title: String, pic: String, UP: String, play: Int, danmaku: Int) {
        self.title = title
        self.pic = pic
        self.UP = UP
        self.play = play
        self.danmaku = danmaku
    }
}