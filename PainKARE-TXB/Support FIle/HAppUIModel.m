//
//  HAppUIModel.m
//  PainKARE-TXB
//
//  Created by Anan on 2017/12/26.
//  Copyright © 2017年 Anan. All rights reserved.
//

#import "HAppUIModel.h"
#import "AppDelegate.h"

@implementation HAppUIModel

#pragma mark 手机屏幕
+ (int)gainScreenModelFromWidth:(CGFloat)width andHeight:(CGFloat)height {
    if (width == 320 && height == 568) {
        NSLog(@">>> iPhone5s");
        return 1;
    } else if (width == 375 && height == 667) {
        NSLog(@">>> iPhone6 iPhone6s iPhone7 iPhone8");
        return 2;
    } else if (width == 414 && height == 736) {
        NSLog(@">>> iPhone6Plus iPhone6sPlus iPhone7Plus iPhone8Plus");
        return 3;
    } else if (width == 375 && height == 812) {
        NSLog(@">>> iPhoneX");
        return 4;
    } else {
        return 0;
    }
}

#pragma mark 放大缩小（宽）
// 按宽度
+ (CGFloat)baseWidthChangeLength:(CGFloat)length baceWidthWithModel:(int)screenModel {
    switch (screenModel) {
        case 1:
            return length * 320 / 375;
            break;
        case 2:
            return length;
            break;
        case 3:
            return length * 414 / 375;
            break;
        case 4:
            return length;
            break;
        default:
            return length;
            break;
    }
}
// 按高度
+ (CGFloat)baseLongChangeLength:(CGFloat)length baceWidthWithModel:(int)screenModel {
    switch (screenModel) {
        case 1:
            return length * 568 / 667;
            break;
        case 2:
            return length;
            break;
        case 3:
            return length * 736 / 667;
            break;
        case 4:
            return length;
            break;
        default:
            return length;
            break;
    }
}

