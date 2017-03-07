//
//  RITLQRCoderAnalyor.swift
//  RITLCoderMakeDemo
//
//  Created by YueWen on 2017/3/7.
//  Copyright © 2017年 YueWen. All rights reserved.
//

import UIKit


/// 解析二维码的分析器
class RITLQRCoderAnalyor: NSObject {
    

    /// 开始解析图片的二维码
    ///
    /// - Parameter image: 附带二维码的图片
    /// - Returns: 二维码的内容
    func start(image:UIImage) -> String? {
        
        //初始化检测器
        guard  let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh]) else {
            
            print("检测器生成失败!"); return nil
        }
        
        //获得cgImage
        guard let cgImage = image.cgImage else {
            
            print("cgImage失败!"); return nil
        }
        
        //开始检测
        let features = detector.features(in: CIImage(cgImage: cgImage))
        
        if features.count < 1 {
            
            return nil
        }
        
        //获得第一个
        let feature = features.first
        
        if feature is CIQRCodeFeature {
            
            //强转
            return (feature as! CIQRCodeFeature).messageString
        }
        
        return nil
    }
    

}
