//
//  SerialAllReformer.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/21.
//  Copyright © 2016年 yan. All rights reserved.
//

import SwiftyJSON
import CSNetManager

class SerialAllReformer: CSReformer {
    func reformData(manager: CSAPIBaseManager, data: JSON) -> AnyObject {
        
        let newJSON = data["data"]
        var news = [NewCartoonModel]()
        for j in 0..<newJSON.count {
            let newCartoon = NewCartoonModel(cover: newJSON[j]["cover"].stringValue, title: newJSON[j]["title"].stringValue, name: newJSON[j]["name"].stringValue, play: newJSON[j]["play"].intValue, danmaku: newJSON[j]["danmaku"].intValue)
            news.append(newCartoon)
        }
        
        return news
    }
}
