//
//  CartoonRecommendViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

import SwiftyJSON
import CSNetManager

protocol CartoonRecommendCallBackDelegate: NSObjectProtocol {
    func callBackSuccess()
    func callBackFailure()
}
class CartoonRecommendViewHelper: NSObject, CSAPIManagerApiCallBackDelegate, CSAPIManagerParamSourceDelegate{
    
    var cartoonRecManager: CartoonRecommendManager?
    var cartoonRecReformer: CartoonRecommendReformer?
    weak var callBackDelegate: CartoonRecommendCallBackDelegate?
    
    var cartoonModel: CartoonRecommendModel?
    var cartoonRecViewController: CartoonRecommendViewController?
    
    //MARK: -- life cycle 
    override init() {
        super.init()
        
        initManager()
    }
    
    //MARK: -- delegate
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(CartoonRecommendManager) {
            cartoonModel = apiManager.fetchData(cartoonRecReformer!) as? CartoonRecommendModel
            callBackDelegate?.callBackSuccess()
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(cartoonRecViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(cartoonRecViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(cartoonRecViewController!, title: "提示", message: "请求失败，请稍后重试")
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
        cartoonRecManager = CartoonRecommendManager()
        cartoonRecReformer = CartoonRecommendReformer()
        cartoonModel = CartoonRecommendModel()
        cartoonRecManager?.callBackDelegate = self
        cartoonRecManager?.paramSource = self
    }
}
