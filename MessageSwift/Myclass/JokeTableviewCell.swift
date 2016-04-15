//
//  JokeTableviewCell.swift
//  MessageSwift
//
//  Created by 曹云霄 on 16/3/23.
//  Copyright © 2016年 caoyunxiao. All rights reserved.
//

import UIKit

class JokeTableviewCell: UITableViewCell {

    
    private var TextLabe : UILabel?
    var model =  KuaidiModel()//数据源model
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        TextLabe = UILabel()
        TextLabe!.font = UIFont.systemFontOfSize(13)
        TextLabe!.numberOfLines = 0
        contentView.addSubview(TextLabe!)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        TextLabe!.text = model.content
        TextLabe!.snp_makeConstraints(closure: { (make) -> Void in
            
            make.edges.equalTo(UIEdgeInsetsMake(5, 5, -5, -5))
        })
        
    }
}
