//
//  ViewController.swift
//  RITLCoderMakeDemo
//
//  Created by YueWen on 2017/3/7.
//  Copyright © 2017年 YueWen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /// 图片的高宽，等高
    let imageWidth = 160
    /// 接收数据的文本域
    @IBOutlet weak var ritl_textView: UITextView!
    /// 显示二维码的imageView
    @IBOutlet weak var ritl_imageView: UIImageView!
    /// 解析二维码的按钮
    @IBOutlet weak var btnDeQRCode: UIButton!
    /// 显示解析二维码的数据
    @IBOutlet weak var ritl_decodeTextView: UITextView!
    
    fileprivate var qrcodeMaker = RITLQRCoderMaker()
    fileprivate var qrcodeAnalyor = RITLQRCoderAnalyor()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //设置解析结果不可修改
        ritl_decodeTextView.isEditable = false
    }
    
    
    override func didReceiveMemoryWarning() {  super.didReceiveMemoryWarning() }

    
    /// 开始生成二维码
    @IBAction func ritl_startMake(_ sender: Any) {
       
        //获取文本,存在并且不是空串
        guard let text:String = ritl_textView.text,!text.isEmpty else {
            
            print("请输入生成内容的字符串")
            return
        }
        
        //开始生成二维码
        ritl_imageView.image = qrcodeMaker.start(value: text, size: CGFloat(imageWidth))
    }
    
    /// 开始解析二维码
    @IBAction func ritl_startDecode(_ sender: Any) {
        
        guard let image = ritl_imageView.image else {
            
            print("没有二维码图片")
            return
        }
        
        //开始解析
        ritl_decodeTextView.text = qrcodeAnalyor.start(image: image)
        
    }
    

}

