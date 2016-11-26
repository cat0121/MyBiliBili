//
//  ThreeViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/24.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol ThreeViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess(manager: CSAPIBaseManager)
    func callBackFailure()
}

class ThreeViewHelper: NSObject, CSAPIManagerApiCallBackDelegate,CSAPIManagerParamSourceDelegate {
    var threeManager: ThreeViewManager?
    var threeViewRrformer: SerialCartoonViewReformer?
    
    weak var callBackDelegate: ThreeViewCallBackDelegate?
    var threeViewController: ThreeViewController?
    var threeModel: SerialCartoonModel?
    
    //刷新数据
    var threeAllManager: ThreeAllManager?
    var threeAllReformer: SerialAllReformer?
    var threeAllModel: [NewCartoonModel]?
    
    //定义一个变量
    var page: Int?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(ThreeViewManager) {
            threeModel = apiManager.fetchData(threeViewRrformer!) as? SerialCartoonModel
            callBackDelegate?.callBackSuccess(apiManager)
        }
        if apiManager.isKindOfClass(ThreeAllManager) {
            threeAllModel = apiManager.fetchData(threeAllReformer!) as? [NewCartoonModel]
            callBackDelegate?.callBackSuccess(apiManager)
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(threeViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(threeViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(threeViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
        
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        if manager.isKindOfClass(ThreeViewManager) {
            
        }
        if manager.isKindOfClass(ThreeAllManager) {
            dic["pn"] = page
        }
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        threeManager = ThreeViewManager()
        threeViewRrformer = SerialCartoonViewReformer()
        threeModel = SerialCartoonModel()
        threeManager?.callBackDelegate = self
        threeManager?.paramSource = self
        
        threeAllManager = ThreeAllManager()
        threeAllReformer = SerialAllReformer()
        threeAllModel = [NewCartoonModel]()
        threeAllManager?.callBackDelegate = self
        threeAllManager?.paramSource = self
    }
}
