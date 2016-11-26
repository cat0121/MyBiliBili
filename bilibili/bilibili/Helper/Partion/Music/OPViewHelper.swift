//
//  OPViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/24.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol OPViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess(manager: CSAPIBaseManager)
    func callBackFailure()
}

class OPViewHelper: NSObject, CSAPIManagerApiCallBackDelegate,CSAPIManagerParamSourceDelegate {
    var OPManager: OPViewManager?
    var OPViewRrformer: SerialCartoonViewReformer?
    
    weak var callBackDelegate: OPViewCallBackDelegate?
    var opViewController: OPViewController?
    var OPModel: SerialCartoonModel?
    
    //刷新数据
    var opAllManager: OPAllManager?
    var opAllReformer: SerialAllReformer?
    var opAllModel: [NewCartoonModel]?
    
    //定义一个变量
    var page: Int?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(OPViewManager) {
            OPModel = apiManager.fetchData(OPViewRrformer!) as? SerialCartoonModel
            callBackDelegate?.callBackSuccess(apiManager)
        }
        if apiManager.isKindOfClass(OPAllManager) {
            opAllModel = apiManager.fetchData(opAllReformer!) as? [NewCartoonModel]
            callBackDelegate?.callBackSuccess(apiManager)
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(opViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(opViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(opViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
        
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        if manager.isKindOfClass(OPViewManager) {
            
        }
        if manager.isKindOfClass(OPAllManager) {
            dic["pn"] = page
        }
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        OPManager = OPViewManager()
        OPViewRrformer = SerialCartoonViewReformer()
        OPModel = SerialCartoonModel()
        OPManager?.callBackDelegate = self
        OPManager?.paramSource = self
        
        opAllManager = OPAllManager()
        opAllReformer = SerialAllReformer()
        opAllModel = [NewCartoonModel]()
        opAllManager?.callBackDelegate = self
        opAllManager?.paramSource = self
    }
}
