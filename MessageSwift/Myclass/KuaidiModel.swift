//
//  KuaidiModel.swift
//  MessageSwift
//
//  Created by 曹云霄 on 16/3/21.
//  Copyright © 2016年 caoyunxiao. All rights reserved.
//

import Foundation

class KuaidiModel: NSObject {

     var datetime: String?//时间
    var remarkHeight: CGFloat?//文本高度
    var remark: String?{//文本内容
        
        didSet{
            print(CalculateStringWidth(remark!))
            remarkHeight = CalculateStringWidth(remark!)
        }
        
    }//对应的快递信息
    
    //笑话内容
    var content: String?{
        
        didSet{
             remarkHeight = CalculateStringWidth(content!)//计算出的笑话占位高度
        }
    }
    
    
    //MARK: -计算字符串高度
    func CalculateStringWidth(remarkString: NSString) ->CGFloat{
        
        let size = CGSizeMake(ScreenWidth-10, 99999)
        let s = remarkString.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes:[NSFontAttributeName:UIFont.systemFontOfSize(13)], context: nil).size
        return s.height
        
    }
}
