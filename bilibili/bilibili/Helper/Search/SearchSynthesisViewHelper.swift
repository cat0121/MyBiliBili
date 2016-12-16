//
//  SearchSynthesisViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/13.
//  Copyright © 2016年 yan. All rights reserved.
//

import CSNetManager
import SwiftyJSON

protocol SearchSynthesisViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess()
    func callBackFailure()
}

class SearchSynthesisViewHelper: NSObject, CSAPIManagerApiCallBackDelegate, CSAPIManagerParamSourceDelegate {
    
    var synthesisManager: SearchSynthesisViewManager?
    var synthesisReformer: SearchSynthesisViewReformer?
    var synthesisModel: SearchSynthesisModel?
    
    weak var callBackDelegate: SearchSynthesisViewCallBackDelegate?
    var synthesisViewController: SearchSynthesisViewController?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(SearchSynthesisViewManager) {
            synthesisModel = apiManager.fetchData(synthesisReformer!) as? SearchSynthesisModel
            callBackDelegate?.callBackSuccess()
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
        if manager.isKindOfClass(SearchSynthesisViewManager) {
            dic["pn"] = synthesisModel!.page
            dic["keyword"] = synthesisModel!.keyword
        }
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        synthesisManager = SearchSynthesisViewManager()
        synthesisReformer = SearchSynthesisViewReformer()
        synthesisModel = SearchSynthesisModel()
        synthesisManager?.callBackDelegate = self
        synthesisManager?.paramSource = self
    }
    
}
