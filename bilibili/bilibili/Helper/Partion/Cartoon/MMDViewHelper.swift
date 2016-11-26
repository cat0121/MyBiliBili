//
//  MMDViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol MMDViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess(manager: CSAPIBaseManager)
    func callBackFailure()
}

class MMDViewHelper: NSObject, CSAPIManagerApiCallBackDelegate,CSAPIManagerParamSourceDelegate {
    var MMDManager: MMDViewManager?
    var MMDViewRrformer: SerialCartoonViewReformer?
    
    weak var callBackDelegate: MMDViewCallBackDelegate?
    var mmdViewController: MMDViewController?
    var MMDModel: SerialCartoonModel?
    
    //刷新数据
    var mmdAllManager: MMDAllManager?
    var MMDAllReformer: SerialAllReformer?
    var MMDAllModel: [NewCartoonModel]?
    
    //定义一个变量
    var page: Int?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(MMDViewManager) {
            MMDModel = apiManager.fetchData(MMDViewRrformer!) as? SerialCartoonModel
            callBackDelegate?.callBackSuccess(apiManager)
        }
        if apiManager.isKindOfClass(MMDAllManager) {
            MMDAllModel = apiManager.fetchData(MMDAllReformer!) as? [NewCartoonModel]
            callBackDelegate?.callBackSuccess(apiManager)
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(mmdViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(mmdViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(mmdViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
        
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        if manager.isKindOfClass(MMDViewManager) {
            
        }
        if manager.isKindOfClass(MMDAllManager) {
            dic["pn"] = page
        }
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        MMDManager = MMDViewManager()
        MMDViewRrformer = SerialCartoonViewReformer()
        MMDModel = SerialCartoonModel()
        MMDManager?.callBackDelegate = self
        MMDManager?.paramSource = self
        
        mmdAllManager = MMDAllManager()
        MMDAllReformer = SerialAllReformer()
        MMDAllModel = [NewCartoonModel]()
        mmdAllManager?.callBackDelegate = self
        mmdAllManager?.paramSource = self
    }
}

