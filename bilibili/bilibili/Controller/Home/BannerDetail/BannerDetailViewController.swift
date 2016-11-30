//
//  BannerDetailViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/29.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class BannerDetailViewController: UIViewController {
    
    var url: String?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubviews()
    }
    
    //MARK: - response event
    func back(btn:UIButton){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.leftBarButtonItem = leftBackBtn
        self.tabBarController?.tabBar.hidden = true
        self.view.addSubview(detailWebView)
        
    }
    func layoutPageSubviews() {
        detailWebView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(64)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(SCREEN_HEIGHT-64)
        }
    }
    
    //MARK: -- setter and getter
    var _detailWebView: UIWebView!
    var detailWebView: UIWebView {
        if _detailWebView == nil {
            _detailWebView = UIWebView()
            _detailWebView.backgroundColor = UIColor.clearColor()
            _detailWebView.dataDetectorTypes = .None
            _detailWebView.scalesPageToFit = false
            _detailWebView.opaque = false
            
            let URL = NSURL(string: self.url!)
            let request = NSURLRequest(URL: URL!)
            _detailWebView.loadRequest(request)
            
            //代理
            _detailWebView.delegate = self
        }
        return _detailWebView
    }
    var _leftBackBtn:UIBarButtonItem!
    var leftBackBtn:UIBarButtonItem{
        if _leftBackBtn == nil{
            _leftBackBtn = UIBarButtonItem(image: UIImage(named: "fullplayer_icon_back"), style: .Plain, target: self, action: #selector(BannerDetailViewController.back(_:)))
            _leftBackBtn.tintColor = UIColor.whiteColor()
            
        }
        return _leftBackBtn
    }
}

extension BannerDetailViewController: UIWebViewDelegate {
    func webViewDidStartLoad(webView: UIWebView) {
        
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        
        let actualSize = webView.sizeThatFits(CGSizeZero)
        var newFrame = webView.frame
        newFrame.size.height = actualSize.height
        webView.frame = newFrame
        
        let newSize = CGSize(width: SCREEN_WIDTH, height: webView.frame.size.height+365)
        webView.scrollView.contentSize = newSize
    }
}