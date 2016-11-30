//
//  LiveModel.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/15.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import SwiftyJSON

class LiveModel: NSObject {
    var banner: [LiveBannerModel]?
//    var entranceIcons: Array<JSON>?
    var partions:[PartionsModel]?
    override init() {
        super.init()
    }
    init(banner: [LiveBannerModel], partions: [PartionsModel]) {
        self.banner = banner
//        self.entranceIcons = entranceIcons
        self.partions = partions
    }
}

//头视图
class LiveBannerModel: NSObject {
    var img: String?
    var uri: String?
    var title: String?
    init(img: String, uri: String, title: String) {
        self.img = img
        self.uri = uri
        self.title = title
    }
}

class PartionsModel: NSObject {
    var srcIcon: String?
    var name: String?
    var count: Int?
    var partionsDetails: [PartionsDetailsModel]?
    
    init(srcIcon: String, name: String, count: Int, partionsDetails: [PartionsDetailsModel]) {
        self.srcIcon = srcIcon
        self.name = name
        self.count = count
        self.partionsDetails = partionsDetails
    }
    
}
class PartionsDetailsModel: NSObject {
    var title: String?
    var srcImage: String?
    var authorName: String?
    var online: Int?
    
    init(title: String, srcImage: String, authorName: String, online: Int) {
        self.title = title
        self.srcImage = srcImage
        self.authorName = authorName
        self.online = online
    }
}