//
//  SerialCartoonViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/21.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol SerialCartoonViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess(manager: CSAPIBaseManager)
    func callBackFailure()
}

class SerialCartoonViewHelper: NSObject, CSAPIManagerApiCallBackDelegate,CSAPIManagerParamSourceDelegate {
    var serialCartoonManager: SerialCartoonViewManager?
    var serialCartoonViewRrformer: SerialCartoonViewReformer?
    var serialAllManager: SerialAllManager?
    var serialAllReformer: SerialAllReformer?
    
    weak var callBackDelegate: SerialCartoonViewCallBackDelegate?
    var serialCartoonViewController: SerialCartoonViewController?
    var serialCartoonModel: SerialCartoonModel?
    //刷新数据
    var serialAllModel: [NewCartoonModel]?
    
    //定义一个变量
    var page: Int?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(SerialCartoonViewManager) {
            serialCartoonModel = apiManager.fetchData(serialCartoonViewRrformer!) as? SerialCartoonModel
            callBackDelegate?.callBackSuccess(apiManager)
        }
        if apiManager.isKindOfClass(SerialAllManager) {
            serialAllModel = apiManager.fetchData(serialAllReformer!) as? [NewCartoonModel]
            callBackDelegate?.callBackSuccess(apiManager)
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(serialCartoonViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(serialCartoonViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(serialCartoonViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
        
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        if manager.isKindOfClass(SerialCartoonViewManager) {
            
        }
        if manager.isKindOfClass(SerialAllManager) {
            dic["pn"] = page
        }
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        serialCartoonManager = SerialCartoonViewManager()
        serialCartoonViewRrformer = SerialCartoonViewReformer()
        serialCartoonModel = SerialCartoonModel()
        serialCartoonManager?.callBackDelegate = self
        serialCartoonManager?.paramSource = self
        
        serialAllManager = SerialAllManager()
        serialAllReformer = SerialAllReformer()
        serialAllModel = [NewCartoonModel]()
        serialAllManager?.callBackDelegate = self
        serialAllManager?.paramSource = self
    }
}
