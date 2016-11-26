//
//  InfomationViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/22.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol InfomationViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess(manager: CSAPIBaseManager)
    func callBackFailure()
}

class InfomationViewHelper: NSObject, CSAPIManagerApiCallBackDelegate,CSAPIManagerParamSourceDelegate {
    var infoManager: InfomationViewManager?
    var infoViewRrformer: SerialCartoonViewReformer?
    
    weak var callBackDelegate: InfomationViewCallBackDelegate?
    var infoViewController: InfomationViewController?
    var infoModel: SerialCartoonModel?
    
    //刷新数据
    var infoAllManager: InfomationAllManager?
    var infoAllReformer: SerialAllReformer?
    var infoAllModel: [NewCartoonModel]?
    
    //定义一个变量
    var page: Int?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(InfomationViewManager) {
            infoModel = apiManager.fetchData(infoViewRrformer!) as? SerialCartoonModel
            callBackDelegate?.callBackSuccess(apiManager)
        }
        if apiManager.isKindOfClass(InfomationAllManager) {
            infoAllModel = apiManager.fetchData(infoAllReformer!) as? [NewCartoonModel]
            callBackDelegate?.callBackSuccess(apiManager)
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(infoViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(infoViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(infoViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
        
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        if manager.isKindOfClass(InfomationViewManager) {
            
        }
        if manager.isKindOfClass(InfomationAllManager) {
            dic["pn"] = page
        }
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        infoManager = InfomationViewManager()
        infoViewRrformer = SerialCartoonViewReformer()
        infoModel = SerialCartoonModel()
        infoManager?.callBackDelegate = self
        infoManager?.paramSource = self
        
        infoAllManager = InfomationAllManager()
        infoAllReformer = SerialAllReformer()
        infoAllModel = [NewCartoonModel]()
        infoAllManager?.callBackDelegate = self
        infoAllManager?.paramSource = self
    }
}

