//
//  JokeViewController.swift
//  MessageSwift
//
//  Created by 曹云霄 on 16/3/15.
//  Copyright © 2016年 caoyunxiao. All rights reserved.
//

import UIKit
import Alamofire

class JokeViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {

    private var JokeTableview: UITableView?
    private var DatasArray: NSMutableArray?//数据源
    private var page = 1//当前页数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIConfigAction()
        GetdatasAction(false)
        
    }
    
    //MARK: -UI
    private func UIConfigAction(){
        
        DatasArray = NSMutableArray()//数据源
        JokeTableview = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight-64), style: .Plain)
        JokeTableview!.dataSource = self
        JokeTableview!.delegate = self
        JokeTableview!.tableFooterView = UIView()
        self.view.addSubview(JokeTableview!)
        JokeTableview!.backgroundColor = UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1)
        JokeTableview!.registerClass(JokeTableviewCell.self, forCellReuseIdentifier: "JokeCellString")
        
        //MARK: -刷新
        let footer = MJRefreshCustomFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(JokeViewController.footerRefresh))
        JokeTableview!.mj_footer = footer
        
        let header = MJRefreshCustomHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(JokeViewController.headerRefresh))
        header.lastUpdatedTimeLabel?.hidden = true
        header.stateLabel?.hidden = true
        JokeTableview!.mj_header = header
    }
    
    //MARK: -加载更多
    func footerRefresh(){
        
        page += 1
        GetdatasAction(false)
    }
    
    //MARK: -刷新
    func headerRefresh(){
        
        GetdatasAction(true)
    }

    //MARK; -获取数据
    private func GetdatasAction(isDelete: Bool){
        
        SVProgressHUD.showWithStatus("加载中")
        let dict = ["sort":"desc","page":page,"pagesize":"20","time":GetTimeStamp(),"key":JokeKEY]
        Alamofire.request(.GET, JokeUrl,parameters:dict).response { (RequestNew, ResponseNew, data, error) -> Void in
            
            self.JokeTableview!.mj_header .endRefreshing()
            self.JokeTableview!.mj_footer.endRefreshing()
            let json: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            let dataDict = json.objectForKey("error_code") as! Int
            if dataDict == 0{
                //mark：-刷新的时候且请求数据成功时调用清空
                if isDelete{
                    self.DatasArray!.removeAllObjects()
                }
                SVProgressHUD.dismiss()
                let result = json!.objectForKey("result")
                let dataNew = result!.objectForKey("data") as! NSArray;
                for Subdict in dataNew{
                    let model = KuaidiModel()
                    let dict = Subdict as? NSDictionary
                    model.content = dict!.objectForKey("content") as? String
                    self.DatasArray!.addObject(model)
                }
                self.JokeTableview!.reloadData()
            }else
            {
                SVProgressHUD.showErrorWithStatus("网络错误")
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.DatasArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("JokeCellString", forIndexPath: indexPath) as! JokeTableviewCell
        cell.model = self.DatasArray!.objectAtIndex(indexPath.row) as! KuaidiModel
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let model = self.DatasArray!.objectAtIndex(indexPath.row) as! KuaidiModel
        return model.remarkHeight!+30
    }
    

    
    
    //MARK: -获取时间戳
    func GetTimeStamp() -> NSString{
        
        let date = NSDate(timeIntervalSinceNow: 0)
        let a = date.timeIntervalSince1970
        let timeString = NSString(format: "%.0f", a)
        return timeString
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
