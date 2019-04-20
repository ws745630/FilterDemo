//
//  ImageFilter.h
//  wxer_manager
//
//  Created by JackyLiang on 2017/7/29.
//  Copyright © 2017年 congzhikeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ImageRender : NSObject
/*************************************图片渲染**********************************************/
/**
 *  图片虚化处理
 */
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

/**
 改变图片透明度
 
 @param alpha 透明度
 @param image 图片
 
 @return 返回指定透明度的图片
 */
+ (UIImage *)changeAlphaOfImageWith:(CGFloat)alpha withImage:(UIImage*)image;


/** 图片锐化
 * value:锐化程度
 * image:操作对象
 */
+ (UIImage *)changeValueForSharpenilter:(float)value image:(UIImage *)image;

/** 图片对比度
 * value:对比度程度
 * image:操作对象
 */
+ (UIImage *)changeValueForContrast:(float)value image:(UIImage *)image;
/** 图片亮度
 * value:亮度程度
 * image:操作对象
 */
+ (UIImage *)changeValueForBrightnessFilter:(float)value image:(UIImage *)image;

/**
 反锐化+对比度
 
 @param value <#value description#>
 @param image <#image description#>
 
 @return <#return value description#>
 */
+ (UIImage *)changeValueForUnsharpenilter:(float)value image:(UIImage *)image;

/**
 混合滤镜
 
 @param value <#value description#>
 @param image <#image description#>
 
 @return <#return value description#>
 */
+ (UIImage *)hybridFilter:(float)value image:(UIImage *)image;

/**
 单一滤镜

 @param filterName 滤镜名字
 @param image 要添加滤镜的image
 
 支持的滤镜
 @[@"原片",@"LOMO",@"风景",@"梦幻",@"清凉",@"阳光",@"温暖",@"人物",@"黄昏",@"褐色怀旧",@"1977",@"黑白"];
 */
+(UIImage *)renderFilter:(NSString *)filterName image:(UIImage *)image;

@end
