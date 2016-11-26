//
//  ShortFilmViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol ShortFilmViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess(manager: CSAPIBaseManager)
    func callBackFailure()
}

class ShortFilmViewHelper: NSObject, CSAPIManagerApiCallBackDelegate,CSAPIManagerParamSourceDelegate {
    var shortManager: ShortFilmViewManager?
    var shortViewRrformer: SerialCartoonViewReformer?
    
    weak var callBackDelegate: ShortFilmViewCallBackDelegate?
    var shortViewController: ShortFilmViewController?
    var shortModel: SerialCartoonModel?
    
    //刷新数据
    var shortAllManager: ShortFilmAllManager?
    var shortAllReformer: SerialAllReformer?
    var shortAllModel: [NewCartoonModel]?
    
    //定义一个变量
    var page: Int?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(ShortFilmViewManager) {
            shortModel = apiManager.fetchData(shortViewRrformer!) as? SerialCartoonModel
            callBackDelegate?.callBackSuccess(apiManager)
        }
        if apiManager.isKindOfClass(ShortFilmAllManager) {
            shortAllModel = apiManager.fetchData(shortAllReformer!) as? [NewCartoonModel]
            callBackDelegate?.callBackSuccess(apiManager)
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(shortViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(shortViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(shortViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
        
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        if manager.isKindOfClass(ShortFilmViewManager) {
            
        }
        if manager.isKindOfClass(ShortFilmAllManager) {
            dic["pn"] = page
        }
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        shortManager = ShortFilmViewManager()
        shortViewRrformer = SerialCartoonViewReformer()
        shortModel = SerialCartoonModel()
        shortManager?.callBackDelegate = self
        shortManager?.paramSource = self
        
        shortAllManager = ShortFilmAllManager()
        shortAllReformer = SerialAllReformer()
        shortAllModel = [NewCartoonModel]()
        shortAllManager?.callBackDelegate = self
        shortAllManager?.paramSource = self
    }
}
