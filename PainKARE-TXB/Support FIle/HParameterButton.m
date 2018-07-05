//
//  HParameterButton.m
//  PainKARE-TXB
//
//  Created by Anan on 2018/1/22.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import "HParameterButton.h"

@implementation HParameterButton

- (NSDictionary *)parameterDic {
    if (!_parameterDic) {
        _parameterDic = [NSDictionary dictionary];
    }
    return _parameterDic;
}

@end
