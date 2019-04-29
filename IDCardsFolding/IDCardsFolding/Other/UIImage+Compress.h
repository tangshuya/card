//
//  UIImage+Compress.h
//  ProjectPingo
//
//  Created by JYG on 2016/11/2.
//  Copyright © 2016年 Wifire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compress)


/**
 *  压缩图片至目标尺寸
 *
 *  @param sourceImage 源图片
 *  @param targetWidth 图片最终尺寸的宽
 *
 *  @return 返回按照源图片的宽、高比例压缩至目标宽、高的图片
 **/
+ (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth;


/**
 创建二维码图片

 @param string 存入二维码的信息
 @param size 尺寸
 @return 图片
 */
+ (UIImage *)createQRImageWithString:(NSString *)string size:(CGSize)size;


// 对象方法----裁剪圆形图片
- (instancetype)wf_imageWithCircleImage;

//类方法
+ (instancetype)wf_imageWithCircleImage: (NSString *)imageNamed;
@end
