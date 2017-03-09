//
//  PersonalInfoViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/30.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class PersonalInfoViewController: UIViewController {

    var mineData: MineViewModel?
    var mineSource: [String]?
    let TagArr = [["我的直播"],["头像","昵称","UID","性别","出生年月","个性签名"],["空间隐私设置","账号安全中心"]]
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initBaseLayout()
        layoutPageSubview()
        loadData()
    }
    
    //MARK: -- event response
    func backClick(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(false)
    }

    //MARK: -- private method
    func initBaseLayout() {
        self.title = "个人资料"
        self.navigationItem.leftBarButtonItem = leftBackBtn
        self.navigationController?.navigationBar.hidden = false
        self.view.addSubview(personTableView)
    }
    func layoutPageSubview() {
        personTableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    func loadData() {
        let face = mineData!.face!
        let name = mineData!.uname!
        let mid = String.init(format: "%d", mineData!.mid!)
        var sex: String!
        if mineData!.sex == 1 {
            sex = "男"
        }
        if mineData!.sex == 2 {
            sex = "女"
        }
        let birthday = mineData!.birthday!
        let sign = mineData!.sign!
        mineSource = [face,name,mid,sex,birthday,sign]
    }
    
    //MARK: -- setter and getter
    var _leftBackBtn:UIBarButtonItem!
    var leftBackBtn:UIBarButtonItem{
        if _leftBackBtn == nil{
            _leftBackBtn = UIBarButtonItem(image: UIImage(named: "fullplayer_icon_back"), style: .Plain, target: self, action: #selector(PersonalInfoViewController.backClick(_:)))
            _leftBackBtn.tintColor = UIColor.whiteColor()
            
        }
        return _leftBackBtn
    }
    var _personTableView: UITableView!
    var personTableView: UITableView {
        if _personTableView == nil {
            _personTableView = UITableView(frame: CGRectZero, style: .Plain)
            _personTableView.backgroundColor = YYBackgroundColor
            
            _personTableView.delegate = self
            _personTableView.dataSource = self
            
            _personTableView.registerClass(PersonImgCell.self, forCellReuseIdentifier: "image")
            _personTableView.registerClass(PersonViewCell.self, forCellReuseIdentifier: "label")
            _personTableView.registerClass(LoginOutCell.self, forCellReuseIdentifier: "loginout")
        }
        return _personTableView
    }
    
}

extension PersonalInfoViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 6
        case 2:
            return 2
        case 3:
            return 1
        default:
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 1 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("image") as! PersonImgCell
            cell.tagLab.text = TagArr[indexPath.section][indexPath.row]
            cell.userIcon.sd_setImageWithURL(NSURL(string: mineSource![0]))
            cell.accessoryType = .DisclosureIndicator
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCellWithIdentifier("loginout") as! LoginOutCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("label") as! PersonViewCell
            cell.tagLab.text = TagArr[indexPath.section][indexPath.row]
            if indexPath.section == 1 {
                cell.userLab.text = mineSource![indexPath.row]
            }
            if indexPath.section == 1 && indexPath.row == 2 {
                cell.accessoryType = .None
            }else {
                cell.accessoryType = .DisclosureIndicator
            }
            return cell
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 0 {
            return 88
        }
        return 44
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = YYBackgroundColor
        
        return view
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
}