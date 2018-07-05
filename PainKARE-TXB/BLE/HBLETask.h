//
//  HBLETask.h
//  PainKARE-TXB
//
//  Created by Anan on 2017/12/29.
//  Copyright © 2017年 Anan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBLETask : NSObject

@property (strong, nonatomic) NSString *taskName;
@property (strong, nonatomic) id parameter;

- (id)initWithName:(NSString *)name andParameter:(id)per;

@end
