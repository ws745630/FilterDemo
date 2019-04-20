//
//  Define.h
//  SuperEducation
//
//  Created by yangming on 2017/2/21.
//  Copyright © 2017年 luoqi. All rights reserved.
//

#ifndef Skin_h
#define Skin_h

/*====================================UI定义============================================*/
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define SCALE_WIDTH [UIScreen mainScreen].bounds.size.width/375
#define SCALE_HEIGHT [UIScreen mainScreen].bounds.size.height/667

#define AdaptX(x) [UIScreen mainScreen].bounds.size.width / 375 * x
#define AdaptY(y) [UIScreen mainScreen].bounds.size.height / 667 * y
#define HAdaptX(x) [UIScreen mainScreen].bounds.size.width / 667 * x
#define HAdaptY(y) [UIScreen mainScreen].bounds.size.height / 375 * y

#define LeftPadding AdaptX(15)


#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#endif


// View 圆角，边框
#define ViewBorderRadius(View, Radius, Width, Color)\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]\

// View 圆角
#define ViewRadius(View, Radius)\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//View 自定义切角位置
#define ViewRadiusCustom(View,Conrners,Size)\
UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:View.bounds byRoundingCorners:Conrners cornerRadii:Size];\
CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];\
maskLayer.frame = View.bounds;\
maskLayer.path = maskPath.CGPath;\
View.layer.mask = maskLayer;



//View 阴影切角
#define ViewShadow(View, shadowOffset, shadowColor, shadowOpacity, shadowRadius, cornerRadius)\
[View.layer setShadowColor:[shadowColor CGColor]];\
[View.layer setShadowOffset:(shadowOffset)];\
[View.layer setShadowOpacity:(shadowOpacity)];\
[View.layer setShadowRadius:(shadowRadius)];\
[View.layer setCornerRadius:(cornerRadius)]

//Masonry
#define MakeConstraints(TopView, Topoffset,LeftView, Leftoffset,BottomView, Bottomoffset,RightView,rightOffset)\
if(TopView)\
make.top.equalTo(TopView).offset(Topoffset);\
if(LeftView)\
make.left.equalTo(LeftView).offset(Leftoffset);\
if(BottomView)\
make.bottom.equalTo(BottomView).offset(Bottomoffset);\
if(RightView)\
make.right.equalTo(RightView).offset(rightOffset)


//Skin
#define NAVBARCOLOR [UIColor colorWithRed:91/255.0 green:91/255.0 blue:91/255.0 alpha:1]

#define ColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define ColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define LightLineColor [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1]
#define ScanYellowColor ColorRGBA(242, 211, 11, 1)
#define MainBlueColor ColorFromHex(0x2f9be9)
#define LineColor ColorRGBA(235, 235, 235, 1)
#define FailureTextColor ColorRGBA(154, 154, 154, 1)
#define DecribeTextColor ColorFromHex(0x9a9a9a)
#define LightTextColor ColorFromHex(0xcccccc)
#define BackGreenColor ColorRGBA(91, 175, 91, 1)
#define MainTextColor ColorFromHex(0x4a4a4a)
#define WhiteTextColor [UIColor whiteColor]
#define RedTextColor [UIColor redColor]
#define MainOrangColor ColorRGBA(255, 144, 0, 1)
#define TranslucentColor ColorRGBA(118, 118, 118, 0.5)//半透明颜色
#define BlackTranslucentColor [[UIColor blackColor] colorWithAlphaComponent:0.3]
#define BackGroundColor  [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1]
#define RandColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
#define CyanColor ColorRGBA(38, 255, 255, 1)


//Font
#define Font(F) [UIFont systemFontOfSize:(F)]
#define BoldFont(F) [UIFont boldSystemFontOfSize:(F)]//加粗字体
#define AdaptFont(F) Font(AdaptX(F))
#define ImageName(N) [UIImage imageNamed:N]

//是否为空或是[NSNull null]
#define NotNilAndNull(_ref) (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref) (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

#define WeakSelf(type)  __weak typeof(type) weak##type = type;//使用：直接 WeakSelf(self)

//本地路径
#define SearchHistoryPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"searchhistory.data"]
#define NoteSearchHistoryPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"noteSearchhistory.data"]
/******************************** typedef ********************************/

typedef void (^BaseBlock)();
typedef void (^BaseIntBlock )(NSInteger tag);
typedef void (^BaseFloatBlock )(CGFloat value);
typedef void (^BaseIdBlock )(id parameter);
typedef void (^BaseBoolBlock )(BOOL tag);
typedef void (^BaseDoubleBlock)(id parameter1,id parameter2);
typedef void (^BaseThreeBlock)(id parameter1,id parameter2,id parameter3);

