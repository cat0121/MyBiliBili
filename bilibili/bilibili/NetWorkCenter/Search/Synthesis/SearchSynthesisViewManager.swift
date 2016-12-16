//
//  SearchSynthesisViewManager.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/8.
//  Copyright © 2016年 yan. All rights reserved.
//

import CSNetManager
import Alamofire

class SearchSynthesisViewManager: CSAPIBaseManager,CSAPIManagerDelegate {
    //版本号
    var apiVersion: String {
        return ""
    }
    //请求URL
    var apiName: String {//&keyword=夏目友人帐
        return "/x/v2/search?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&duration=0&mobi_app=iphone&order=default&platform=ios&ps=20&rid=0&sign=f2be0e64fb813ccad09ec9ac02fdde8d&ts=1480906803"
    }
    //请求方式
    var httpMethod: Alamofire.Method {
        return .GET
    }
    //服务器配置
    var server: CSServer {
        return kServer
    }
    
    override init() {
        super.init()
    }
    
}
