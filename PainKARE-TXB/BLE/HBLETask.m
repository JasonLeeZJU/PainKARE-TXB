//
//  HBLETask.m
//  PainKARE-TXB
//
//  Created by Anan on 2017/12/29.
//  Copyright © 2017年 Anan. All rights reserved.
//

#import "HBLETask.h"

@implementation HBLETask

- (id)initWithName:(NSString *)name andParameter:(id)per
{
    if (self = [super init]) {
        self.taskName = name;
        self.parameter = per;
    }
    return self;
}

@end
