//
//  MJRefreshCustomFooter.swift
//  MessageSwift
//
//  Created by 曹云霄 on 16/3/23.
//  Copyright © 2016年 caoyunxiao. All rights reserved.
//

import UIKit

class MJRefreshCustomFooter: MJRefreshBackGifFooter {

    override func prepare() {
        super.prepare()
        
        let imageArray = NSMutableArray()
        for index in 1...60{
            let image = UIImage(named:NSString(format: "dropdown_anim__000%zd", index) as String)
            imageArray.addObject(image!)
        }
        self.setImages(imageArray as [AnyObject], forState: MJRefreshState.Idle)
        
        
        
        let refreshingImages = NSMutableArray()
        for page in 1...3{
            
            let image = UIImage(named:NSString(format: "dropdown_loading_0%zd", page) as String)
            refreshingImages.addObject(image!)
        }
        self.setImages(refreshingImages as [AnyObject], forState: MJRefreshState.Pulling)
        self.setImages(refreshingImages as [AnyObject], forState: MJRefreshState.Refreshing)
        
    }
}
