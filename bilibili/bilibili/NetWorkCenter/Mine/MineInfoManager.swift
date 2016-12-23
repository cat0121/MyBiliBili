//
//  MineInfoManager.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/23.
//  Copyright © 2016年 yan. All rights reserved.
//

import CSNetManager
import Alamofire

class MineInfoViewManager: CSAPIBaseManager,CSAPIManagerDelegate {
    //版本号
    var apiVersion: String {
        return ""
    }
    //请求URL
    var apiName: String {//&name=萌小猫
        return "/x/v2/space?access_key=c047fed0df3d42ac47e231e832ce4a53&build=4040&device=phone&mobi_app=1%AB121&platform=ios&vmid=52052310"
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

