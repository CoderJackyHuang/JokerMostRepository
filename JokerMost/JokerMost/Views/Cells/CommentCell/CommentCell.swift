//
//  CommentCell.swift
//  JokerMost
//
//  Created by ljy-335 on 14-10-14.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import UIKit

///
/// @brief  查看评论表格单元
/// @author huangyibiao
class CommentCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var floorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    var data: NSDictionary!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        var user: AnyObject? = self.data["user"]
        if let userDict = user as? NSDictionary {
            if let nickname = userDict["login"] as? NSString {
                self.nickNameLabel!.text = nickname
            }
            
            // 配置用户头像
            if let userIcon = userDict["icon"] as? NSString {
                var userId = userDict["id"] as NSString
                var prefixUserId = userId.substringToIndex(3)
                var urlString = "http://pic.moumentei.com/system/avtnew/\(prefixUserId)/\(userId)/thumb/\(userIcon)"
                var url = NSURL.URLWithString(urlString)
                self.icon!.sd_setImageWithURL(url, placeholderImage: UIImage(named: "avatar.jpg"))
            } else {
                self.icon!.image = UIImage(named: "avatar.jpg")
            }
        } else {
            self.nickNameLabel!.text = "匿名";
            self.icon!.image = UIImage(named: "avatar.jpg")
        }
        
        // 内容
        if let content = self.data["content"] as? String {
            var height = content.height(17, width: kCellWidth - 20)
            self.contentLabel!.text = content
            self.contentLabel!.height(height)
        }
        
        self.dateLabel!.originY(self.contentLabel!.bottomY())
        if let floor = self.data["floor"] as? String {
            self.floorLabel!.text = "\(floor)楼"
        }
        
        return;
    }
    
    ///
    /// 公开方法
    
    ///
    /// @brief 计算cell的高度
    /// @param data 数据源
    /// @return cell的高度
    class func cellHeight(data: NSDictionary) ->CGFloat {
        var h: CGFloat = 0.0;
        if let content = data["content"] as? String {
            var height = content.height(17, width: kCellWidth - 20)
            
            h = 53.0 + height + 24.0
        }
        return h
    }
}
