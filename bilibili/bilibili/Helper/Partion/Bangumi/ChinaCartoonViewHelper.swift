//
//  ChinaCartoonViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/22.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol ChinaCartoonViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess(manager: CSAPIBaseManager)
    func callBackFailure()
}

class ChinaCartoonViewHelper: NSObject, CSAPIManagerApiCallBackDelegate,CSAPIManagerParamSourceDelegate {
    var chinaCartoonManager: ChinaCartoonViewManager?
    var chinaCartoonViewRrformer: SerialCartoonViewReformer?
    
    weak var callBackDelegate: ChinaCartoonViewCallBackDelegate?
    var chinaCartoonViewController: ChinaCartoonViewController?
    var chinaCartoonModel: SerialCartoonModel?
    
    //刷新数据
    var chinaAllManager: ChinaAllManager?
    var chinaAllReformer: SerialAllReformer?
    var chinaAllModel: [NewCartoonModel]?
    
    //定义一个变量
    var page: Int?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(ChinaCartoonViewManager) {
            chinaCartoonModel = apiManager.fetchData(chinaCartoonViewRrformer!) as? SerialCartoonModel
            callBackDelegate?.callBackSuccess(apiManager)
        }
        if apiManager.isKindOfClass(ChinaAllManager) {
            chinaAllModel = apiManager.fetchData(chinaAllReformer!) as? [NewCartoonModel]
            callBackDelegate?.callBackSuccess(apiManager)
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(chinaCartoonViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(chinaCartoonViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(chinaCartoonViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
        
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        if manager.isKindOfClass(ChinaCartoonViewManager) {
            
        }
        if manager.isKindOfClass(ChinaAllManager) {
            dic["pn"] = page
        }
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        chinaCartoonManager = ChinaCartoonViewManager()
        chinaCartoonViewRrformer = SerialCartoonViewReformer()
        chinaCartoonModel = SerialCartoonModel()
        chinaCartoonManager?.callBackDelegate = self
        chinaCartoonManager?.paramSource = self
        
        chinaAllManager = ChinaAllManager()
        chinaAllReformer = SerialAllReformer()
        chinaAllModel = [NewCartoonModel]()
        chinaAllManager?.callBackDelegate = self
        chinaAllManager?.paramSource = self
    }
}
