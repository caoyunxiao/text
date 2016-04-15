//
//  LoginViewController.swift
//  MessageSwift
//
//  Created by 曹云霄 on 16/3/14.
//  Copyright © 2016年 caoyunxiao. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController,SelectedIndexDelegate {

    @IBOutlet weak var QQloginButton: UIButton!//QQ登录
    @IBOutlet weak var SinaLoginButton: UIButton!//新浪微博登录
    private let VCObjectArray = NSMutableArray()//控制器对象数组
    private var DrawerController: MMDrawerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        UIConfigAction()
        LoginSuccess()
    }
    
    
    //MARK: -UI
    private func UIConfigAction(){
        
        for index in 0...7{
            self.VCObjectArray.addObject(index)
        }
    }
    
    
    
    //登录成功
    private func LoginSuccess(){
        
        let LeftVC = LeftViewController()
        LeftVC.delegateVC = self
        //判断当前控制器对象是否已经存在
        let ControllerVC = self.VCObjectArray.firstObject
        if ControllerVC!.isEqual(0){
            
            self.VCObjectArray.replaceObjectAtIndex(0, withObject: ReturnControllerObject(0))
        }
        let Nav = UINavigationController(rootViewController: self.VCObjectArray.objectAtIndex(0) as! UIViewController)
        Nav.navigationBar.translucent = false;
        self.DrawerController = MMDrawerController(centerViewController: Nav, leftDrawerViewController: LeftVC)
        self.DrawerController!.maximumLeftDrawerWidth = LeftVCWidth
        self.DrawerController!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.All
        self.DrawerController!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.All
        NSNotificationCenter.defaultCenter().postNotificationName("RootViewController", object: self.DrawerController!, userInfo: nil)
        
    }
    
    //MARK: -代理
    func SelectedVcindex(index: NSInteger) {
        
        print(index)
        let ControllerVC = self.VCObjectArray.objectAtIndex(index)
        if ControllerVC.isEqual(index){
            
            self.VCObjectArray.replaceObjectAtIndex(index, withObject: ReturnControllerObject(index))
        }
        let Nav = UINavigationController(rootViewController: self.VCObjectArray.objectAtIndex(index) as! UIViewController)
        Nav.navigationBar.translucent = false
        self.DrawerController!.centerViewController = Nav
        self.DrawerController!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    
    private func ReturnControllerObject(drawerindex: NSInteger) ->UIViewController{
        
        let TitleArray: NSMutableArray = ["身份证号码查询","快递单号查询","手机号码归属地查询","笑话大全","有道翻译","智能机器人","健康","精选视频"]
        let VcArray: NSMutableArray = [
                    "CarIDViewController"
                    ,"KuaidiViewController"
                    ,"PhoneNumberViewController"
                    ,"JokeViewController"
                    ,"TranslationViewController"
                    ,"RobotViewController"
                    ,"HealthViewController"
                    ,"VideoViewController"]
        
        let VCstring = VcArray.objectAtIndex(drawerindex) as! String
        let nameSpace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        let controller:AnyClass = NSClassFromString(nameSpace + "." + VCstring)!
        let vc = (controller as! UIViewController.Type).init()
        vc.title = TitleArray.objectAtIndex(drawerindex) as? String
        return vc
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //QQ登录和新浪微博登录
    @IBAction func QQloginAndSinalogin(sender: UIButton) {
        
        
    }

}
