//
//  SearchResultViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/7.
//  Copyright © 2016年 yan. All rights reserved.
//

import CSNetManager
import SwiftyJSON

protocol SearchResultViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess(manager: CSAPIBaseManager)
    func callBackFailure()
}

class SearchResultViewHelper: NSObject, CSAPIManagerApiCallBackDelegate, CSAPIManagerParamSourceDelegate {
    
    var fuzzyManager: FuzzySearchManager?
    var fuzzyReformer: FuzzySearchReformer?
    var fuzzyModel: FuzzySearchModel?
    
    weak var callBackDelegate: SearchResultViewCallBackDelegate?
    var resultViewController: SearchResultViewController?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(FuzzySearchManager) {
            fuzzyModel = apiManager.fetchData(fuzzyReformer!) as? FuzzySearchModel
            callBackDelegate?.callBackSuccess(apiManager)
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(resultViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(resultViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(resultViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        dic["term"] = fuzzyModel!.keyword
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        fuzzyManager = FuzzySearchManager()
        fuzzyReformer = FuzzySearchReformer()
        fuzzyModel = FuzzySearchModel()
        fuzzyManager?.callBackDelegate = self
        fuzzyManager?.paramSource = self
    }

}