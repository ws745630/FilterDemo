//
//  FilterModel.h
//  filter Demo
//
//  Created by wangcl on 2019/4/20.
//  Copyright © 2019 wangcl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilterModel : NSObject

@property (nonatomic, strong) GPUImageOutput<GPUImageInput> *filter;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) UIImage *image;//加过滤镜
@property (nonatomic, assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
