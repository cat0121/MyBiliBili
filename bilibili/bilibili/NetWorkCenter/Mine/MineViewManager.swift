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
        return "/api/myinfo/v2?_device=iphone&_hwid=27d487196f4b7df1&_ulv=10000&access_key=424ba271934bd985b823acef134f42a1&appkey=27eb53fc9058f8c3&appver=4070&build=4070&platform=ios&ts=1483411388&type=json&sign=e9ca84a4d9bd106e473f308ec191fdfd"
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
