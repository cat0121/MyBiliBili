//
//  PlayMusicViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/24.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol PlayMusicViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess(manager: CSAPIBaseManager)
    func callBackFailure()
}

class PlayMusicViewHelper: NSObject, CSAPIManagerApiCallBackDelegate,CSAPIManagerParamSourceDelegate {
    var playManager: PlayMusicViewManager?
    var playViewRrformer: SerialCartoonViewReformer?
    
    weak var callBackDelegate: PlayMusicViewCallBackDelegate?
    var playViewController: PlayMusicViewController?
    var playModel: SerialCartoonModel?
    
    //刷新数据
    var playAllManager: PlayMusicAllManager?
    var playAllReformer: SerialAllReformer?
    var playAllModel: [NewCartoonModel]?
    
    //定义一个变量
    var page: Int?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(PlayMusicViewManager) {
            playModel = apiManager.fetchData(playViewRrformer!) as? SerialCartoonModel
            callBackDelegate?.callBackSuccess(apiManager)
        }
        if apiManager.isKindOfClass(PlayMusicAllManager) {
            playAllModel = apiManager.fetchData(playAllReformer!) as? [NewCartoonModel]
            callBackDelegate?.callBackSuccess(apiManager)
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(playViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(playViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(playViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
        
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        if manager.isKindOfClass(PlayMusicViewManager) {
            
        }
        if manager.isKindOfClass(PlayMusicAllManager) {
            dic["pn"] = page
        }
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        playManager = PlayMusicViewManager()
        playViewRrformer = SerialCartoonViewReformer()
        playModel = SerialCartoonModel()
        playManager?.callBackDelegate = self
        playManager?.paramSource = self
        
        playAllManager = PlayMusicAllManager()
        playAllReformer = SerialAllReformer()
        playAllModel = [NewCartoonModel]()
        playAllManager?.callBackDelegate = self
        playAllManager?.paramSource = self
    }
}
