//
//  UIView+EasyFrame.h
//  WebViewLoger
//
//  Created by jack on 16/5/6.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EasyFrame)

#pragma mark - lazy

@property (nonatomic, readonly) NSString *easy_frameString;

#pragma mark - frame

@property (nonatomic, assign) CGFloat easy_x;
@property (nonatomic, assign) CGFloat easy_y;
@property (nonatomic, assign) CGFloat easy_width;
@property (nonatomic, assign) CGFloat easy_height;
@property (nonatomic, assign) CGSize easy_size;
@property (nonatomic, assign) CGPoint easy_origin;

#pragma mark - extend

@property (nonatomic, assign) CGFloat easy_top;
@property (nonatomic, assign) CGFloat easy_bottom;
@property (nonatomic, assign) CGFloat easy_left;
@property (nonatomic, assign) CGFloat easy_right;
@property (nonatomic, assign) CGFloat easy_midX;
@property (nonatomic, assign) CGFloat easy_midY;

#pragma mark - extend——zai

@property (nonatomic, assign) CGFloat easy_minY;
@property (nonatomic, assign) CGFloat easy_maxY;
@property (nonatomic, assign) CGFloat easy_minX;
@property (nonatomic, assign) CGFloat easy_maxX;
@property (nonatomic, assign) CGFloat easy_centerX;
@property (nonatomic, assign) CGFloat easy_centerY;

#pragma mark - position

@property (nonatomic, assign) CGPoint easy_leftTop;
@property (nonatomic, assign) CGPoint easy_leftBottom;
@property (nonatomic, assign) CGPoint easy_rightTop;
@property (nonatomic, assign) CGPoint easy_rightBottom;

#pragma mark - CALayer

- (void)addBorderWithWidth:(CGFloat)width color:(UIColor *)color isLeftAdd:(BOOL)isLeft;
- (void)addTopBorderWithHeight:(CGFloat)height color:(UIColor *)color;
- (void)addLeftBorderWithWidth:(CGFloat)width color:(UIColor *)color;
- (void)addBottomBorderWithHeight:(CGFloat)height color:(UIColor *)color;
- (void)addRightBorderWithWidth:(CGFloat)width color:(UIColor *)color;


-(void)drawLineWithColor:(UIColor *)color width:(float)width beginPoint:(CGPoint)pointA endPoint:(CGPoint)pointB;
@end
