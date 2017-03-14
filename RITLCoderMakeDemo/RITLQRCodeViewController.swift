//
//  ViewController.swift
//  RITLCoderMakeDemo
//
//  Created by YueWen on 2017/3/7.
//  Copyright © 2017年 YueWen. All rights reserved.
//

import UIKit

class RITLQRCodeViewController: UIViewController {

    /// 图片的高宽，等高
    let imageWidth = 160
    /// logo图片的高宽
    let logoWidth = CGFloat(40)
    /// 接收数据的文本域
    @IBOutlet weak var ritl_textView: UITextView!
    /// 显示二维码的imageView
    @IBOutlet weak var ritl_imageView: UIImageView!
    /// 解析二维码的按钮
    @IBOutlet weak var btnDeQRCode: UIButton!
    /// 显示解析二维码的数据
    @IBOutlet weak var ritl_decodeTextView: UITextView!
    
    /// 预览颜色的视图
    @IBOutlet weak var colorView: UIView!
    
    /* 文本 */
    @IBOutlet weak var redText: UITextField!
    @IBOutlet weak var greenText: UITextField!
    @IBOutlet weak var blueText: UITextField!
    
    /* 记录当前色值 */
    fileprivate var red = 0
    fileprivate var green = 0
    fileprivate var blue = 0

    fileprivate var qrcodeMaker = RITLQRCoderMaker()
    fileprivate var qrcodeAnalyor = RITLQRCoderAnalyor()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //设置解析结果不可修改
        ritl_decodeTextView.isEditable = false
        
        //导航title
        navigationItem.title = "二维码"
        
        //订阅通知
        NotificationCenter.default.addObserver(self, selector: #selector(RITLQRCodeViewController.colorChanged), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    
    override func didReceiveMemoryWarning() {  super.didReceiveMemoryWarning() }
    deinit {  NotificationCenter.default.removeObserver(self) }

    
    
    /// 开始生成二维码
    @IBAction func ritl_startMake(_ sender: Any) {
       
        //获取文本,存在并且不是空串
        guard let text:String = ritl_textView.text,!text.isEmpty else {
            
            print("请输入生成内容的字符串")
            return
        }
        
        //开始生成二维码
        ritl_imageView.image = (qrcodeMaker.createQRCode(value: text, size: CGFloat(imageWidth))!).insertCenterLogo(logo: #imageLiteral(resourceName: "defalut_logo"), size: CGSize(width: logoWidth, height: logoWidth))
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






extension RITLQRCodeViewController  {
    
    /// 监控颜色色值发生变化
    func colorChanged(_ notification:Notification){
        
        //不为空
        guard redText.text != nil, greenText.text != nil, blueText.text != nil else {
            
            return
        }
        
        //获取默认值
        red = Int(redText.text!) ?? 0
        green = Int(greenText.text!) ?? 0
        blue = Int(blueText.text!) ?? 0
        
        //基数
        let colorBase = CGFloat(255.0)
        
        let _red = CGFloat(red) / colorBase
        let _green = CGFloat(green) / colorBase
        let _blue = CGFloat(blue) / colorBase
        
        //获得颜色
        if #available(iOS 10.0, *) {
            
            colorView.backgroundColor = UIColor(displayP3Red: _red, green: _green, blue: _blue, alpha: 1)
            return
        }
        
        colorView.backgroundColor = UIColor(red: _red, green: _green, blue: _blue, alpha: 1)
    }
    
}









