//
//  RITLQRCoderMaker.swift
//  RITLCoderMakeDemo
//
//  Created by YueWen on 2017/3/7.
//  Copyright © 2017年 YueWen. All rights reserved.
//

import UIKit

/// 生成二维码的类
class RITLQRCoderMaker: NSObject {
    
    /// 存放属性的结构体
    struct RITLQRCoderMakerProps {
        
        static let name = "CIQRCodeGenerator"
        static let dataPath = "InputMessage"
    }

    /// 开始生成二维码
    ///
    /// - Parameters:
    ///   - value: 二维码内容
    ///   - size: 生成图片的大小
    ///   - colorful: 使用颜色，默认为false
    ///   - color: 生成的颜色，默认为黑色
    /// - Returns: 生成的二维码图片对象
    func start(value:String, size:CGFloat, colorful:Bool = false, color:UIColor = .black) -> UIImage? {
        
        // 生成一个过滤器
        guard let filter = CIFilter(name: RITLQRCoderMakerProps.name) else {
            
            print("过滤器创建失败!"); return nil
        }
        
        // 还原滤镜默认属性
        filter.setDefaults()
        
        // 转成二进制数据
        let data = value.data(using: .utf8)
        
        //
        filter.setValue(data, forKeyPath: RITLQRCoderMakerProps.dataPath)
        
        //从滤镜中取出生成好的二维码图片
        guard let image = filter.outputImage else {
            
            return nil
        }
        
        return __ritl_create(highDefinition: image, size: size, colorful: colorful, color: color)
    }
    
    
    /// 生成高清二维码
    ///
    /// - Parameters:
    ///   - image: 处理的CIImage对象
    ///   - size: 二维码的大小
    ///   - colorful: 是否使用色彩
    ///   - color: 色彩,默认为黑色
    /// - Returns: 高清二维码图片
    fileprivate func __ritl_create(highDefinition image:CIImage, size:CGFloat,colorful:Bool = false, color:UIColor = .black) -> UIImage? {
        
        // 获得图片最小的矩形范围
        let extentRect = image.extent.integral
        
        // 获得比例
        let scale = min(size / extentRect.width, size / extentRect.height)
        
        // 创建bitmap
        let width: size_t = size_t(extentRect.width * scale)
        let height: size_t = size_t(extentRect.height * scale)
        
        //创建灰度Ref
        let cs = CGColorSpaceCreateDeviceGray()
        
        //创建map，使用RGB进行渲染
        guard let bitmapRef = CGContext.init(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: CGImageAlphaInfo.none.rawValue) else {
            
            print("创建bitmapRef失败"); return nil
        }
        
        
        // 创建CI环境
        let context = CIContext(options: nil)
        
        // 进行处理
        guard let bitmapImage = context.createCGImage(image, from: extentRect) else {
            
            print("创建CGImage对象失败"); return nil
        }
        
        bitmapRef.interpolationQuality = .none //none让环境自己决定
        bitmapRef.scaleBy(x: scale, y: scale)
        bitmapRef.draw(bitmapImage, in: extentRect)
        
        //保存图片
        guard let scaledImage = bitmapRef.makeImage() else {
            
            print("创建图片失败!"); return nil
        }
        
        // 黑白色彩
        if !colorful {
            
            return UIImage(cgImage: scaledImage)
        }

        //彩色
        return __ritl_colorful(image: UIImage(cgImage: scaledImage), color: color)
    }
    
    
    
    
    /// 将图片进行色彩填充
    ///
    /// - Parameters:
    ///   - image: 生成的黑白二维码
    ///   - color: 渲染的色彩
    /// - Returns: 彩色二维码
    fileprivate func __ritl_colorful(image:UIImage,color:UIColor) -> UIImage? {
        
//        //获得高宽
//        let imageWidth: Int = Int(image.size.width)
//        let imageHeight: Int = Int(image.size.height)
//        
//        let bytesPerRow = imageWidth * 4
////        let rgbImageBuf = 
//        
//        //生成色彩域
//        let colorSapce = CGColorSpaceCreateDeviceRGB()
//        
//        //创建map，使用RGB进行渲染
//        guard let bitmapRef = CGContext.init(data: nil, width: imageWidth, height: imageHeight, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSapce, bitmapInfo: <#T##UInt32#>) else {
//            
//            print("创建bitmapRef失败"); return nil
//        }
        
        return image
        
    }

}
