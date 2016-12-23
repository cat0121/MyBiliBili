//
//  MineViewReformer.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/21.
//  Copyright © 2016年 yan. All rights reserved.
//

import CSNetManager
import SwiftyJSON

class MineViewReformer: CSReformer {
    func reformData(manager: CSAPIBaseManager, data: JSON) -> AnyObject {
        let mineModel = MineViewModel(face: data["face"].stringValue, coins: data["coins"].floatValue, birthday: data["birthday"].stringValue, telephone: data["telephone"].stringValue, uname: data["uname"].stringValue, sign: data["sign"].stringValue, current_level: data["level_info"]["current_level"].intValue,current_exp: data["level_info"]["current_exp"].intValue, next_exp: data["level_info"]["next_exp"].intValue, mid: data["mid"].intValue, sex: data["sex"].intValue)
        return mineModel
    }
}

