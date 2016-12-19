//
//  SearchMoiveViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/19.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit
import CSNetManager
import SwiftyJSON

protocol SearchMoiveViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess()
    func callBackFailure()
}

class SearchMoiveViewHelper: NSObject, CSAPIManagerApiCallBackDelegate, CSAPIManagerParamSourceDelegate {
    
    var moiveManager: SearchClassifiyViewManager?
    var moiveReformer: SearchBangumiViewReformer?
    var searchMoiveModel: SearchMoiveModel?
    
    weak var callBackDelegate: SearchMoiveViewCallBackDelegate?
    var moiveViewController: SearchMoiveViewController?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(SearchClassifiyViewManager) {
            searchMoiveModel = apiManager.fetchData(moiveReformer!) as? SearchMoiveModel
            callBackDelegate?.callBackSuccess()
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(moiveViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(moiveViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(moiveViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        dic["pn"] = searchMoiveModel!.page
        dic["keyword"] = searchMoiveModel!.keyword
        dic["type"] = 1
        
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        moiveManager = SearchClassifiyViewManager()
        moiveReformer = SearchBangumiViewReformer()
        searchMoiveModel = SearchMoiveModel()
        moiveManager?.callBackDelegate = self
        moiveManager?.paramSource = self
    }
    
}
