//
//  HtreatmentLog.h
//  PainKARE-TXB
//
//  Created by Anan on 2018/1/24.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HtreatmentLog : NSObject

@property (strong, nonatomic) NSString *position;
@property (strong, nonatomic) NSString *symptom;
@property (strong, nonatomic) NSString *placement;
@property (strong, nonatomic) NSString *productId;
@property (strong, nonatomic) NSString *treatment_index;
@property (strong, nonatomic) NSString *start_time;
@property (assign, nonatomic) int duration;
@property (strong, nonatomic) NSString *user_id;

@property (assign, nonatomic) int log_stuta;    // 0: 设备自己开始的数据， 1: 手机设置进去的护理
/*  completion
    对于设备自己开始的数据 0: 未上传， 1: 已上传
    对于手机设置开始的数据 0: 未完成， 1: 已完成
 */
@property (assign, nonatomic) int completion;

@property (strong, nonatomic) NSArray *parameters_list;

@property (strong, nonatomic) NSMutableArray *resistance;
@property (strong, nonatomic) NSMutableArray *reactance;
@property (strong, nonatomic) NSMutableArray *phase;
@property (strong, nonatomic) NSMutableArray *intensity;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)provinceWithDictionary:(NSDictionary *)dict;

@end
