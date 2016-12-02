//
//  ChaseViewReformer.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/1.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

class ChaseViewReformer: CSReformer {
    func reformData(manager: CSAPIBaseManager, data: JSON) -> AnyObject {
        if manager.isKindOfClass(ChaseViewManager) {
            let dataJSON = data["result"]
            
            var chaseDetails = [ChaseDetails]()
            for i in 0..<dataJSON.count {
                let chase = ChaseDetails(cover: dataJSON[i]["cover"].stringValue, title: dataJSON[i]["title"].stringValue, newest_ep_index: dataJSON[i]["newest_ep_index"].stringValue, last_ep_index: dataJSON[i]["user_season"]["last_ep_index"].stringValue)
                chaseDetails.append(chase)
            }
            
            let chaseArr = ChaseModel(chaseDetails: chaseDetails)
            return chaseArr
        }
        return ChaseModel()
    }
}