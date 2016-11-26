//
//  LiveViewManager.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/14.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import Alamofire

class LiveViewManager: CSAPIBaseManager,CSAPIManagerDelegate {
    //版本号
    var apiVersion: String {
        return ""
    }
    //请求URL
    var apiName: String {
        return "/AppNewIndex/common?scale=2&device=phone&platform=ios"
    }
    //请求方式
    var httpMethod: Alamofire.Method {
        return .GET
    }
    //服务器配置
    var server: CSServer {
        return lServer
    }
    
    override init() {
        super.init()
    }
}