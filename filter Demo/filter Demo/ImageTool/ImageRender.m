//
//  ImageFilter.m
//  wxer_manager
//
//  Created by JackyLiang on 2017/7/29.
//  Copyright © 2017年 congzhikeji. All rights reserved.
//

#import "ImageRender.h"
#import <Accelerate/Accelerate.h>
#import "FWNashvilleFilter.h"
#import "FWLordKelvinFilter.h"
#import "FWRiseFilter.h"
#import "FWHudsonFilter.h"
#import "FW1977Filter.h"
#import "FWInkwellFilter.h"
#import "FWXproIIFilter.h"
#import "FWWaldenFilter.h"
#import "FWAmaroFilter.h"
#import "FWLomofiFilter.h"
#import "FWSierraFilter.h"
#import "FWValenciaFilter.h"
#import "FWToasterFilter.h"

@implementation ImageRender
/*************************************图片渲染**********************************************/
/**
 *  图片虚化处理
 */
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

/** 改变图片透明度*/
+ (UIImage *)changeAlphaOfImageWith:(CGFloat)alpha withImage:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

/** 反遮罩锐化 */
+ (UIImage *)changeValueForUnsharpenilter:(float)value image:(UIImage *)image
{
    GPUImageUnsharpMaskFilter *filter = [[GPUImageUnsharpMaskFilter alloc] init];
    filter.intensity = 10;
    [filter forceProcessingAtSize:image.size];
    
    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:image];
    [pic addTarget:filter];
    
    [pic processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}

/** 混合滤镜 */
+ (UIImage *)hybridFilter:(float)value image:(UIImage *)image
{
    //初始化GPUImagePicture
    GPUImagePicture *picture = [[GPUImagePicture alloc] initWithImage:image smoothlyScaleOutput:YES];
    
    GPUImageUnsharpMaskFilter *unsharpFilter = [[GPUImageUnsharpMaskFilter alloc] init];
    unsharpFilter.blurRadiusInPixels = 4;
    unsharpFilter.intensity = 10;
    
    GPUImageContrastFilter *contrastFilter = [[GPUImageContrastFilter alloc] init];
    contrastFilter.contrast = 1;
    
    GPUImageBrightnessFilter *brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    brightnessFilter.brightness = 0.5;
    
    //黑白滤镜 像素值亮度平均
    GPUImageAverageLuminanceThresholdFilter *luminanceThresholdFilter = [[GPUImageAverageLuminanceThresholdFilter alloc] init];
    luminanceThresholdFilter.thresholdMultiplier = 0.6;
    
    //*FilterGroup的方式混合滤镜
    //初始化GPUImageFilterGroup
    GPUImageFilterGroup *myFilterGroup = [[GPUImageFilterGroup alloc] init];
    //将滤镜组加在GPUImagePicture上
    [picture addTarget:myFilterGroup];
    //将滤镜加在FilterGroup中
    [self addGPUImageFilter:unsharpFilter group:myFilterGroup];
    [self addGPUImageFilter:contrastFilter group:myFilterGroup];
    [self addGPUImageFilter:luminanceThresholdFilter group:myFilterGroup];
    [self addGPUImageFilter:brightnessFilter group:myFilterGroup];
    
    //处理图片
    [picture processImage];
    [myFilterGroup useNextFrameForImageCapture];
    //拿到处理后的图片
    UIImage *dealedImage = [myFilterGroup imageFromCurrentFramebuffer];
    /** 释放缓存 */
    [[GPUImageContext sharedImageProcessingContext].framebufferCache purgeAllUnassignedFramebuffers];
    [GPUImageContext useImageProcessingContext];
    [unsharpFilter removeAllTargets];
    [contrastFilter removeAllTargets];
    [brightnessFilter removeAllTargets];
    [myFilterGroup removeAllTargets];
    
    return dealedImage;
}

