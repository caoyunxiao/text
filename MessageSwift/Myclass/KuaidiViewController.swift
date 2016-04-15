//
//  KuaidiViewController.swift
//  MessageSwift
//
//  Created by 曹云霄 on 16/3/14.
//  Copyright © 2016年 caoyunxiao. All rights reserved.
//

import UIKit
import Alamofire


class KuaidiViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    
    private var CourierTableview: UITableView?
    private var KuaidiArray = NSMutableArray()//保存快递公司编号
    private var KuaidiDataArray = NSMutableArray();//保存查询的快递单号信息
    private var InputString: String? //保存输入快递标号
    private var SelectedButton: String?//保存选中快递公司代号
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIConfigAction()
        NetWorkRequest()
    }
    
    private func UIConfigAction(){
        
        self.CourierTableview = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight-64), style: .Plain)
        self.CourierTableview!.dataSource = self
        self.CourierTableview!.delegate = self
        self.view.addSubview(self.CourierTableview!)
        self.CourierTableview!.tableFooterView = UIView()
        self.CourierTableview!.registerClass(KuaidiCustomcell.self, forCellReuseIdentifier: "Customcell")
        
        //MARK -HeaderView
        let HeaderView = UIView(frame: CGRectMake(0, 0, ScreenWidth, 300))
        HeaderView.tag = 100
        let Textfield = UITextField()
        Textfield.placeholder = "请输入快递单号"
        Textfield.textAlignment = NSTextAlignment.Center
        Textfield.addTarget(self, action: #selector(KuaidiViewController.TextChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        HeaderView.addSubview(Textfield)
        Textfield.borderStyle = UITextBorderStyle.RoundedRect
        Textfield.snp_makeConstraints { (make) -> Void in
            
            make.height.equalTo(40)
            make.left.equalTo(25)
            make.right.equalTo(-25)
            make.bottom.equalTo(-70)
        }
        
        //MARK: -确定按钮
        let SureButton = UIButton()
        SureButton.setTitle("查询", forState: UIControlState.Normal)
        SureButton.layer.masksToBounds = true
        SureButton.layer.cornerRadius = 5
        SureButton.backgroundColor = UIColor.redColor()
        SureButton.addTarget(self, action: #selector(KuaidiViewController.QueryButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        HeaderView.addSubview(SureButton)
        SureButton.snp_makeConstraints { (make) -> Void in
            
            make.size.equalTo(CGSizeMake(100, 35))
            make.centerY.equalTo(Textfield.snp_bottom).offset(40)
            make.centerX.equalTo(Textfield.snp_centerX)
        }
        self.CourierTableview?.tableHeaderView = HeaderView
    }
    
    func TextChange(textfiled: UITextField){
        
        InputString = textfiled.text!
    }
    
    //MARK: -查询
    func QueryButtonClick(){
        
        //判断是否为空
        if self.InputString == nil {
            
            SVProgressHUD.showErrorWithStatus("输入为空")
            return;
        }
        QueryCourierNumber()
    }
    
    //MARK: -快递公司编号网络请求
    private func NetWorkRequest(){
        
        
        let dict = ["key":KuaidiKEY]
        JHAPISDK.shareJHAPISDK().executeWorkWithAPI(Kuaidiurl, APIID: "43", parameters: dict, method: "POST", success: {responseObject in
            
           
            let error_code = responseObject.objectForKey("error_code") as? Int
            if error_code == 0{//请求成功
                let result = responseObject.objectForKey("result") as? NSArray
                if result!.count != 0{
                    for Subdict in result!{
                        self.KuaidiArray.addObject(Subdict)
                    }
                    self.DecorateButton(self.KuaidiArray)
                }
            }else
            {
                SVProgressHUD.showErrorWithStatus("网络错误")
            }
        }, failure: {error in
       
              SVProgressHUD.showErrorWithStatus("网络错误")
    })
        
    }
    
    //MARK: -布置快递公司按钮
    private func DecorateButton(datas: NSMutableArray){
        
        let HeaderView = self.view.viewWithTag(100)
        let Button_width = (ScreenWidth-60)/5
        for index in 0...datas.count-1{
            
            let indexNew = index%5
            let page = index/5
            let button = UIButton()
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 5
            button.tag = 200+index
            button.setBackgroundImage(UIImage(named: "w"), forState: UIControlState.Normal)
            button.setBackgroundImage(UIImage(named: "m"), forState: UIControlState.Selected)
            button.frame = CGRectMake(CGFloat(indexNew)*(Button_width+10)+10, CGFloat(page)*40+50, Button_width, 30)
            button.setTitle(datas.objectAtIndex(index).objectForKey("com") as? String, forState: UIControlState.Normal)
            button.addTarget(self, action: #selector(KuaidiViewController.ButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            HeaderView!.addSubview(button)
        }
    }
    //MARK: -快递公司选中
    func ButtonClick(btn: UIButton){
        
        let headerView = self.view.viewWithTag(100)
        for SubView in headerView!.subviews{
            
            if SubView.isKindOfClass(UIButton.self){
                let button = SubView  as? UIButton
                button?.selected = false
            }
        }
        let indexPage = btn.tag-200 
        let dict = self.KuaidiArray.objectAtIndex(indexPage) as! NSDictionary
        SelectedButton = dict.objectForKey("no") as? String
        btn.selected = true
    }
    
    //MARK; -查询快递公司编号
    private func QueryCourierNumber(){
        
        SVProgressHUD.showWithStatus("加载中")
        let dict: Dictionary = ["no":InputString!,"com":SelectedButton!,"key":KuaidiKEY,"dtype":"json"]
        JHAPISDK.shareJHAPISDK().executeWorkWithAPI(QueryURL, APIID: "43", parameters:dict , method: "POST", success: {responseObject in
            
             SVProgressHUD.dismiss()
            let error_code = responseObject.objectForKey("error_code") as? Int
            if error_code == 0{//请求成功
                self.KuaidiDataArray.removeAllObjects()
                let result = responseObject.objectForKey("result") as? NSDictionary
                let list = result!.objectForKey("list") as? NSArray
                if list!.count != 0{
                    for Subdict in list!{
                        let Model = KuaidiModel()
                        let dict = Subdict as? NSDictionary
                        Model.datetime = dict!.objectForKey("datetime") as? String
                        Model.remark = dict!.objectForKey("remark") as? String
                        self.KuaidiDataArray.addObject(Model)
                    }
                    self.CourierTableview!.reloadData()
                }
            }
            
            }, failure: {error in
                
            print(error)
        })
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.KuaidiDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Customcell", forIndexPath: indexPath) as! KuaidiCustomcell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.Model = self.KuaidiDataArray.objectAtIndex(indexPath.row) as! KuaidiModel
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        //MARK: -自动适配字符串高度
        let model = self.KuaidiDataArray.objectAtIndex(indexPath.row) as! KuaidiModel
        return model.remarkHeight!+50
    }
    
}
