//
//  JokerCell.swift
//  JokerMost
//
//  Created by ljy-335 on 14-10-9.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation
import UIKit

///
/// @brief JokerCell对应的点击图片查看的代理声明
/// @author huangyibiao
protocol JokerCellDelegate {
    ///
    /// @brief 点击照片查看时的代理回调方法
    /// @param cell 点击的cell
    /// @param didClickPicture 点击的图片
    func jokerCell(cell: JokerCell, didClickPicture picutre: UIImageView)
}

let kCellWidth = UIScreen.mainScreen().bounds.width

///
/// @brief 最新、热门、评论模块使用的cell
/// @author huangyibiao
class JokerCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var picktureImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dislikeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    var delegate: JokerCellDelegate?
    var data: NSDictionary!
    var largeImageURL: String?
    
    ///
    /// @brief 生命周期函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .None
        var tap = UITapGestureRecognizer(target: self, action: "onTapPicture:")
        self.picktureImageView!.addGestureRecognizer(tap)
    }
    
    override func setValue(value: AnyObject!, forUndefinedKey key: String!) {
        // do nothing
        println(key)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var user: AnyObject? = self.data["user"]
        if let userDict = user as? NSDictionary {
            if let nickname = userDict["login"] as? NSString {
                self.nicknameLabel!.text = nickname
            }
            // 配置用户头像
            if let userIcon = userDict["icon"] as? NSString {
                var userId = userDict["id"] as NSString
                var prefixUserId = userId.substringToIndex(3)
                var urlString = "http://pic.moumentei.com/system/avtnew/\(prefixUserId)/\(userId)/thumb/\(userIcon)"
                var url = NSURL.URLWithString(urlString)
                self.avatarImageView!.sd_setImageWithURL(url, placeholderImage: UIImage(named: "avatar.jpg"))
            } else {
                self.avatarImageView!.image = UIImage(named: "avatar.jpg")
            }
        } else {
            self.nicknameLabel!.text = "匿名";
            self.avatarImageView!.image = UIImage(named: "avatar.jpg")
        }
        
        // 内容
        if let content = self.data["content"] as? String {
            var height = content.height(17, width: kCellWidth - 20)
            self.contentLabel!.text = content
            self.contentLabel!.height(height)
        }
        
        let imageUrlString = data["image"] as? NSString
        if imageUrlString?.length == 0 {
            self.picktureImageView!.hidden = true
            self.bottomView!.originY(self.contentLabel!.bottomY())
        } else {
            var imgId = self.data["id"] as NSString
            var preId = imgId.substringToIndex(4)
            
            // 小图
            var imagURL = "http://pic.moumentei.com/system/pictures/\(preId)/\(imgId)/small/\(imageUrlString)"
            self.avatarImageView!.sd_setImageWithURL(NSURL.URLWithString(imagURL),
                placeholderImage: UIImage(named: "avatar.jpg"))
            
            // 大图，点击放大使用
            self.largeImageURL = "http://pic.moumentei.com/system/pictures/\(preId)/\(imgId)/medium/\(imageUrlString)"
            self.picktureImageView!.sd_setImageWithURL(NSURL.URLWithString(imagURL),
                placeholderImage: UIImage(named: "avatar.jpg"))
        }
        
        
        // 顶、踩
        let votes = self.data["votes"] as? NSDictionary
        if votes == nil {
            self.likeLabel!.text = "顶(0)"
            self.dislikeLabel!.text = "踩(0)"
        } else {
            var like: AnyObject?  = votes?["up"]
            var disLike: AnyObject?  = votes?["down"]
            if let likeVote: AnyObject = like {
                self.likeLabel!.text = "顶(\(likeVote))"
            }
            if let dislikeVote: AnyObject = disLike {
                self.dislikeLabel!.text = "踩(\(dislikeVote))"
            }
        }
        
        // 评论
        var commentCount: AnyObject? = self.data["comments_count"]
        if let count: AnyObject = commentCount {
            self.commentLabel!.text = "评论(\(count))"
        }
    }
    
    ///
    /// 公开方法
    
    ///
    /// @brief 计算cell的高度
    /// @param data 数据源
    /// @return cell的高度
    class func cellHeight(data: NSDictionary) ->CGFloat {
        if let content = data["content"] as? String {
            var height = content.height(17, width: kCellWidth - 20)
            
            if let img = data["image"] as? NSString {
                return 59.0 + height + 40.0
            }
            return 59.0 + height + 5.0 + 112.0 + 40.0
        }
        return 0.0
    }
    
    ///
    /// 私有方法
    
    ///
    /// @brief 点击图片
    private func onTapPicture(sender: UITapGestureRecognizer!) {
        var picture = sender.view as UIImageView
        self.delegate?.jokerCell(self, didClickPicture: picture)
    }
}
