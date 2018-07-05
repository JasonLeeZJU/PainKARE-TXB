//
//  HGradientColorView.m
//  PainKARE-TXB
//
//  Created by Anan on 2017/12/27.
//  Copyright © 2017年 Anan. All rights reserved.
//

#import "HGradientColorView.h"
#import "HAppUIModel.h"

@implementation HGradientColorView

- (void)drawRect:(CGRect)rect {
    // 渐变背景
    CAGradientLayer *backgroundGradientLayer = [CAGradientLayer layer];
    backgroundGradientLayer.colors = @[(__bridge id)[HAppUIModel changeBlueColor1].CGColor,
                                       (__bridge id)[HAppUIModel changeBlueColor2].CGColor,
                                       (__bridge id)[HAppUIModel changeBlueColor3].CGColor];
    backgroundGradientLayer.locations = @[@0.4, @0.7, @1.0];
    backgroundGradientLayer.startPoint = CGPointMake(1.0, 0);
    backgroundGradientLayer.endPoint = CGPointMake(0.0, 1.0);
    backgroundGradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    backgroundGradientLayer.cornerRadius = self.frame.size.width / 2;
    [self.layer addSublayer:backgroundGradientLayer];
    // 遮挡
    CGFloat diameter = self.frame.size.width - 8;
    UIView *blockedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, diameter, diameter)];
    blockedView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    blockedView.backgroundColor = [UIColor  whiteColor];
    [blockedView.layer setCornerRadius:diameter * 0.5];
    [self addSubview:blockedView];
    
    // 指针
    
}

@end
