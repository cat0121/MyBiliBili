//
//  BangumiRecViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

import SwiftyJSON
import CSNetManager

protocol BangumiRecommendCallBackDelegate: NSObjectProtocol {
    func callBackSuccess()
    func callBackFailure()
}
class BangumiRecViewHelper: NSObject, CSAPIManagerApiCallBackDelegate, CSAPIManagerParamSourceDelegate{
    
    var bangumiRecManager: BangumiRecViewManager?
    var bangumiRecReformer: CartoonRecommendReformer?
    weak var callBackDelegate: BangumiRecommendCallBackDelegate?
    
    var bangumiModel: CartoonRecommendModel?
    var bangumiRecViewController: BangumiRecommendViewController?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    //MARK: -- delegate
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(BangumiRecViewManager) {
            bangumiModel = apiManager.fetchData(bangumiRecReformer!) as? CartoonRecommendModel
            callBackDelegate?.callBackSuccess()
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(bangumiRecViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(bangumiRecViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(bangumiRecViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        let dic  = [String: AnyObject]()
        
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        bangumiRecManager = BangumiRecViewManager()
        bangumiRecReformer = CartoonRecommendReformer()
        bangumiModel = CartoonRecommendModel()
        bangumiRecManager?.callBackDelegate = self
        bangumiRecManager?.paramSource = self
    }
}