#pragma mark 颜色
// 主色调：蓝
+ (UIColor *)mainColor1 {
    UIColor *color = [[UIColor alloc]initWithRed:57.0f/255.0f green:209.0f/255.0f blue:219.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)mainColor2 {
    UIColor *color = [[UIColor alloc]initWithRed:77.0f/255.0f green:214.0f/255.0f blue:221.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)mainColor3 {
    UIColor *color = [[UIColor alloc]initWithRed:42.0f/255.0f green:206.0f/255.0f blue:229.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)mainColor4 {
    UIColor *color = [[UIColor alloc]initWithRed:14.0f/255.0f green:174.0f/255.0f blue:200.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)mainColor5 {
    UIColor *color = [[UIColor alloc]initWithRed:111.0f/255.0f green:219.0f/255.0f blue:224.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)mainColor6 {
    UIColor *color = [[UIColor alloc]initWithRed:0.0f/255.0f green:189.0f/255.0f blue:202.0f/255.0f alpha:1];
    return color;
}
// 蓝色渐变色3种色号
+ (UIColor *)changeBlueColor1 {
    UIColor *color = [[UIColor alloc]initWithRed:35.0f/255.0f green:206.0f/255.0f blue:217.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)changeBlueColor2 {
    UIColor *color = [[UIColor alloc]initWithRed:74.0f/255.0f green:238.0f/255.0f blue:202.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)changeBlueColor3 {
    UIColor *color = [[UIColor alloc]initWithRed:127.0f/255.0f green:230.0f/255.0f blue:177.0f/255.0f alpha:1];
    return color;
}
// 灰色渐变色2种色号
+ (UIColor *)changeGrayColor1 {
    UIColor *color = [[UIColor alloc]initWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)changeGrayColor2 {
    UIColor *color = [[UIColor alloc]initWithRed:219.0f/255.0f green:219.0f/255.0f blue:219.0f/255.0f alpha:1];
    return color;
}
// 背景色
+ (UIColor *)whiteColor1 {
    UIColor *color = [[UIColor alloc]initWithRed:251.0f/255.0f green:251.0f/255.0f blue:251.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)whiteColor2 {
    UIColor *color = [[UIColor alloc]initWithRed:246.0f/255.0f green:246.0f/255.0f blue:246.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)whiteColor3 {
    UIColor *color = [[UIColor alloc]initWithRed:232.0f/255.0f green:232.0f/255.0f blue:232.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)whiteColor4 {
    UIColor *color = [[UIColor alloc]initWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)whiteColor5 {
    UIColor *color = [[UIColor alloc]initWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)whiteColor6 {
    UIColor *color = [[UIColor alloc]initWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)whiteColor7 {
    UIColor *color = [[UIColor alloc]initWithRed:241.0f/255.0f green:241.0f/255.0f blue:241.0f/255.0f alpha:1];
    return color;
}
// 灰色
+ (UIColor *)grayColor1 {
    UIColor *color = [[UIColor alloc]initWithRed:121.0f/255.0f green:121.0f/255.0f blue:121.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor2 {
    UIColor *color = [[UIColor alloc]initWithRed:141.0f/255.0f green:141.0f/255.0f blue:141.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor3 {
    UIColor *color = [[UIColor alloc]initWithRed:118.0/255.0f green:118.0/255.0f blue:118.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor4 {
    UIColor *color = [[UIColor alloc]initWithRed:73.0f/255.0f green:73.0f/255.0f blue:73.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor5 {
    UIColor *color = [[UIColor alloc]initWithRed:62.0/255.0f green:62.0/255.0f blue:62.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor6 {
    UIColor *color = [[UIColor alloc]initWithRed:55.0/255.0f green:55.0/255.0f blue:55.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor7 {
    UIColor *color = [[UIColor alloc]initWithRed:160.0/255.0f green:160.0/255.0f blue:160.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor8 {
    UIColor *color = [[UIColor alloc]initWithRed:93.0/255.0f green:93.0/255.0f blue:93.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor9 {
    UIColor *color = [[UIColor alloc]initWithRed:89.0/255.0f green:89.0/255.0f blue:89.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor10 {
    UIColor *color = [[UIColor alloc]initWithRed:151.0/255.0f green:151.0/255.0f blue:151.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor11 {
    UIColor *color = [[UIColor alloc]initWithRed:97.0/255.0f green:97.0/255.0f blue:97.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor12 {
    UIColor *color = [[UIColor alloc]initWithRed:92.0/255.0f green:92.0/255.0f blue:92.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor13 {
    UIColor *color = [[UIColor alloc]initWithRed:68.0/255.0f green:68.0/255.0f blue:68.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor14 {
    UIColor *color = [[UIColor alloc]initWithRed:198.0/255.0f green:198.0/255.0f blue:198.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor15 {
    UIColor *color = [[UIColor alloc]initWithRed:161.0/255.0f green:161.0/255.0f blue:161.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor16 {
    UIColor *color = [[UIColor alloc]initWithRed:88.0/255.0f green:88.0/255.0f blue:88.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor17 {
    UIColor *color = [[UIColor alloc]initWithRed:177.0/255.0f green:177.0/255.0f blue:177.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor18 {
    UIColor *color = [[UIColor alloc]initWithRed:99.0/255.0f green:99.0/255.0f blue:99.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor19 {
    UIColor *color = [[UIColor alloc]initWithRed:153.0/255.0f green:153.0/255.0f blue:153.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor20 {
    UIColor *color = [[UIColor alloc]initWithRed:124.0/255.0f green:124.0/255.0f blue:124.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor21 {
    UIColor *color = [[UIColor alloc]initWithRed:16.0/255.0f green:8.0/255.0f blue:8.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor22 {
    UIColor *color = [[UIColor alloc]initWithRed:179.0/255.0f green:179.0/255.0f blue:179.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor23 {
    UIColor *color = [[UIColor alloc]initWithRed:107.0/255.0f green:107.0/255.0f blue:107.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor24 {
    UIColor *color = [[UIColor alloc]initWithRed:214.0f/255.0f green:214.0f/255.0f blue:214.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor25 {
    UIColor *color = [[UIColor alloc]initWithRed:119.0f/255.0f green:119.0f/255.0f blue:119.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor26 {
    UIColor *color = [[UIColor alloc]initWithRed:60.0f/255.0f green:60.0f/255.0f blue:60.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor27 {
    UIColor *color = [[UIColor alloc]initWithRed:191.0f/255.0f green:191.0f/255.0f blue:191.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)grayColor28 {
    UIColor *color = [[UIColor alloc]initWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1];
    return color;
}
// 橘色
+ (UIColor *)orangeColor1 {
    UIColor *color = [[UIColor alloc]initWithRed:212.0f/255.0f green:94.0f/255.0f blue:23.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)orangeColor2 {
    UIColor *color = [[UIColor alloc]initWithRed:237.0f/255.0f green:133.0f/255.0f blue:70.0f/255.0f alpha:1];
    return color;
}
+ (UIColor *)orangeColor3 {
    UIColor *color = [[UIColor alloc]initWithRed:240.0/255.0f green:169.0/255.0f blue:127.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)orangeColor4 {
    UIColor *color = [[UIColor alloc]initWithRed:247.0/255.0f green:206.0/255.0f blue:183.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)orangeColor5 {
    UIColor *color = [[UIColor alloc]initWithRed:214.0/255.0f green:88.0/255.0f blue:12.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)orangeColor6 {
    UIColor *color = [[UIColor alloc]initWithRed:242.0/255.0f green:179.0/255.0f blue:141.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)orangeColor7 {
    UIColor *color = [[UIColor alloc]initWithRed:239.0/255.0f green:175.0/255.0f blue:132.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)orangeColor8 {
    UIColor *color = [[UIColor alloc]initWithRed:234.0/255.0f green:134.0/255.0f blue:37.0/255.0f alpha:1];
    return color;
}
// 紫色
+ (UIColor *)purpleColor1 {
    UIColor *color = [[UIColor alloc]initWithRed:60.0/255.0f green:0.0/255.0f blue:131.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)purpleColor2 {
    UIColor *color = [[UIColor alloc]initWithRed:198.0/255.0f green:157.0/255.0f blue:246.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)purpleColor3 {
    UIColor *color = [[UIColor alloc]initWithRed:218.0/255.0f green:191.0/255.0f blue:250.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)purpleColor4 {
    UIColor *color = [[UIColor alloc]initWithRed:199.0/255.0f green:159.0/255.0f blue:245.0/255.0f alpha:1];
    return color;
}
// 绿色
+ (UIColor *)greenColor1 {
    UIColor *color = [[UIColor alloc]initWithRed:121.0/255.0f green:161.0/255.0f blue:0.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)greenColor2 {
    UIColor *color = [[UIColor alloc]initWithRed:161.0/255.0f green:212.0/255.0f blue:7.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)greenColor3 {
    UIColor *color = [[UIColor alloc]initWithRed:201.0/255.0f green:220.0/255.0f blue:144.0/255.0f alpha:1];
    return color;
}
+ (UIColor *)greenColor4 {
    UIColor *color = [[UIColor alloc]initWithRed:163.0/255.0f green:212.0/255.0f blue:12.0/255.0f alpha:1];
    return color;
}
// 透明色
+ (UIColor *)transparentColor1 {
    UIColor *color = [[UIColor alloc]initWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.4f];
    return color;
}
+ (UIColor *)transparentColor2 {
    UIColor *color = [[UIColor alloc]initWithRed:57.0/255.0f green:209.0/255.0f blue:219.0/255.0f alpha:0.4f];
    return color;
}
#pragma mark 字体
// 标题（粗体）
+ (UIFont *)titleFont1 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont boldSystemFontOfSize:ceil(19 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont boldSystemFontOfSize:19];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont boldSystemFontOfSize:ceil(19 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont boldSystemFontOfSize:19];
        return font;
    } else {
        UIFont *font = [UIFont boldSystemFontOfSize:19];
        return font;
    }
}
+ (UIFont *)titleFont2 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont boldSystemFontOfSize:ceil(18 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont boldSystemFontOfSize:18];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont boldSystemFontOfSize:ceil(18 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont boldSystemFontOfSize:18];
        return font;
    } else {
        UIFont *font = [UIFont boldSystemFontOfSize:18];
        return font;
    }
}
// 文字（大粗）
+ (UIFont *)semiboldFont1 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Semibold" size:ceil(22 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Semibold" size:22];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Semibold" size:ceil(22 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Semibold" size:22];
        return font;
    } else {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Semibold" size:22];
        return font;
    }
}
// 文字（中粗）
+ (UIFont *)mediumFont1 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(16 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(16 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        return font;
    } else {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        return font;
    }
}
+ (UIFont *)mediumFont2 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(14 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(14 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        return font;
    } else {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        return font;
    }
}
+ (UIFont *)mediumFont3 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(17 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(17 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
        return font;
    } else {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
        return font;
    }
}
+ (UIFont *)mediumFont4 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(15 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(15 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
        return font;
    } else {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
        return font;
    }
}
+ (UIFont *)mediumFont5 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(13 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(13 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
        return font;
    } else {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
        return font;
    }
}
+ (UIFont *)mediumFont6 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(16 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(16 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        return font;
    } else {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        return font;
    }
}
+ (UIFont *)mediumFont7 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(20 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(20 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
        return font;
    } else {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
        return font;
    }
}
+ (UIFont *)mediumFont8 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(12 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(12 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
        return font;
    } else {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
        return font;
    }
}
+ (UIFont *)mediumFont9 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(18 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(18 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        return font;
    } else {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        return font;
    }
}
+ (UIFont *)mediumFont10 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(24 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:24];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(24 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:24];
        return font;
    } else {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:24];
        return font;
    }
}

+ (UIFont *)mediumFont11 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(13 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:ceil(13 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
        return font;
    } else {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
        return font;
    }
}

// 文字 (正常)
+ (UIFont *)normalFont1 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont systemFontOfSize:ceil(16 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont systemFontOfSize:16];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont systemFontOfSize:ceil(16 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont systemFontOfSize:16];
        return font;
    } else {
        UIFont *font = [UIFont systemFontOfSize:16];
        return font;
    }
}
+ (UIFont *)normalFont2 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont systemFontOfSize:ceil(14 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont systemFontOfSize:14];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont systemFontOfSize:ceil(14 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont systemFontOfSize:14];
        return font;
    } else {
        UIFont *font = [UIFont systemFontOfSize:14];
        return font;
    }
}
+ (UIFont *)normalFont3 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont systemFontOfSize:ceil(17 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont systemFontOfSize:17];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont systemFontOfSize:ceil(17 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont systemFontOfSize:17];
        return font;
    } else {
        UIFont *font = [UIFont systemFontOfSize:17];
        return font;
    }
}
+ (UIFont *)normalFont4 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont systemFontOfSize:ceil(12 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont systemFontOfSize:12];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont systemFontOfSize:ceil(12 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont systemFontOfSize:12];
        return font;
    } else {
        UIFont *font = [UIFont systemFontOfSize:12];
        return font;
    }
}
+ (UIFont *)normalFont5 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont systemFontOfSize:ceil(15 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont systemFontOfSize:15];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont systemFontOfSize:ceil(15 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont systemFontOfSize:15];
        return font;
    } else {
        UIFont *font = [UIFont systemFontOfSize:15];
        return font;
    }
}
+ (UIFont *)normalFont6 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont systemFontOfSize:ceil(18 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont systemFontOfSize:18];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont systemFontOfSize:ceil(18 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont systemFontOfSize:18];
        return font;
    } else {
        UIFont *font = [UIFont systemFontOfSize:18];
        return font;
    }
}
+ (UIFont *)normalFont7 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont systemFontOfSize:ceil(13 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont systemFontOfSize:13];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont systemFontOfSize:ceil(13 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont systemFontOfSize:13];
        return font;
    } else {
        UIFont *font = [UIFont systemFontOfSize:13];
        return font;
    }
}
+ (UIFont *)normalFont8 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont systemFontOfSize:ceil(10 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont systemFontOfSize:10];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont systemFontOfSize:ceil(10 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont systemFontOfSize:10];
        return font;
    } else {
        UIFont *font = [UIFont systemFontOfSize:10];
        return font;
    }
}
// 特效文字
+ (UIFont *)numberFont1 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont fontWithName:@"DINAlternate-Bold" size:ceil(63 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont fontWithName:@"DINAlternate-Bold" size:63];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont fontWithName:@"DINAlternate-Bold" size:ceil(63 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont fontWithName:@"DINAlternate-Bold" size:63];
        return font;
    } else {
        UIFont *font = [UIFont fontWithName:@"DINAlternate-Bold" size:63];
        return font;
    }
}
+ (UIFont *)numberFont2 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont fontWithName:@"DINAlternate-Bold" size:ceil(30 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont fontWithName:@"DINAlternate-Bold" size:30];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont fontWithName:@"DINAlternate-Bold" size:ceil(30 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont fontWithName:@"DINAlternate-Bold" size:30];
        return font;
    } else {
        UIFont *font = [UIFont fontWithName:@"DINAlternate-Bold" size:30];
        return font;
    }
}
+ (UIFont *)numberFont3 {
    if (ApplicationDelegate.myAppScreenModel == 1) {
        UIFont *font = [UIFont fontWithName:@"DINAlternate-Bold" size:ceil(59 * 320 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 2) {
        UIFont *font = [UIFont fontWithName:@"DINAlternate-Bold" size:59];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 3) {
        UIFont *font = [UIFont fontWithName:@"DINAlternate-Bold" size:ceil(59 * 414 / 375)];
        return font;
    } else if (ApplicationDelegate.myAppScreenModel == 4) {
        UIFont *font = [UIFont fontWithName:@"DINAlternate-Bold" size:59];
        return font;
    } else {
        UIFont *font = [UIFont fontWithName:@"DINAlternate-Bold" size:59];
        return font;
    }
}

//判断语言是否为中文
+ (BOOL)UIViewIsChinese{
    //系统语言
    NSString *appLanguage = [[NSString alloc] initWithString:[NSLocale preferredLanguages].firstObject];
    if ([appLanguage containsString:@"zh-Hans"]) {
        return YES;
    }
    return NO;
}


@end
