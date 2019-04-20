//
//  UIView+EasyFrame.m
//  WebViewLoger
//
//  Created by jack on 16/5/6.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "UIView+EasyFrame.h"

@implementation UIView (EasyFrame)

@dynamic easy_frameString;
@dynamic easy_x, easy_y, easy_width, easy_height, easy_size, easy_origin;
@dynamic easy_top, easy_bottom, easy_left, easy_right, easy_midX, easy_midY;
@dynamic easy_leftTop, easy_leftBottom, easy_rightTop, easy_rightBottom;

#pragma mark - lazy

- (NSString *)easy_frameString {
    return NSStringFromCGRect(self.frame);
}

#pragma mark - frame

- (void)setEasy_x:(CGFloat)easy_x {
    CGRect newFrame = self.frame;
    newFrame.origin.x = easy_x;
    self.frame = newFrame;
}

- (CGFloat)easy_x {
    return CGRectGetMinX(self.frame);
}

- (void)setEasy_y:(CGFloat)easy_y {
    CGRect newFrame = self.frame;
    newFrame.origin.y = easy_y;
    self.frame = newFrame;
}

- (CGFloat)easy_y {
    return CGRectGetMinY(self.frame);
}

- (void)setEasy_width:(CGFloat)easy_width {
    CGRect newFrame = self.frame;
    newFrame.size.width = easy_width;
    self.frame = newFrame;
}

- (CGFloat)easy_width {
    return CGRectGetWidth(self.frame);
}

- (void)setEasy_height:(CGFloat)easy_height {
    CGRect newFrame = self.frame;
    newFrame.size.height = easy_height;
    self.frame = newFrame;
}

- (CGFloat)easy_height {
    return CGRectGetHeight(self.frame);
}

- (void)setEasy_size:(CGSize)easy_size {
    CGRect newFrame = self.frame;
    newFrame.size = easy_size;
    self.frame = newFrame;
}

- (CGSize)easy_size {
    return self.frame.size;
}

- (void)setEasy_origin:(CGPoint)easy_origin {
    CGRect newFrame = self.frame;
    newFrame.origin = easy_origin;
    self.frame = newFrame;
}

- (CGPoint)easy_origin {
    return self.frame.origin;
}

#pragma mark - extend

- (void)setEasy_top:(CGFloat)easy_top {
    self.easy_y = easy_top;
}

- (CGFloat)easy_top {
    return self.easy_y;
}

- (void)setEasy_bottom:(CGFloat)easy_bottom {
    CGRect newFrame = self.frame;
    newFrame.origin.y = easy_bottom - newFrame.size.height;
    self.frame = newFrame;
}

- (CGFloat)easy_bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setEasy_left:(CGFloat)easy_left {
    self.easy_x = easy_left;
}

- (CGFloat)easy_left {
    return self.easy_x;
}

- (void)setEasy_right:(CGFloat)easy_right {
    CGRect newFrame = self.frame;
    newFrame.origin.x = easy_right - newFrame.size.width;
    self.frame = newFrame;
}

- (CGFloat)easy_right {
    return CGRectGetMaxX(self.frame);
}

- (void)setEasy_midX:(CGFloat)easy_midX {
    CGPoint newCenter = self.center;
    newCenter.x = easy_midX;
    self.center = newCenter;
}

- (CGFloat)easy_midX {
    return self.center.x;
}

- (void)setEasy_midY:(CGFloat)easy_midY {
    CGPoint newCenter = self.center;
    newCenter.y = easy_midY;
    self.center = newCenter;
}

- (CGFloat)easy_midY {
    return self.center.y;
}
#pragma mark - extend——zai
-(CGFloat)easy_minX{
    return self.easy_left;
}
-(void)setEasy_minX:(CGFloat)easy_minX{
    self.easy_left = easy_minX;
}
-(CGFloat)easy_maxX{
    return self.easy_right;
}
-(void)setEasy_maxX:(CGFloat)easy_maxX{
    CGRect newFrame = self.frame;
    newFrame.origin.x = easy_maxX - newFrame.size.width;
    self.frame = newFrame;
}