#pragma mark 将滤镜加在FilterGroup中并且设置初始滤镜和末尾滤镜
+ (void)addGPUImageFilter:(id)filter group:(GPUImageFilterGroup *)myFilterGroup{
    
    [myFilterGroup addFilter:filter];
    
    GPUImageOutput<GPUImageInput> *newTerminalFilter = filter;
    
    NSInteger count = myFilterGroup.filterCount;
    
    if (count == 1)
    {
        //设置初始滤镜
        myFilterGroup.initialFilters = @[newTerminalFilter];
        //设置末尾滤镜
        myFilterGroup.terminalFilter = newTerminalFilter;
        
    } else
    {
        GPUImageOutput<GPUImageInput> *terminalFilter    = myFilterGroup.terminalFilter;
        NSArray *initialFilters                          = myFilterGroup.initialFilters;
        
        [terminalFilter addTarget:newTerminalFilter];
        
        //设置初始滤镜
        myFilterGroup.initialFilters = @[initialFilters[0]];
        //设置末尾滤镜
        myFilterGroup.terminalFilter = newTerminalFilter;
    }
}

/** 锐化 */
+ (UIImage *)changeValueForSharpenilter:(float)value image:(UIImage *)image
{
    GPUImageSharpenFilter *filter = [[GPUImageSharpenFilter alloc] init];
    filter.sharpness = value;
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:image];
    [pic addTarget:filter];
    
    [pic processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}
/** 对比度 */
+ (UIImage *)changeValueForContrast:(float)value image:(UIImage *)image
{
    GPUImageContrastFilter *filter = [[GPUImageContrastFilter alloc] init];
    filter.contrast = value;
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:image];
    [pic addTarget:filter];
    
    [pic processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}
/** 亮度 */
+ (UIImage *)changeValueForBrightnessFilter:(float)value image:(UIImage *)image;
{
    GPUImageBrightnessFilter *filter = [[GPUImageBrightnessFilter alloc] init];
    filter.brightness = value;
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:image];
    [pic addTarget:filter];
    
    [pic processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}
//添加滤镜
+(UIImage *)renderFilter:(NSString *)filterName image:(UIImage *)image{
   
    GPUImageOutput<GPUImageInput> * filter = nil;
    if ([filterName isEqualToString:@"原片"]) {
        filter = [[GPUImageSaturationFilter alloc] init];
    }else if ([filterName isEqualToString:@"LOMO"]){
        GPUImageContrastFilter *contrastFilter = [[GPUImageContrastFilter alloc] init];
        contrastFilter.contrast = 1.3;
        filter = contrastFilter;
    }else if ([filterName isEqualToString:@"风景"]){
        filter = [[GPUImageMissEtikateFilter alloc] init];
    }else if ([filterName isEqualToString:@"梦幻"]){
        filter = [[FWWaldenFilter alloc] init];
    }else if ([filterName isEqualToString:@"清凉"]){
        filter = [[FWXproIIFilter alloc] init];
    }else if ([filterName isEqualToString:@"阳光"]){
        filter = [[FWValenciaFilter alloc] init];
    }else if ([filterName isEqualToString:@"温暖"]){
        filter =[[FWToasterFilter alloc] init];
    }else if ([filterName isEqualToString:@"人物"]){
        filter = [[FWNashvilleFilter alloc] init] ;
    }else if ([filterName isEqualToString:@"黄昏"]){
        filter = [[FWLordKelvinFilter alloc] init];
    }else if ([filterName isEqualToString:@"静物"]){
        filter = [[GPUImageAmatorkaFilter alloc] init];
    } else if ([filterName isEqualToString:@"褐色怀旧"]){
        filter = [[GPUImageSepiaFilter alloc] init];
    }else if ([filterName isEqualToString:@"灰度"]){
        filter = [[GPUImageGrayscaleFilter alloc] init];
    }else if ([filterName isEqualToString:@"1977"]){
        filter = [[FW1977Filter alloc] init] ;
    }else if ([filterName isEqualToString:@"黑白"]){
        filter = [[FWInkwellFilter alloc] init];
    }else{
        filter =[[GPUImageSaturationFilter alloc] init];
    }
    
    GPUImagePicture *imageSource = [[GPUImagePicture alloc]initWithImage:image];
    //设置要渲染的区域
    [filter forceProcessingAtSize:image.size];
    [filter useNextFrameForImageCapture];
    [imageSource addTarget:filter];
    [imageSource processImage];
    UIImage *newImage = [filter imageFromCurrentFramebuffer];
    return newImage;
}
@end
