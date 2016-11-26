//
//  VOCALOIDViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/24.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol VOCALOIDViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess(manager: CSAPIBaseManager)
    func callBackFailure()
}

class VOCALOIDViewHelper: NSObject, CSAPIManagerApiCallBackDelegate,CSAPIManagerParamSourceDelegate {
    var VOCALOIDManager: VOCALOIDViewManager?
    var VOCALOIDViewRrformer: SerialCartoonViewReformer?
    
    weak var callBackDelegate: VOCALOIDViewCallBackDelegate?
    var VOCALOIDViewController1: VOCALOIDViewController?
    var VOCALOIDModel: SerialCartoonModel?
    
    //刷新数据
    var vOCALOIDAllManager: VOCALOIDAllManager?
    var VOCALOIDAllReformer: SerialAllReformer?
    var VOCALOIDAllModel: [NewCartoonModel]?
    
    //定义一个变量
    var page: Int?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(VOCALOIDViewManager) {
            VOCALOIDModel = apiManager.fetchData(VOCALOIDViewRrformer!) as? SerialCartoonModel
            callBackDelegate?.callBackSuccess(apiManager)
        }
        if apiManager.isKindOfClass(VOCALOIDAllManager) {
            VOCALOIDAllModel = apiManager.fetchData(VOCALOIDAllReformer!) as? [NewCartoonModel]
            callBackDelegate?.callBackSuccess(apiManager)
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(VOCALOIDViewController1!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(VOCALOIDViewController1!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(VOCALOIDViewController1!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
        
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        if manager.isKindOfClass(VOCALOIDViewManager) {
            
        }
        if manager.isKindOfClass(VOCALOIDAllManager) {
            dic["pn"] = page
        }
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        VOCALOIDManager = VOCALOIDViewManager()
        VOCALOIDViewRrformer = SerialCartoonViewReformer()
        VOCALOIDModel = SerialCartoonModel()
        VOCALOIDManager?.callBackDelegate = self
        VOCALOIDManager?.paramSource = self
        
        vOCALOIDAllManager = VOCALOIDAllManager()
        VOCALOIDAllReformer = SerialAllReformer()
        VOCALOIDAllModel = [NewCartoonModel]()
        vOCALOIDAllManager?.callBackDelegate = self
        vOCALOIDAllManager?.paramSource = self
    }
}
