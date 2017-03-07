# RITLCoderMakeDemo
A demo to make qrcode and analysize qrcode
```
 //开始生成二维码
ritl_imageView.image = qrcodeMaker.start(value: text, size: CGFloat(imageWidth))


//开始解析
ritl_decodeTextView.text = qrcodeAnalyor.start(image: image)
```
![QRCoder.gif](https://github.com/RITL/RITLCoderMakeDemo/blob/master/Assets/QRCoder.gif)
