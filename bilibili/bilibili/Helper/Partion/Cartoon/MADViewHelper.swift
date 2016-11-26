//
//  MADViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol MADViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess(manager: CSAPIBaseManager)
    func callBackFailure()
}

class MADViewHelper: NSObject, CSAPIManagerApiCallBackDelegate,CSAPIManagerParamSourceDelegate {
    var MADManager: MADViewManager?
    var MADViewRrformer: SerialCartoonViewReformer?
    
    weak var callBackDelegate: MADViewCallBackDelegate?
    var madViewController: MADViewController?
    var MADModel: SerialCartoonModel?
    
    //刷新数据
    var madAllManager: MADAllManager?
    var MADAllReformer: SerialAllReformer?
    var MADAllModel: [NewCartoonModel]?
    
    //定义一个变量
    var page: Int?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(MADViewManager) {
            MADModel = apiManager.fetchData(MADViewRrformer!) as? SerialCartoonModel
            callBackDelegate?.callBackSuccess(apiManager)
        }
        if apiManager.isKindOfClass(MADAllManager) {
            MADAllModel = apiManager.fetchData(MADAllReformer!) as? [NewCartoonModel]
            callBackDelegate?.callBackSuccess(apiManager)
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(madViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(madViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(madViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
        
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        if manager.isKindOfClass(MADViewManager) {
            
        }
        if manager.isKindOfClass(MADAllManager) {
            dic["pn"] = page
        }
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        MADManager = MADViewManager()
        MADViewRrformer = SerialCartoonViewReformer()
        MADModel = SerialCartoonModel()
        MADManager?.callBackDelegate = self
        MADManager?.paramSource = self
        
        madAllManager = MADAllManager()
        MADAllReformer = SerialAllReformer()
        MADAllModel = [NewCartoonModel]()
        madAllManager?.callBackDelegate = self
        madAllManager?.paramSource = self
    }
}

