//
//  HtreatmentLog.m
//  PainKARE-TXB
//
//  Created by Anan on 2018/1/24.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import "HtreatmentLog.h"

@implementation HtreatmentLog

- (NSMutableArray *)resistance {
    if (!_resistance) {
        _resistance = [NSMutableArray array];
    }
    return _resistance;
}
- (NSMutableArray *)reactance {
    if (!_reactance) {
        _reactance = [NSMutableArray array];
    }
    return _reactance;
}
- (NSMutableArray *)phase {
    if (!_phase) {
        _phase = [NSMutableArray array];
    }
    return _phase;
}
- (NSMutableArray *)intensity {
    if (!_intensity) {
        _intensity = [NSMutableArray array];
    }
    return _intensity;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)provinceWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
