//
//  CarIDViewController.swift
//  MessageSwift
//
//  Created by 曹云霄 on 16/3/14.
//  Copyright © 2016年 caoyunxiao. All rights reserved.
//

import UIKit
import Alamofire

class CarIDViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {

    
    private var CardTableview: UITableView?
    private var CardArray: NSMutableArray?//身份证信息
    private var inputString: String = ""//保存输入信息
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIConfigAction()
   }
    
    //MARK: -网络请求
    private func NetWorkRequest(){
        
        SVProgressHUD.showWithStatus("查询中")
        let dict = ["cardno":self.inputString,"dtype":"json","key":CarIDKEY]
        //data表示返回的二进制数据
        Alamofire.request(.GET, CarIDurl,parameters: dict).response { (request, response, data, error) -> Void in
            
            //把JSON转成字典
            let json : AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments)
            let error_code = json.objectForKey("error_code") as? Int
            if error_code == 0{//表示请求成功
                SVProgressHUD.dismiss()
                let result: NSDictionary! = json.objectForKey("result") as? NSDictionary
                print(result)
                self.CardArray!.addObject(result.objectForKey("area")!)
                self.CardArray!.addObject(result.objectForKey("birthday")!)
                self.CardArray!.addObject(result.objectForKey("sex")!)
                print(self.CardArray)
                self.CardTableview!.reloadData()
            }else
            {
                SVProgressHUD.showErrorWithStatus("查询失败")
            }
        }
    }

    //MARK:-UI
    private func UIConfigAction(){
        
        //MARK:-初始化数组
        self.CardArray = NSMutableArray()
        self.CardTableview = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight-64), style: .Plain)
        self.CardTableview!.delegate = self
        self.CardTableview!.dataSource = self
        self.CardTableview!.tableFooterView = UIView()
        self.CardTableview!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cardcell")
        self.view.addSubview(self.CardTableview!)
        
        //HeaderView
        let HeaderView = UIView(frame:CGRectMake(0, 0, ScreenWidth, 200))
        AddTextfieldAndButton(HeaderView)
        self.CardTableview?.tableHeaderView = HeaderView
        
    }
    
    //MARK: -Header
    private func AddTextfieldAndButton(HeaderView: UIView){
        
        let TextField = UITextField()
        TextField.placeholder = "请输入身份证号码"
        HeaderView .addSubview(TextField)
        TextField.textAlignment = NSTextAlignment.Center
        TextField.borderStyle = UITextBorderStyle.RoundedRect
        TextField.addTarget(self, action: #selector(CarIDViewController.ChangString(_:)), forControlEvents: UIControlEvents.EditingChanged)
        TextField.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(25)
            make.top.equalTo(80)
            make.right.equalTo(-25)
            make.height.equalTo(40)
        }
        
        let determineButton = UIButton()
        determineButton.setTitle("确定", forState: UIControlState.Normal)
        determineButton.backgroundColor = UIColor.redColor()
        determineButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        determineButton.layer.masksToBounds = true
        determineButton.layer.cornerRadius = 5
        determineButton.addTarget(self, action: #selector(CarIDViewController.SearchButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        HeaderView.addSubview(determineButton)
        determineButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo((ScreenWidth-100)/2)
            make.right.equalTo(-(ScreenWidth-100)/2)
            make.top.equalTo(150)
        }
    }
    
    
    func ChangString(inputstring: UITextField){
        
        self.inputString = inputstring.text!
    }
    
    //MARK: -ButotnAction
    func SearchButtonClick(sender: UIButton){
        
        print("点击")
        if self.inputString.characters.count == 0{
            
            SVProgressHUD.showErrorWithStatus("输入为空")
            return
        }
        self.CardArray!.removeAllObjects()
        NetWorkRequest()
    }
    
    //MARK: -UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cardcell", forIndexPath: indexPath) as UITableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        if indexPath.row == 0{
         
            cell.textLabel?.text = "户籍: \(self.CardArray!.objectAtIndex(indexPath.row))"
            
        }else if indexPath.row == 1{
         
            cell.textLabel?.text = "出生日期: \(self.CardArray!.objectAtIndex(indexPath.row))"
            
        }else if indexPath.row == 2{
            
            cell.textLabel?.text = "性别: \(self.CardArray!.objectAtIndex(indexPath.row))"
        }
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.CardArray!.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
    }
    
    
}



