-(CGFloat)easy_minY{
    return self.easy_top;
}
-(void)setEasy_minY:(CGFloat)easy_minY{
    self.easy_y = easy_minY;
}
-(CGFloat)easy_maxY{
    return self.easy_bottom;
}

-(void)setEasy_maxY:(CGFloat)easy_maxY{
    CGRect newFrame = self.frame;
    newFrame.origin.y = easy_maxY - newFrame.size.height;
    self.frame = newFrame;
}
-(CGFloat)easy_centerX{
    return self.center.x;
}

-(void)setEasy_centerX:(CGFloat)easy_centerX{
    CGPoint newCenter = self.center;
    newCenter.x = easy_centerX;
    self.center = newCenter;
}
-(CGFloat)easy_centerY{
    return self.center.y;
}
-(void)setEasy_centerY:(CGFloat)easy_centerY{
    CGPoint newCenter = self.center;
    newCenter.y = easy_centerY;
    self.center = newCenter;
}
-(void)setEasy_middleY:(CGFloat)easy_centerY{
    CGPoint newCenter = self.center;
    newCenter.y = easy_centerY;
    self.center = newCenter;
}
#pragma mark - position

- (void)setEasy_leftTop:(CGPoint)easy_leftTop {
    self.easy_origin = easy_leftTop;
}

- (CGPoint)easy_leftTop {
    return self.easy_origin;
}

- (void)setEasy_leftBottom:(CGPoint)easy_leftBottom {
    self.easy_left = easy_leftBottom.x;
    self.easy_bottom = easy_leftBottom.y;
}

- (CGPoint)easy_leftBottom {
    return CGPointMake(self.easy_left, self.easy_bottom);
}

- (void)setEasy_rightTop:(CGPoint)easy_rightTop {
    self.easy_right = easy_rightTop.x;
    self.easy_top = easy_rightTop.y;
}

- (CGPoint)easy_rightTop {
    return CGPointMake(self.easy_right, self.easy_top);
}

- (void)setEasy_rightBottom:(CGPoint)easy_rightBottom {
    self.easy_right = easy_rightBottom.x;
    self.easy_bottom = easy_rightBottom.y;
}

- (CGPoint)easy_rightBottom {
    return CGPointMake(self.easy_right, self.easy_bottom);
}

#pragma mark - CALayer

- (void)addBorderWithWidth:(CGFloat)width color:(UIColor *)color isLeftAdd:(BOOL)isLeft{
    [self addTopBorderWithHeight:width color:color];
    [self addBottomBorderWithHeight:width color:color];
    [self addRightBorderWithWidth:width color:color];
    if (isLeft) {
        [self addLeftBorderWithWidth:width color:color];
    }
}

- (void)addTopBorderWithHeight:(CGFloat)height color:(UIColor *)color{
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, self.frame.size.width, height);
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
}

- (void)addBottomBorderWithHeight:(CGFloat)height color:(UIColor *)color{
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, self.frame.size.height - height, self.frame.size.width, height);
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
}

- (void)addLeftBorderWithWidth:(CGFloat)width color:(UIColor *)color{
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, width, self.frame.size.height);
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
}

- (void)addRightBorderWithWidth:(CGFloat)width color:(UIColor *)color{
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height);
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
}



-(void)drawLineWithColor:(UIColor *)color width:(float)width beginPoint:(CGPoint)pointA endPoint:(CGPoint)pointB{
    
    UIBezierPath *beziePath = [UIBezierPath bezierPath];
    [beziePath moveToPoint:pointA];
    [beziePath addLineToPoint:pointB];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = beziePath.CGPath;
    layer.strokeColor = color.CGColor;
    layer.lineWidth = width;
    
    [self.layer addSublayer:layer];
    
}
@end

