//
//  OfficalViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/22.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol OfficalViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess(manager: CSAPIBaseManager)
    func callBackFailure()
}

class OfficalViewHelper: NSObject, CSAPIManagerApiCallBackDelegate,CSAPIManagerParamSourceDelegate {
    var officalManager: OfficalViewManager?
    var officalViewRrformer: SerialCartoonViewReformer?
    
    weak var callBackDelegate: OfficalViewCallBackDelegate?
    var officalViewController: OfficalViewController?
    var officalModel: SerialCartoonModel?
    
    //刷新数据
    var officalAllManager: OfficalAllManager?
    var officalAllReformer: SerialAllReformer?
    var officalAllModel: [NewCartoonModel]?
    
    //定义一个变量
    var page: Int?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(OfficalViewManager) {
            officalModel = apiManager.fetchData(officalViewRrformer!) as? SerialCartoonModel
            callBackDelegate?.callBackSuccess(apiManager)
        }
        if apiManager.isKindOfClass(OfficalAllManager) {
            officalAllModel = apiManager.fetchData(officalAllReformer!) as? [NewCartoonModel]
            callBackDelegate?.callBackSuccess(apiManager)
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(officalViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(officalViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(officalViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
        
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        if manager.isKindOfClass(OfficalViewManager) {
            
        }
        if manager.isKindOfClass(OfficalAllManager) {
            dic["pn"] = page
        }
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        officalManager = OfficalViewManager()
        officalViewRrformer = SerialCartoonViewReformer()
        officalModel = SerialCartoonModel()
        officalManager?.callBackDelegate = self
        officalManager?.paramSource = self
        
        officalAllManager = OfficalAllManager()
        officalAllReformer = SerialAllReformer()
        officalAllModel = [NewCartoonModel]()
        officalAllManager?.callBackDelegate = self
        officalAllManager?.paramSource = self
    }
}


