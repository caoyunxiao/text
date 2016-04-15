//
//  KuaidiCustomcell.swift
//  MessageSwift
//
//  Created by 曹云霄 on 16/3/17.
//  Copyright © 2016年 caoyunxiao. All rights reserved.
//

import UIKit

class KuaidiCustomcell: UITableViewCell {

    
    private var TextLabe = UILabel()//文本
    private var TimeLabe = UILabel()//时间
    var Model = KuaidiModel()//数据源
    
    
    //MARK: -初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.TextLabe.font = UIFont.systemFontOfSize(13)
        self.TextLabe.numberOfLines = 0
        self.TimeLabe.font = UIFont.systemFontOfSize(13)
        contentView.addSubview(TextLabe)
        contentView.addSubview(TimeLabe)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: -布局
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.TextLabe.text = Model.remark
        self.TimeLabe.text = Model.datetime
        self.TextLabe.snp_makeConstraints { (make) -> Void in
            
            make.edges.equalTo(UIEdgeInsetsMake(5, 5, -30, -5))
        }
        self.TimeLabe.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.bottom.equalTo(-5)
            make.top.equalTo(self.TextLabe.snp_bottom).offset(5)
            
        }
    }
}
