//
//  HTreatmentModel.m
//  PainKARE-TXB
//
//  Created by Anan on 2017/12/26.
//  Copyright © 2017年 Anan. All rights reserved.
//

#import "HTreatmentModel.h"

@implementation HTreatmentModel

+ (NSString *)getPositionWith:(int)index {
    switch (index) {
        case 0:
            return @"2001";
            break;
        case 1:
            return @"2002";
            break;
        case 2:
            return @"2013";
            break;
        case 3:
            return @"2003";
            break;
        case 4:
            return @"2008";
            break;
        case 5:
            return @"2009";
            break;
        case 6:
            return @"2010";
            break;
        case 7:
            return @"2011";
            break;
        case 8:
            return @"2012";
            break;
        default:
            return @"0";
            break;
    }
}

@end
