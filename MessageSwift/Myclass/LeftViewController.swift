//
//  LeftViewController.swift
//  MessageSwift
//
//  Created by 曹云霄 on 16/3/14.
//  Copyright © 2016年 caoyunxiao. All rights reserved.
//

import UIKit




//MARK: -选择控制器代理
protocol SelectedIndexDelegate{
    //方法
    func SelectedVcindex(index: NSInteger)
}

class LeftViewController: BaseViewController {

    private var LeftTableview : UITableView?
    private var VcTitleArray : NSArray?//控制器title数组
    private var ImageArray : NSArray?//控制器图标数组
    var delegateVC: SelectedIndexDelegate?//声明代理
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIConfigAction()
    }
    
    private func UIConfigAction(){
        
        
        self.VcTitleArray = ["身份证号码查询","快递单号查询","手机号码归属地查询","笑话大全","有道翻译","智能机器人","健康","视频"]
        self.ImageArray = ["iconfont-shenfenzheng","iconfont-kuaidi","iconfont-shouji","iconfont-xiaohua","iconfont-fanyi","iconfont-jiqiren","iconfont-yundong","iconfont-shipin"]
        self.LeftTableview = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight), style: .Plain)
        self.LeftTableview!.dataSource = self;
        self.LeftTableview!.delegate = self;
        self.LeftTableview!.tableFooterView = UIView()
        self.LeftTableview!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //MARK: -背景图片
        let BackimageView = UIImageView(frame: CGRectMake(0, 0, LeftVCWidth, self.view.frame.size.height))
        BackimageView.image = UIImage(named: "IMG_1144")
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .Dark)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = BackimageView.bounds
        BackimageView.addSubview(effectView)
        self.LeftTableview!.backgroundView = BackimageView
        self.view.addSubview(self.LeftTableview!)
        AddHeaderView()
    }
    
    
    // MARK: -头部视图
    private func AddHeaderView(){
        
        let HeaderView = UIView(frame: CGRectMake(0, 0, LeftVCWidth, 200))
        let imageView = UIImageView(frame: CGRectMake(0, 0, 100, 100))
    
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.grayColor().CGColor
        imageView.image = UIImage(named: "IMG_1144")
        imageView.center = CGPointMake(LeftVCWidth/2, HeaderView.frame.size.height/2)
        HeaderView.addSubview(imageView)
        let Titlelabe = UILabel(frame: CGRectMake(0, 0, LeftVCWidth, 50))
        Titlelabe.center = CGPointMake(LeftVCWidth/2, imageView.frame.size.height+70)
        Titlelabe.text = "caoyunxiao"
        Titlelabe.textAlignment = NSTextAlignment.Center
        Titlelabe.textColor = UIColor.whiteColor()
        HeaderView.addSubview(Titlelabe)
        self.LeftTableview!.tableHeaderView = HeaderView;
    }
    
}

//MARK: -扩展
extension LeftViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    //MARK: -ACtion
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.text = self.VcTitleArray!.objectAtIndex(indexPath.row) as? String
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.imageView?.image = UIImage(named: (self.ImageArray!.objectAtIndex(indexPath.row) as? String)!)
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.VcTitleArray!.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.LeftTableview?.deselectRowAtIndexPath(indexPath, animated: true)
        //代理方法
        self.delegateVC?.SelectedVcindex(indexPath.row)
    }

}





