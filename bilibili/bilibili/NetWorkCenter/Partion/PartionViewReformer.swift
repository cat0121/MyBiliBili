//
//  PartionViewReformer.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/17.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

class PartionViewReformer: CSReformer {
    func reformData(manager: CSAPIBaseManager, data: JSON) -> AnyObject {
        let dataJSON = data["data"]
        
        var partArr = [PartionModel]()
        for i in 0..<dataJSON.count {
            let partionModel = PartionModel(name: dataJSON[i]["name"].stringValue)
            partArr.append(partionModel)
        }
        return partArr
    }
}