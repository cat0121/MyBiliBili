//
//  SynthesisViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol SynthesisViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess(manager: CSAPIBaseManager)
    func callBackFailure()
}

class SynthesisViewHelper: NSObject, CSAPIManagerApiCallBackDelegate,CSAPIManagerParamSourceDelegate {
    var synthesisManager: SynthesisViewManager?
    var synthesisViewRrformer: SerialCartoonViewReformer?
    
    weak var callBackDelegate: SynthesisViewCallBackDelegate?
    var synthesisViewController: SynthesisViewController?
    var synthesisModel: SerialCartoonModel?
    
    //刷新数据
    var synthesisAllManager: SynthesisAllManager?
    var synthesisAllReformer: SerialAllReformer?
    var synthesisAllModel: [NewCartoonModel]?
    
    //定义一个变量
    var page: Int?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(SynthesisViewManager) {
            synthesisModel = apiManager.fetchData(synthesisViewRrformer!) as? SerialCartoonModel
            callBackDelegate?.callBackSuccess(apiManager)
        }
        if apiManager.isKindOfClass(SynthesisAllManager) {
            synthesisAllModel = apiManager.fetchData(synthesisAllReformer!) as? [NewCartoonModel]
            callBackDelegate?.callBackSuccess(apiManager)
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(synthesisViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(synthesisViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(synthesisViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
        
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        if manager.isKindOfClass(SynthesisViewManager) {
            
        }
        if manager.isKindOfClass(SynthesisAllManager) {
            dic["pn"] = page
        }
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        synthesisManager = SynthesisViewManager()
        synthesisViewRrformer = SerialCartoonViewReformer()
        synthesisModel = SerialCartoonModel()
        synthesisManager?.callBackDelegate = self
        synthesisManager?.paramSource = self
        
        synthesisAllManager = SynthesisAllManager()
        synthesisAllReformer = SerialAllReformer()
        synthesisAllModel = [NewCartoonModel]()
        synthesisAllManager?.callBackDelegate = self
        synthesisAllManager?.paramSource = self
    }
}

