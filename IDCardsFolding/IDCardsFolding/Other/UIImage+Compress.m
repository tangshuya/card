//
//  UIImage+Compress.m
//  ProjectPingo
//
//  Created by JYG on 2016/11/2.
//  Copyright © 2016年 Wifire. All rights reserved.
//

#import "UIImage+Compress.h"

@implementation UIImage (Compress)


/**
 *  压缩图片至目标尺寸
 *
 *  @param sourceImage 源图片
 *  @param targetWidth 图片最终尺寸的宽
 *
 *  @return 返回按照源图片的宽、高比例压缩至目标宽、高的图片
 **/
+ (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

//生成制定大小的黑白二维码
+ (UIImage *)createQRImageWithString:(NSString *)string size:(CGSize)size
{
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    CIImage *qrImage = qrFilter.outputImage;
    //放大并绘制二维码（上面生成的二维码很小，需要放大）
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    //翻转一下图片 不然生成的QRCode就是上下颠倒的
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    
    CGImageRelease(cgImage);
    
    return codeImage;
}

//裁剪圆形图片
- (instancetype)wf_imageWithCircleImage{
    
    if (self.size.width > 180 || self.size.height > 180) {
        
        //    将头像缩小为180X180的比例
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(180, 180), NO, self.scale);
        [self drawInRect:CGRectMake(0, 0, 110, 110)];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        /*   --------------裁剪圆形图片---------------  */
        //    1.开启图形上下文
        UIGraphicsBeginImageContext(image.size);
        
        //    2.获取图形上下文
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //    3.往图形上下文中---添加一个圆
        CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
        
        CGContextAddEllipseInRect(context, rect);
        
        //    4.拿到图形上下文裁切
        CGContextClip(context);
        
        //    5.绘制图片到圆上面
        [self drawInRect:rect];
        
        //    6.获取新图片
        UIImage *newImage1 = UIGraphicsGetImageFromCurrentImageContext();
        
        //    7.关闭图形上下文
        UIGraphicsEndImageContext();
        
        return newImage1;
        
    }else{
        /*   --------------裁剪圆形图片---------------  */
        
        UIGraphicsBeginImageContext(self.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
        CGContextAddEllipseInRect(context, rect);
        
        CGContextClip(context);
        [self drawInRect:rect];
        
        UIImage *newImage2 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage2;
        
    }
}


// 提供一个类方法,供外界调用
+ (instancetype)wf_imageWithCircleImage:(NSString *)imageNamed{
    return [[UIImage imageNamed:imageNamed] wf_imageWithCircleImage];
}



@end
