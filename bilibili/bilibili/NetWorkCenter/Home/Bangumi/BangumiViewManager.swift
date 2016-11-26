//
//  BangumiViewManager.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/16.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import Alamofire

class BangumiViewManager: CSAPIBaseManager, CSAPIManagerDelegate {
    //版本号
    var apiVersion: String {
        return ""
    }
    //请求URL
    var apiName: String {
        return "/api/app_index_page_v4?build=3940&device=phone&mobi_app=iphone&platform=ios"
    }
    //请求方式
    var httpMethod: Alamofire.Method {
        return .GET
    }
    //服务器配置
    var server: CSServer {
        return bServer
    }
    
    override init() {
        super.init()
    }

}