//
//  RITLQRExtension.swift
//  RITLCoderMakeDemo
//
//  Created by YueWen on 2017/3/14.
//  Copyright © 2017年 YueWen. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    /// 插入logo图标
    ///
    /// - Parameters:
    ///   - logo: 插入的logo图标
    ///   - size: logo图片的大小，默认为logo的大小
    /// - Returns: 插入完毕的图片
    open func insertCenterLogo(logo:UIImage,size:CGSize?) -> UIImage? {
        
        // 记录大小
        let logoSize = size ?? logo.size
        let height = self.size.height
        
        guard height >= logoSize.height else {
            
            fatalError("logo size must shorter than image's")
        }
        
        defer { //结束绘制
            UIGraphicsEndImageContext()
        }
        
        UIGraphicsBeginImageContext(self.size)
        
        // 绘制二维码
        self.draw(in: CGRect(x: 0, y: 0, width: height, height: height))
        
        //居中绘制
        let originX = height / 2.0 - logoSize.width / 2.0
        let originY = height / 2.0 - logoSize.height / 2.0
        
        // 绘制logo
        logo.draw(in: CGRect(x: originX, y: originY, width: logoSize.width, height: logoSize.height))
        
        guard let resultImage = UIGraphicsGetImageFromCurrentImageContext() else {
            
            return self
        }
        
        return resultImage
    }
    
    
}
