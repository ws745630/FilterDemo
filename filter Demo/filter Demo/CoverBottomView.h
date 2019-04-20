//
//  CoverBottomView.h
//  wxer_manager
//
//  Created by levin on 2017/7/11.
//  Copyright © 2017年 congzhikeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CoverBottomView,FilterModel;
@protocol CoverBottomDelegate <NSObject>
//点击
- (void)coverBottom:(CoverBottomView *)coverView didSelectModel:(FilterModel *)model;
@end

@interface CoverBottomView : UIView

@property (nonatomic, assign) id<CoverBottomDelegate> delegate;

@end
