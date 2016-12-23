//
//  MineViewManager.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/21.
//  Copyright © 2016年 yan. All rights reserved.
//

import CSNetManager
import Alamofire

class MineViewManager: CSAPIBaseManager,CSAPIManagerDelegate {
    //版本号
    var apiVersion: String {
        return ""
    }
    //请求URL
    var apiName: String {
        return "/api/myinfo/v2?access_key=c047fed0df3d42ac47e231e832ce4a53&appkey=27eb53fc9058f8c3&platform=ios&ts=1482289744&type=json&sign=2243d1b84ce3e0882a639a9dee555ba5"
    }
    //请求方式
    var httpMethod: Alamofire.Method {
        return .GET
    }
    //服务器配置
    var server: CSServer {
        return acServer
    }
    
    override init() {
        super.init()
    }

}
