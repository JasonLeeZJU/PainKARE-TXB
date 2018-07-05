//
//  HTreatment_DetailChartView.h
//  PainKARE-TXB
//
//  Created by Anan on 2018/1/16.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTreatment_DetailChartView : UIView <UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray *resistanceArray;
@property (strong, nonatomic) NSMutableArray *reactanceArray;
@property (strong, nonatomic) NSMutableArray *phaseArray;

- (void)initWithView;

- (void)reloadChartView;

@end
