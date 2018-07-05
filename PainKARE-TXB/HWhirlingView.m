//
//  HWhirlingView.m
//  PainKARE-TXB
//
//  Created by Anan on 2018/1/5.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import "HWhirlingView.h"
#import "AppDelegate.h"
#import "HAppUIModel.h"

@implementation HWhirlingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        backgroundImageView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
        backgroundImageView.image = [UIImage imageNamed:@"circleBacground"];
        [self addSubview:backgroundImageView];
        
        UIImageView *circlePoint = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [HAppUIModel baseWidthChangeLength:23.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel], [HAppUIModel baseWidthChangeLength:23.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel])];
        circlePoint.center = CGPointMake(self.frame.size.width - 2, self.frame.size.height * 0.5);
        circlePoint.image = [UIImage imageNamed:@"circlePoint"];
        [self addSubview:circlePoint];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
