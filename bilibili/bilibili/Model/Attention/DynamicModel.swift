//
//  DynamicModel.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/1.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation

class DynamicModel: NSObject {
    var videos: [DynamicVideos]?
    var page: Int?
    
    override init() {
        super.init()
    }
    init(videos: [DynamicVideos]) {
        self.videos = videos
    }
}

class DynamicVideoModel: NSObject {
    var cover: String?
    var title: String?
    
    init(cover: String, title: String) {
        self.cover = cover
        self.title = title
    }
}

class DynamicVideos: NSObject {
    var avatar: String?
    var fans: Int?
    var name: String?
    var video: [DynamicVideoModel]?
    
    init(avatar: String, fans: Int?, name: String, video: [DynamicVideoModel]) {
        self.avatar = avatar
        self.fans = fans
        self.name = name
        self.video = video
    }
}