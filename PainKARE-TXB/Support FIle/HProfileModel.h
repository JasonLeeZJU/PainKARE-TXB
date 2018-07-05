//
//  HProfileModel.h
//  PainKARE-TXB
//
//  Created by Anan on 2018/2/6.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HProfileModel : NSObject

@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *height;
@property (strong, nonatomic) NSString *weight;
@property (strong, nonatomic) NSString *race;
@property (strong, nonatomic) NSString *age;
@property (strong, nonatomic) NSString *gender;
@property (assign, nonatomic) int pacemaker;

@property (strong, nonatomic) NSString *bloodType;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *mail;
@property (strong, nonatomic) NSString *health;

@end
