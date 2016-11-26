//
//  EndCartoonViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/22.
//  Copyright © 2016年 yan. All rights reserved.
//


import CSNetManager
import SwiftyJSON

protocol EndCartoonViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess(manager: CSAPIBaseManager)
    func callBackFailure()
}

class EndCartoonViewHelper: NSObject, CSAPIManagerApiCallBackDelegate,CSAPIManagerParamSourceDelegate {
    var endCartoonManager: EndCartoonViewManager?
    var endCartoonViewRrformer: SerialCartoonViewReformer?
    
    weak var callBackDelegate: EndCartoonViewCallBackDelegate?
    var endCartoonViewController: EndCartoonViewController?
    var endCartoonModel: SerialCartoonModel?

    //刷新数据
    var endAllManager: EndAllManager?
    var endAllReformer: SerialAllReformer?
    var endAllModel: [NewCartoonModel]?
    
    //定义一个变量
    var page: Int?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(EndCartoonViewManager) {
            endCartoonModel = apiManager.fetchData(endCartoonViewRrformer!) as? SerialCartoonModel
            callBackDelegate?.callBackSuccess(apiManager)
        }
        if apiManager.isKindOfClass(EndAllManager) {
            endAllModel = apiManager.fetchData(endAllReformer!) as? [NewCartoonModel]
            callBackDelegate?.callBackSuccess(apiManager)
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(endCartoonViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(endCartoonViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(endCartoonViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
        
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        if manager.isKindOfClass(EndCartoonViewManager) {
            
        }
        if manager.isKindOfClass(EndAllManager) {
            dic["pn"] = page
        }
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        endCartoonManager = EndCartoonViewManager()
        endCartoonViewRrformer = SerialCartoonViewReformer()
        endCartoonModel = SerialCartoonModel()
        endCartoonManager?.callBackDelegate = self
        endCartoonManager?.paramSource = self
        
        endAllManager = EndAllManager()
        endAllReformer = SerialAllReformer()
        endAllModel = [NewCartoonModel]()
        endAllManager?.callBackDelegate = self
        endAllManager?.paramSource = self
    }
}
