//
//  HAppUIModel.h
//  PainKARE-TXB
//
//  Created by Anan on 2017/12/26.
//  Copyright © 2017年 Anan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HAppUIModel : NSObject

#pragma mark 手机屏幕
+ (int)gainScreenModelFromWidth:(CGFloat)width andHeight:(CGFloat)height;

#pragma mark 放大缩小
+ (CGFloat)baseWidthChangeLength:(CGFloat)length baceWidthWithModel:(int)screenModel;
+ (CGFloat)baseLongChangeLength:(CGFloat)length baceWidthWithModel:(int)screenModel ;

#pragma mark 颜色
+ (UIColor *)mainColor1;
+ (UIColor *)mainColor2;
+ (UIColor *)mainColor3;
+ (UIColor *)mainColor4;
+ (UIColor *)mainColor5;
+ (UIColor *)mainColor6;
// 背景色
+ (UIColor *)whiteColor1;
+ (UIColor *)whiteColor2;
+ (UIColor *)whiteColor3;
+ (UIColor *)whiteColor4;
+ (UIColor *)whiteColor5;
+ (UIColor *)whiteColor6;
+ (UIColor *)whiteColor7;
// 蓝色渐变色3种色号
+ (UIColor *)changeBlueColor1;
+ (UIColor *)changeBlueColor2;
+ (UIColor *)changeBlueColor3;
// 灰色渐变色2种色号
+ (UIColor *)changeGrayColor1;
+ (UIColor *)changeGrayColor2;
// 灰色
+ (UIColor *)grayColor1;
+ (UIColor *)grayColor2;
+ (UIColor *)grayColor3;
+ (UIColor *)grayColor4;
+ (UIColor *)grayColor5;
+ (UIColor *)grayColor6;
+ (UIColor *)grayColor7;
+ (UIColor *)grayColor8;
+ (UIColor *)grayColor9;
+ (UIColor *)grayColor10;
+ (UIColor *)grayColor11;
+ (UIColor *)grayColor12;
+ (UIColor *)grayColor13;
+ (UIColor *)grayColor14;
+ (UIColor *)grayColor15;
+ (UIColor *)grayColor16;
+ (UIColor *)grayColor17;
+ (UIColor *)grayColor18;
+ (UIColor *)grayColor19;
+ (UIColor *)grayColor20;
+ (UIColor *)grayColor21;
+ (UIColor *)grayColor22;
+ (UIColor *)grayColor23;
+ (UIColor *)grayColor24;
+ (UIColor *)grayColor25;
+ (UIColor *)grayColor26;
+ (UIColor *)grayColor27;
+ (UIColor *)grayColor28;
// 橘色
+ (UIColor *)orangeColor1;
+ (UIColor *)orangeColor2;
+ (UIColor *)orangeColor3;
+ (UIColor *)orangeColor4;
+ (UIColor *)orangeColor5;
+ (UIColor *)orangeColor6;
+ (UIColor *)orangeColor7;
+ (UIColor *)orangeColor8;
// 紫色
+ (UIColor *)purpleColor1;
+ (UIColor *)purpleColor2;
+ (UIColor *)purpleColor3;
+ (UIColor *)purpleColor4;
// 绿色
+ (UIColor *)greenColor1;
+ (UIColor *)greenColor2;
+ (UIColor *)greenColor3;
+ (UIColor *)greenColor4;
// 透明色
+ (UIColor *)transparentColor1;
+ (UIColor *)transparentColor2;
#pragma mark 字体
// 标题（粗体）
+ (UIFont *)titleFont1;
+ (UIFont *)titleFont2;
// 文字（大粗）
+ (UIFont *)semiboldFont1;
// 文字（中粗）
+ (UIFont *)mediumFont1;
+ (UIFont *)mediumFont2;
+ (UIFont *)mediumFont3;
+ (UIFont *)mediumFont4;
+ (UIFont *)mediumFont5;
+ (UIFont *)mediumFont6;
+ (UIFont *)mediumFont7;
+ (UIFont *)mediumFont8;
+ (UIFont *)mediumFont9;
+ (UIFont *)mediumFont10;
+ (UIFont *)mediumFont11;

// 文字 (正常)
+ (UIFont *)normalFont1;
+ (UIFont *)normalFont2;
+ (UIFont *)normalFont3;
+ (UIFont *)normalFont4;
+ (UIFont *)normalFont5;
+ (UIFont *)normalFont6;
+ (UIFont *)normalFont7;
+ (UIFont *)normalFont8;
// 特效文字
+ (UIFont *)numberFont1;
+ (UIFont *)numberFont2;
+ (UIFont *)numberFont3;

//判断语言是否为中文
+ (BOOL)UIViewIsChinese;

@end
