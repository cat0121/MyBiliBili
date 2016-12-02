//
//  DynamicViewManager.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/1.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import Alamofire

class DynamicViewManager: CSAPIBaseManager,CSAPIManagerDelegate {
    //版本号
    var apiVersion: String {
        return ""
    }
    //请求URL
    var apiName: String {
        return "/search_recommend/list?_device=iphone&_hwid=27d487196f4b7df1&_ulv=10000&appkey=27eb53fc9058f8c3&appver=3970&build=3970&mid=52052310&platform=ios&recommend_type=upuser&ts=1480569537&type=json&sign=51e4ac992b9af788030380f1f907dbdf"
    }
    //请求方式
    var httpMethod: Alamofire.Method {
        return .GET
    }
    //服务器配置
    var server: CSServer {
        return aServer
    }
    
    override init() {
        super.init()
    }
}
