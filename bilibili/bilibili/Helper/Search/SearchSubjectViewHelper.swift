//
//  SearchSubjectViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/19.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit
import CSNetManager
import SwiftyJSON

protocol SearchSubjectViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess()
    func callBackFailure()
}

class SearchSubjectViewHelper: NSObject, CSAPIManagerApiCallBackDelegate, CSAPIManagerParamSourceDelegate {
    
    var subjectManager: SearchClassifiyViewManager?
    var subjectReformer: SearchSubjectViewReformer?
    var searchSubModel: SearchSubModel?
    
    weak var callBackDelegate: SearchSubjectViewCallBackDelegate?
    var subjectViewController: SearchSubjectViewController?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(SearchClassifiyViewManager) {
            searchSubModel = apiManager.fetchData(subjectReformer!) as? SearchSubModel
            callBackDelegate?.callBackSuccess()
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(subjectViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(subjectViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(subjectViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        dic["pn"] = searchSubModel!.page
        dic["keyword"] = searchSubModel!.keyword
        dic["type"] = 4
        
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        subjectManager = SearchClassifiyViewManager()
        subjectReformer = SearchSubjectViewReformer()
        searchSubModel = SearchSubModel()
        subjectManager?.callBackDelegate = self
        subjectManager?.paramSource = self
    }
    
}
