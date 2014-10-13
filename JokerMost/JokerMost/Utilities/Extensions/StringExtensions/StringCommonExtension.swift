//
//  StringCommonExtension.swift
//  JokerMost
//
//  Created by ljy-335 on 14-10-9.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation
import UIKit

///
/// @brief String的通用扩展方法
/// @date  2014-10-09
/// @author huangyibiao
///
extension String {
    ///
    /// @brief 获取字符串的高度
    /// @param fontSize 字体大小
    /// @param width 限制一行显示的宽度
    /// @return 返回文本在width宽度的条件下的总高度
    ///
    func height(let fontSize: CGFloat, let width: CGFloat) ->CGFloat {
        let font = UIFont.systemFontOfSize(fontSize)
        let size = CGSizeMake(width, CGFloat.max)
        
        var style = NSMutableParagraphStyle()
        style.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        var attributes = [NSFontAttributeName: font, NSParagraphStyleAttributeName: style.copy()];
        
        // 强转成NSString
        var text = self as NSString
        var rect = text.boundingRectWithSize(size,
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: attributes,
            context: nil)
        
        return rect.size.height
    }
    
    ///
    /// @brief 把时间戳转换成“2014年12月12日 8:20:20”格式的日期字符串
    /// @param timeStamp 时间戳
    /// @return “2014年12月12日 8:20:20”格式的日期字符串
    ///
    func dateStringFromTimeStamp(let timeStamp: NSString) ->String {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 HH:MM:ss"
        
        let date = NSDate(timeIntervalSince1970: timeStamp.doubleValue)
        return formatter.stringFromDate(date)
    }
}