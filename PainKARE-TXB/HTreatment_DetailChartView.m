//
//  HTreatment_DetailChartView.m
//  PainKARE-TXB
//
//  Created by Anan on 2018/1/16.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import "HTreatment_DetailChartView.h"
#import "AppDelegate.h"
#import "HAppUIModel.h"

@implementation HTreatment_DetailChartView {
    
    NSMutableArray *resistancePointsArray;
    NSMutableArray *reactancePointsArray;
    NSMutableArray *phasePointsArray;
    
    UIScrollView *chartScrollView;
    CAShapeLayer *dottedLineShapeLayer;
    UIImageView *resistanceImageView;
    UIImageView *reactanceImageView;
    UIImageView *phaseImageView;
    UIView *showView;;
    
    CGFloat lineWidth1;
    CGFloat lineWidth2;
    CGFloat lineWidth3;
    CGFloat lineOffset_Y;
    CGFloat lineShadowOpacity;
    
    CGFloat horizontalSpace1;
    CGFloat horizontalSpace2;
    CGFloat horizontalSpace3;
    CGFloat horizontalSpace4;
    CGFloat horizontalSpace5;
    CGFloat horizontalSpace6;
    CGFloat horizontalSpace7;
    CGFloat horizontalSpace8;
    CGFloat horizontalSpace9;
    CGFloat horizontalSpace10;
    
    CGFloat verticalSpace1;
    CGFloat verticalSpace2;
    CGFloat verticalSpace3;
    CGFloat verticalSpace4;
    CGFloat verticalSpace5;
    CGFloat verticalSpace6;
    CGFloat verticalSpace7;
    CGFloat verticalSpace8;
    CGFloat verticalSpace9;
    CGFloat verticalSpace10;
    CGFloat verticalSpace11;
    CGFloat verticalSpace12;
    
    CGFloat resistance_MAX_Y;
    CGFloat resistance_MIN_Y;
    CGFloat reactance_MAX_Y;
    CGFloat reactance_MIN_Y;
    CGFloat phase_MAX_Y;
    CGFloat phase_MIN_Y;
    
    CGFloat X_Axis_Width;
    int data_MAX_Count;
    
    NSMutableArray *shapeGraphList;
}

// ———————————————————————— 懒加载 ————————————————————————————————————
- (NSMutableArray *)resistanceArray {
    if (!_resistanceArray) {
        _resistanceArray = [NSMutableArray array];
    }
    return _resistanceArray;
}
- (NSMutableArray *)reactanceArray {
    if (!_reactanceArray) {
        _reactanceArray = [NSMutableArray array];
    }
    return _reactanceArray;
}
- (NSMutableArray *)phaseArray {
    if (!_phaseArray) {
        _phaseArray = [NSMutableArray array];
    }
    return _phaseArray;
}
// ————————————————————————————————————————————————————————————————————————

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        resistancePointsArray = [NSMutableArray array];
        reactancePointsArray = [NSMutableArray array];
        phasePointsArray = [NSMutableArray array];
        
        dottedLineShapeLayer = [CAShapeLayer layer];
        
        shapeGraphList = [NSMutableArray array];
        /*  测试
         self.resistanceArray = @[@(1012),@(1203),@(895),@(994),@(810),@(1006),@(914),@(948),@(1012),@(1203),@(895),@(994),@(810),@(1006),@(914),@(948)];
         self.reactanceArray = @[@(102),@(123),@(115),@(84),@(90),@(163),@(143),@(121),@(102),@(123),@(115),@(84),@(90),@(163),@(143),@(121)];
         self.phaseArray = @[@(12.4),@(3.7),@(5.8),@(4.4),@(10.8),@(6.1),@(14.8),@(10.7),@(12.2),@(3.5),@(8.6),@(4.5),@(10.5),@(6.5),@(14.2),@(10.0)];
         */
        
        lineWidth1 = [HAppUIModel baseWidthChangeLength:1.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        lineWidth2 = [HAppUIModel baseWidthChangeLength:2.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        lineWidth3 = [HAppUIModel baseWidthChangeLength:0.5f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        lineOffset_Y = [HAppUIModel baseWidthChangeLength:3.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        lineShadowOpacity = [HAppUIModel baseWidthChangeLength:10.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        
        horizontalSpace1 = [HAppUIModel baseWidthChangeLength:18.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        horizontalSpace2 = [HAppUIModel baseWidthChangeLength:2.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        horizontalSpace3 = [HAppUIModel baseWidthChangeLength:330.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];  // 折线图（ScrollView）宽度（画曲线图部分的宽度）
        horizontalSpace4 = [HAppUIModel baseWidthChangeLength:6.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        horizontalSpace5 = [HAppUIModel baseWidthChangeLength:12.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        horizontalSpace6 = [HAppUIModel baseWidthChangeLength:153.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        horizontalSpace7 = [HAppUIModel baseWidthChangeLength:9.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        horizontalSpace8 = [HAppUIModel baseWidthChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        horizontalSpace9 = [HAppUIModel baseWidthChangeLength:14.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        horizontalSpace10 = [HAppUIModel baseWidthChangeLength:24.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        
        verticalSpace1 = [HAppUIModel baseLongChangeLength:12.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        verticalSpace2 = [HAppUIModel baseLongChangeLength:6.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        verticalSpace3 = [HAppUIModel baseLongChangeLength:190.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        verticalSpace4 = [HAppUIModel baseLongChangeLength:222.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        verticalSpace5 = [HAppUIModel baseLongChangeLength:2.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        verticalSpace6 = [HAppUIModel baseLongChangeLength:184.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel]; // // 画曲线图部分的高度
        verticalSpace7 = [HAppUIModel baseLongChangeLength:10.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        verticalSpace8 = [HAppUIModel baseLongChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        verticalSpace9 = [HAppUIModel baseLongChangeLength:80.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        verticalSpace10 = [HAppUIModel baseLongChangeLength:3.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        verticalSpace11 = [HAppUIModel baseLongChangeLength:4.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        verticalSpace12 = [HAppUIModel baseLongChangeLength:5.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        
        X_Axis_Width = horizontalSpace3 / 9;
        
        resistanceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace5, horizontalSpace5)];
        reactanceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace5, horizontalSpace5)];
        phaseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace5, horizontalSpace5)];
    }
    return self;
}

- (void)initWithView {
    // 清空数据
    for (CAShapeLayer *shapeLayer in shapeGraphList) {
        [shapeLayer removeFromSuperlayer];
    }
    [shapeGraphList removeAllObjects];
    [resistancePointsArray removeAllObjects];
    [reactancePointsArray removeAllObjects];
    [phasePointsArray removeAllObjects];
    // 处理数据
    [self dataProcessing];
    // 画图
    [self createScrollShowView];    // 先画折线图，为了XY轴的悬浮
    [self createGraph];
    [self createScale];
    [self createXYAxis];
}

- (void)reloadChartView {
    // 清空数据
    for (CAShapeLayer *shapeLayer in shapeGraphList) {
        [shapeLayer removeFromSuperlayer];
    }
    [shapeGraphList removeAllObjects];
    
    [resistancePointsArray removeAllObjects];
    [reactancePointsArray removeAllObjects];
    [phasePointsArray removeAllObjects];
    // 处理数据
    [self dataProcessing];
    // 画图
    [self createGraph];
}

- (void)dataProcessing {
    // ——————————————————————————— resistance（血流阻力） ——————————————————————————————————————————————————
    resistance_MAX_Y = [[self.resistanceArray valueForKeyPath:@"@max.floatValue"] floatValue];
    int oneParagraph_Resistance_MAX_Y = ceil(resistance_MAX_Y / 100);
    resistance_MAX_Y = 100 * oneParagraph_Resistance_MAX_Y;
    NSLog(@">>> FIN resistance_MAX_Y %f", resistance_MAX_Y);
    resistance_MIN_Y = [[self.resistanceArray valueForKeyPath:@"@min.floatValue"] floatValue];
    int oneParagraph_resistance_MIN_Y = ceil(resistance_MIN_Y / 100);
    resistance_MIN_Y = 100 * (oneParagraph_resistance_MIN_Y - 1);
    if (resistance_MIN_Y < 0) {
        resistance_MIN_Y = 0;
    }
    NSLog(@">>> FIN resistance_MIN_Y %f", resistance_MIN_Y);
    // ————————————————————————————————————————————————————————————————————————————————————————————————————
    // ——————————————————————————— reactance（细胞活性） ——————————————————————————————————————————————————
    reactance_MAX_Y = [[self.reactanceArray valueForKeyPath:@"@max.floatValue"] floatValue];
    int oneParagraph_Reactance_MAX_Y = ceil(reactance_MAX_Y / 20);
    reactance_MAX_Y = 20 * oneParagraph_Reactance_MAX_Y;
    NSLog(@">>> FIN reactance_MAX_Y %f", reactance_MAX_Y);
    reactance_MIN_Y = [[self.reactanceArray valueForKeyPath:@"@min.floatValue"] floatValue];
    int oneParagraph_reactance_MIN_Y = ceil(reactance_MIN_Y / 20);
    reactance_MIN_Y = 20 * (oneParagraph_reactance_MIN_Y - 1);
    if (reactance_MIN_Y < 0) {
        reactance_MIN_Y = 0;
    }
    NSLog(@">>> FIN reactance_MIN_Y %f", reactance_MIN_Y);
    // ————————————————————————————————————————————————————————————————————————————————————————————————————
    // ——————————————————————————— phase（疼痛指数） ——————————————————————————————————————————————————
    phase_MAX_Y = [[self.phaseArray valueForKeyPath:@"@max.floatValue"] floatValue];
    int oneParagraph_phase_MAX_Y = ceil(phase_MAX_Y / 4);
    phase_MAX_Y = 4 * oneParagraph_phase_MAX_Y;
    NSLog(@">>> FIN phase_MAX_Y %f", phase_MAX_Y);
    phase_MIN_Y = [[self.phaseArray valueForKeyPath:@"@min.floatValue"] floatValue];
    int oneParagraph_phase_MIN_Y = ceil(phase_MIN_Y / 4);
    phase_MIN_Y = 4 * (oneParagraph_phase_MIN_Y - 1);
    if (phase_MIN_Y < 0) {
        phase_MIN_Y = 0;
    }
    NSLog(@">>> FIN phase_MIN_Y %f", phase_MIN_Y);
    // ————————————————————————————————————————————————————————————————————————————————————————————————————
    
    // ———————————————————————— 将所有数据转换为点 ————————————————————————————————————————————————————
    // resistance（血流阻力）
    for (int i = 0; i < [self.resistanceArray count]; i++) {
        int value_Y = [[NSString stringWithFormat:@"%@",[self.resistanceArray objectAtIndex:i]] intValue];
        CGPoint point;
        if (0 == resistance_MAX_Y - resistance_MIN_Y) {
            point = CGPointMake((i + 1) * X_Axis_Width , verticalSpace6 / 3 + verticalSpace6 / 3);
        } else {
            point = CGPointMake((i + 1) * X_Axis_Width , verticalSpace6 / 3 + verticalSpace6 / 3 * (1 - (value_Y - resistance_MIN_Y) / (resistance_MAX_Y - resistance_MIN_Y)));
        }
        NSValue *pointValue = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y)];
        [resistancePointsArray addObject:pointValue];
    }
    // reactance（细胞活性）
    for (int i = 0; i < [self.reactanceArray count]; i++) {
        int value_Y = [[NSString stringWithFormat:@"%@",[self.reactanceArray objectAtIndex:i]] intValue];
        CGPoint point;
        if (0 == reactance_MAX_Y - reactance_MIN_Y) {
            point = CGPointMake((i + 1) * X_Axis_Width , verticalSpace6 * 2 / 3 + verticalSpace6 / 3);
        } else {
            point = CGPointMake((i + 1) * X_Axis_Width , verticalSpace6 * 2 / 3 + verticalSpace6 / 3 * (1 - (value_Y - reactance_MIN_Y) / (reactance_MAX_Y - reactance_MIN_Y)));
        }
        NSValue *pointValue = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y)];
        [reactancePointsArray addObject:pointValue];
    }
    // phase（疼痛指数）
    for (int i = 0; i < [self.phaseArray count]; i++) {
        int value_Y = [[NSString stringWithFormat:@"%@",[self.phaseArray objectAtIndex:i]] intValue];
        CGPoint point;
        if (0 == phase_MAX_Y - phase_MIN_Y) {
            point = CGPointMake((i + 1) * X_Axis_Width , verticalSpace6 / 3);
        } else {
            point = CGPointMake((i + 1) * X_Axis_Width , verticalSpace6 / 3 * (1 - (value_Y - phase_MIN_Y) / (phase_MAX_Y - phase_MIN_Y)));
        }
        NSValue *pointValue = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y)];
        [phasePointsArray addObject:pointValue];
    }
    // —————————————————————————————————————————————————————————————————————————————————————————————————————
    
    // —————————————————————————————— 最大点的个数 ——————————————————————————————————————————————————
    NSArray *countArray = @[@([self.resistanceArray count]), @([self.reactanceArray count]), @([self.phaseArray count])];
    data_MAX_Count = [[countArray valueForKeyPath:@"@max.floatValue"] intValue];
    NSLog(@">>> data_MAX_Count %d", data_MAX_Count);
    // ——————————————————————————————————————————————————————————————————————————————————————————————————————
}

- (void)createXYAxis {
    // ———————————————————————————— Y轴 ——————————————————————————————————————————
    // 直线
    UIBezierPath * pathY1 = [UIBezierPath bezierPath];
    CAShapeLayer * shapeLayerY1 = [CAShapeLayer layer];
    [pathY1 moveToPoint:CGPointMake(horizontalSpace1, verticalSpace1)];
    [pathY1 addLineToPoint:CGPointMake(horizontalSpace1, verticalSpace1 + verticalSpace3)];
    shapeLayerY1.path = pathY1.CGPath;
    shapeLayerY1.strokeColor = [HAppUIModel grayColor10].CGColor;
    shapeLayerY1.fillColor = [[UIColor clearColor] CGColor];
    shapeLayerY1.lineWidth = lineWidth3;
    [self.layer addSublayer:shapeLayerY1];
    // 箭头
    UIBezierPath * pathY2 = [UIBezierPath bezierPath];
    CAShapeLayer * shapeLayerY2 = [CAShapeLayer layer];
    [pathY2 moveToPoint:CGPointMake(horizontalSpace1 - horizontalSpace2, verticalSpace1 + verticalSpace2)];
    [pathY2 addLineToPoint:CGPointMake(horizontalSpace1, verticalSpace1)];
    [pathY2 addLineToPoint:CGPointMake(horizontalSpace1 + horizontalSpace2, verticalSpace1 + verticalSpace2)];
    shapeLayerY2.path = pathY2.CGPath;
    shapeLayerY2.strokeColor = [HAppUIModel grayColor10].CGColor;
    shapeLayerY2.fillColor = [[UIColor clearColor] CGColor];
    shapeLayerY2.lineWidth = lineWidth3;
    [self.layer addSublayer:shapeLayerY2];
    // ——————————————————————————————————————————————————————————————————————————————————
    
    // ———————————————————————————— X轴 ———————————————————————————————————————————
    // 直线
    UIBezierPath * pathX1 = [UIBezierPath bezierPath];
    CAShapeLayer * shapeLayerX1 = [CAShapeLayer layer];
    [pathX1 moveToPoint:CGPointMake(horizontalSpace1, verticalSpace1 + verticalSpace3)];
    [pathX1 addLineToPoint:CGPointMake(horizontalSpace1 + lineWidth1 + horizontalSpace3 + horizontalSpace4, verticalSpace1 + verticalSpace3)];
    shapeLayerX1.path = pathX1.CGPath;
    shapeLayerX1.strokeColor = [HAppUIModel grayColor10].CGColor;
    shapeLayerX1.fillColor = [[UIColor clearColor] CGColor];
    shapeLayerX1.lineWidth = lineWidth3;
    [self.layer addSublayer:shapeLayerX1];
    // 箭头
    UIBezierPath * pathX2 = [UIBezierPath bezierPath];
    CAShapeLayer * shapeLayerX2 = [CAShapeLayer layer];
    [pathX2 moveToPoint:CGPointMake(horizontalSpace1 + lineWidth1 + horizontalSpace3 + horizontalSpace4 - horizontalSpace4, verticalSpace1 + verticalSpace3 - verticalSpace5)];
    [pathX2 addLineToPoint:CGPointMake(horizontalSpace1 + lineWidth1 + horizontalSpace3 + horizontalSpace4, verticalSpace1 + verticalSpace3)];
    [pathX2 addLineToPoint:CGPointMake(horizontalSpace1 + lineWidth1 + horizontalSpace3 + horizontalSpace4 - horizontalSpace4, verticalSpace1 + verticalSpace3 + verticalSpace5)];
    shapeLayerX2.path = pathX2.CGPath;
    shapeLayerX2.strokeColor = [HAppUIModel grayColor10].CGColor;
    shapeLayerX2.fillColor = [[UIColor clearColor] CGColor];
    shapeLayerX2.lineWidth = lineWidth3;
    [self.layer addSublayer:shapeLayerX2];
    // ——————————————————————————————————————————————————————————————————————————————————
}

- (void)createScrollShowView {
    chartScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(horizontalSpace1 + lineWidth1, verticalSpace1 + verticalSpace2, horizontalSpace3, verticalSpace4)];
    chartScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    chartScrollView.showsVerticalScrollIndicator = NO;
    chartScrollView.delegate = self;
    chartScrollView.clipsToBounds = YES;
    chartScrollView.directionalLockEnabled = YES;
    chartScrollView.pagingEnabled = NO;
    [chartScrollView setShowsHorizontalScrollIndicator:NO];
    [chartScrollView setShowsVerticalScrollIndicator:NO];
//    chartScrollView.backgroundColor = [UIColor greenColor];
    [chartScrollView setContentSize:CGSizeMake(X_Axis_Width * (data_MAX_Count + 1) + horizontalSpace6, 0)];
    
    //创建手势对象
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollViewTapAction:)];
    //配置属性
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [chartScrollView addGestureRecognizer:tap];
    
    showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace6, verticalSpace9)];
    showView.backgroundColor = [UIColor whiteColor];
    [showView.layer setMasksToBounds:YES];
    [showView.layer setCornerRadius:horizontalSpace8];
    [showView.layer setBorderWidth:lineWidth3];
    [showView.layer setBorderColor:[HAppUIModel grayColor19].CGColor];
    
    [self addSubview:chartScrollView];
}

- (void)createGraph {
    // ———————————————————————————— resistance（血流阻力） ————————————————————————————————————————————
    // 画图前先为画图添加数据（为了画曲线需要添加第一个点和最后一个点）
    NSMutableArray *resistanceGraphPointArray = [NSMutableArray arrayWithArray:resistancePointsArray];
    NSValue *resistanceFirstPointValue = [NSValue valueWithCGPoint:CGPointMake(0, verticalSpace3 / 2)];
    [resistanceGraphPointArray insertObject:resistanceFirstPointValue atIndex:0];
    NSValue *resistanceEndPointValue = [NSValue valueWithCGPoint:CGPointMake(0 + ([resistancePointsArray count] + 1) * X_Axis_Width, verticalSpace3 / 2)];
    [resistanceGraphPointArray addObject:resistanceEndPointValue];
    /** 折线路径 */
    UIBezierPath *resistancePathGraph = [UIBezierPath bezierPath];
    CAShapeLayer *resistanceShapeGraph = [CAShapeLayer layer];
    for (NSInteger i = 0; i < [resistanceGraphPointArray count] - 3; i++) {
        CGPoint p1 = [[resistanceGraphPointArray objectAtIndex:i] CGPointValue];
        CGPoint p2 = [[resistanceGraphPointArray objectAtIndex:i+1] CGPointValue];
        CGPoint p3 = [[resistanceGraphPointArray objectAtIndex:i+2] CGPointValue];
        CGPoint p4 = [[resistanceGraphPointArray objectAtIndex:i+3] CGPointValue];
        if (i == 0) {
            [resistancePathGraph moveToPoint:p2];
        }
        [self getControlPointx0:p1.x andy0:p1.y x1:p2.x andy1:p2.y x2:p3.x andy2:p3.y x3:p4.x andy3:p4.y path:resistancePathGraph];
    }
    /** 将折线添加到折线图层上，并设置相关的属性 */
    resistanceShapeGraph = [CAShapeLayer layer];
    resistanceShapeGraph.path = resistancePathGraph.CGPath;
    resistanceShapeGraph.strokeColor = [HAppUIModel purpleColor2].CGColor;
    resistanceShapeGraph.fillColor = [[UIColor clearColor] CGColor];
    // 默认设置路径宽度为0，使其在起始状态下不显示
    resistanceShapeGraph.lineWidth = lineWidth2;
    resistanceShapeGraph.lineCap = kCALineCapRound;
    resistanceShapeGraph.lineJoin = kCALineJoinRound;
    [resistanceShapeGraph setShadowOffset:CGSizeMake(0, 0)];
    [resistanceShapeGraph setShadowColor:[HAppUIModel purpleColor2].CGColor];
    [resistanceShapeGraph setShadowOpacity:lineShadowOpacity];
    [chartScrollView.layer addSublayer:resistanceShapeGraph];
    [shapeGraphList addObject:resistanceShapeGraph];
    // ——————————————————————————————————————————————————————————————————————————————————————————————————
    
    // ———————————————————————————— reactance（细胞活性） ————————————————————————————————————————————
    // 画图前先为画图添加数据（为了画曲线需要添加第一个点和最后一个点）
    NSMutableArray *reactanceGraphPointArray = [NSMutableArray arrayWithArray:reactancePointsArray];
    
    NSValue *reactanceFirstPointValue = [NSValue valueWithCGPoint:CGPointMake(0, verticalSpace3 * 5 / 6)];
    [reactanceGraphPointArray insertObject:reactanceFirstPointValue atIndex:0];
    NSValue *reactanceEndPointValue = [NSValue valueWithCGPoint:CGPointMake(0 + ([resistancePointsArray count] + 1) * X_Axis_Width, verticalSpace3 * 5 / 6)];
    [reactanceGraphPointArray addObject:reactanceEndPointValue];
    /** 折线路径 */
    UIBezierPath *reactancePathGraph = [UIBezierPath bezierPath];
    CAShapeLayer *reactanceShapeGraph = [CAShapeLayer layer];
    for (NSInteger i = 0; i < [reactanceGraphPointArray count] - 3; i++) {
        CGPoint p1 = [[reactanceGraphPointArray objectAtIndex:i] CGPointValue];
        CGPoint p2 = [[reactanceGraphPointArray objectAtIndex:i+1] CGPointValue];
        CGPoint p3 = [[reactanceGraphPointArray objectAtIndex:i+2] CGPointValue];
        CGPoint p4 = [[reactanceGraphPointArray objectAtIndex:i+3] CGPointValue];
        if (i == 0) {
            [reactancePathGraph moveToPoint:p2];
        }
        [self getControlPointx0:p1.x andy0:p1.y x1:p2.x andy1:p2.y x2:p3.x andy2:p3.y x3:p4.x andy3:p4.y path:reactancePathGraph];
    }
    /** 将折线添加到折线图层上，并设置相关的属性 */
    reactanceShapeGraph = [CAShapeLayer layer];
    reactanceShapeGraph.path = reactancePathGraph.CGPath;
    reactanceShapeGraph.strokeColor = [HAppUIModel greenColor2].CGColor;
    reactanceShapeGraph.fillColor = [[UIColor clearColor] CGColor];
    // 默认设置路径宽度为0，使其在起始状态下不显示
    reactanceShapeGraph.lineWidth = lineWidth2;
    reactanceShapeGraph.lineCap = kCALineCapRound;
    reactanceShapeGraph.lineJoin = kCALineJoinRound;
    [reactanceShapeGraph setShadowOffset:CGSizeMake(0, 0)];
    [reactanceShapeGraph setShadowColor:[HAppUIModel greenColor2].CGColor];
    [reactanceShapeGraph setShadowOpacity:lineShadowOpacity];
    [chartScrollView.layer addSublayer:reactanceShapeGraph];
    [shapeGraphList addObject:reactanceShapeGraph];
    // ——————————————————————————————————————————————————————————————————————————————————————————————————
    
    // ———————————————————————————— phase（疼痛指数） ————————————————————————————————————————————
    // 画图前先为画图添加数据（为了画曲线需要添加第一个点和最后一个点）
    NSMutableArray *phaseGraphPointArray = [NSMutableArray arrayWithArray:phasePointsArray];
    
    NSValue *phaseFirstPointValue = [NSValue valueWithCGPoint:CGPointMake(0, verticalSpace3 / 6)];
    [phaseGraphPointArray insertObject:phaseFirstPointValue atIndex:0];
    NSValue *phaseEndPointValue = [NSValue valueWithCGPoint:CGPointMake(0 + ([resistancePointsArray count] + 1) * X_Axis_Width, verticalSpace3 / 6)];
    [phaseGraphPointArray addObject:phaseEndPointValue];
    /** 折线路径 */
    UIBezierPath *phasePathGraph = [UIBezierPath bezierPath];
    CAShapeLayer *phaseShapeGraph = [CAShapeLayer layer];
    for (NSInteger i = 0; i < [phaseGraphPointArray count] - 3; i++) {
        CGPoint p1 = [[phaseGraphPointArray objectAtIndex:i] CGPointValue];
        CGPoint p2 = [[phaseGraphPointArray objectAtIndex:i+1] CGPointValue];
        CGPoint p3 = [[phaseGraphPointArray objectAtIndex:i+2] CGPointValue];
        CGPoint p4 = [[phaseGraphPointArray objectAtIndex:i+3] CGPointValue];
        if (i == 0) {
            [phasePathGraph moveToPoint:p2];
        }
        [self getControlPointx0:p1.x andy0:p1.y x1:p2.x andy1:p2.y x2:p3.x andy2:p3.y x3:p4.x andy3:p4.y path:phasePathGraph];
    }
    /** 将折线添加到折线图层上，并设置相关的属性 */
    phaseShapeGraph = [CAShapeLayer layer];
    phaseShapeGraph.path = phasePathGraph.CGPath;
    phaseShapeGraph.strokeColor = [HAppUIModel orangeColor3].CGColor;
    phaseShapeGraph.fillColor = [[UIColor clearColor] CGColor];
    // 默认设置路径宽度为0，使其在起始状态下不显示
    phaseShapeGraph.lineWidth = lineWidth2;
    phaseShapeGraph.lineCap = kCALineCapRound;
    phaseShapeGraph.lineJoin = kCALineJoinRound;
    [phaseShapeGraph setShadowOffset:CGSizeMake(0, 0)];
    [phaseShapeGraph setShadowColor:[HAppUIModel orangeColor3].CGColor];
    [phaseShapeGraph setShadowOpacity:lineShadowOpacity];
    [chartScrollView.layer addSublayer:phaseShapeGraph];
    [shapeGraphList addObject:phaseShapeGraph];
    // ——————————————————————————————————————————————————————————————————————————————————————————————————
}

- (void)createScale {
    for (int i = 0; i < data_MAX_Count; i++) {
        NSString *scaleString = [NSString stringWithFormat:@"%d", i * 5];
        UILabel *scaleLabel = [UILabel new];
        scaleLabel.font = [HAppUIModel mediumFont2];
        scaleLabel.textColor = [HAppUIModel grayColor16];
        scaleLabel.text = scaleString;
        CGSize scaleLabel_Size = [scaleString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel mediumFont2]}];
        scaleLabel_Size = CGSizeMake(ceilf(scaleLabel_Size.width), ceilf(scaleLabel_Size.height));
        scaleLabel.frame = CGRectMake(0, 0, scaleLabel_Size.width, scaleLabel_Size.height);
        scaleLabel.center = CGPointMake((i + 1) * X_Axis_Width, verticalSpace6 + verticalSpace7 + scaleLabel_Size.height * 0.5);
        [chartScrollView addSubview:scaleLabel];
        
    }
}

// 计算弧度
- (void)getControlPointx0:(CGFloat)x0 andy0:(CGFloat)y0
                       x1:(CGFloat)x1 andy1:(CGFloat)y1
                       x2:(CGFloat)x2 andy2:(CGFloat)y2
                       x3:(CGFloat)x3 andy3:(CGFloat)y3
                     path:(UIBezierPath*) path {
    CGFloat smooth_value = 0.6f;
    CGFloat ctrl1_x;
    CGFloat ctrl1_y;
    CGFloat ctrl2_x;
    CGFloat ctrl2_y;
    CGFloat xc1 = (x0 + x1) / 2.0;
    CGFloat yc1 = (y0 + y1) / 2.0;
    CGFloat xc2 = (x1 + x2) / 2.0;
    CGFloat yc2 = (y1 + y2) / 2.0;
    CGFloat xc3 = (x2 + x3) / 2.0;
    CGFloat yc3 = (y2 + y3) / 2.0;
    CGFloat len1 = sqrt((x1 - x0) * (x1 - x0) + (y1 - y0) * (y1 - y0));
    CGFloat len2 = sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
    CGFloat len3 = sqrt((x3 - x2) * (x3 - x2) + (y3 - y2) * (y3 - y2));
    CGFloat k1 = len1 / (len1 + len2);
    CGFloat k2 = len2 / (len2 + len3);
    CGFloat xm1 = xc1 + (xc2 - xc1) * k1;
    CGFloat ym1 = yc1 + (yc2 - yc1) * k1;
    CGFloat xm2 = xc2 + (xc3 - xc2) * k2;
    CGFloat ym2 = yc2 + (yc3 - yc2) * k2;
    ctrl1_x = xm1 + (xc2 - xm1) * smooth_value + x1 - xm1;
    ctrl1_y = ym1 + (yc2 - ym1) * smooth_value + y1 - ym1;
    ctrl2_x = xm2 + (xc2 - xm2) * smooth_value + x2 - xm2;
    ctrl2_y = ym2 + (yc2 - ym2) * smooth_value + y2 - ym2;
    [path addCurveToPoint:CGPointMake(x2, y2) controlPoint1:CGPointMake(ctrl1_x, ctrl1_y) controlPoint2:CGPointMake(ctrl2_x, ctrl2_y)];
}

// 触摸手势
- (void)scrollViewTapAction:(UITapGestureRecognizer *)tap {
    NSLog(@">>> scrollViewTapAction");
    // 消除上次视图
    [showView removeFromSuperview];
    [showView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [dottedLineShapeLayer removeFromSuperlayer];
    [resistanceImageView removeFromSuperview];
    [reactanceImageView removeFromSuperview];
    [phaseImageView removeFromSuperview];
    // 计算触摸位置
    CGPoint point = [tap locationInView:chartScrollView];
    NSLog(@">>> point.x %f -- point.y %f", point.x, point.y);
    CGFloat usefullWidh = point.x - X_Axis_Width * 0.5;
    if (usefullWidh < 0) {
        usefullWidh = 0;
    }
    CGFloat count = ceil(usefullWidh / X_Axis_Width);
    if (count > data_MAX_Count) {
        count = data_MAX_Count;
    }
    NSLog(@"count %f", count);
    CGPoint resistancePoint = [[resistancePointsArray objectAtIndex:(count -1)] CGPointValue];
    CGPoint reactancePoint = [[reactancePointsArray objectAtIndex:(count -1)] CGPointValue];
    CGPoint phasePoint = [[phasePointsArray objectAtIndex:(count -1)] CGPointValue];
    
    NSLog(@"resistancePoint:(%f, %f) reactancePoint(%f, %f) phasePoint(%f, %f)", resistancePoint.x, resistancePoint.y, reactancePoint.x, reactancePoint.y, phasePoint.x, phasePoint.y);
    
    // 虚线
    UIBezierPath * pathShow = [UIBezierPath bezierPath];
    [pathShow moveToPoint:CGPointMake(phasePoint.x, 0)];
    [pathShow addLineToPoint:CGPointMake(phasePoint.x, verticalSpace6)];
    [dottedLineShapeLayer setLineJoin:kCALineJoinRound];
    [dottedLineShapeLayer setLineDashPhase:2];
    dottedLineShapeLayer.path = pathShow.CGPath;
    [dottedLineShapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:verticalSpace8], [NSNumber numberWithInt:lineWidth1], nil]];
    dottedLineShapeLayer.strokeColor = [HAppUIModel grayColor17].CGColor;
    dottedLineShapeLayer.fillColor = [[UIColor clearColor] CGColor];
    [chartScrollView.layer addSublayer:dottedLineShapeLayer];
    // 圆点
    resistanceImageView.image = [UIImage imageNamed:@"purplePoint"];
    resistanceImageView.center = resistancePoint;
    [chartScrollView addSubview:resistanceImageView];
    reactanceImageView.image = [UIImage imageNamed:@"greenPoint"];
    reactanceImageView.center = reactancePoint;
    [chartScrollView addSubview:reactanceImageView];
    phaseImageView.image = [UIImage imageNamed:@"orangePoint"];
    phaseImageView.center = phasePoint;
    [chartScrollView addSubview:phaseImageView];
    
    // 重新设置位置
    showView.center = CGPointMake(phasePoint.x + horizontalSpace9 + horizontalSpace6 * 0.5, verticalSpace6 * 0.5);
    
    // 定时间label
    NSString *timeLabelString;
    if (0 >= count) {
        timeLabelString = [NSString stringWithFormat:@"%@%d%@", NSLocalizedString(@"treatment_DetailNumber", nil), 0, NSLocalizedString(@"treatment_DetailMinute", nil)];
    } else {
        timeLabelString = [NSString stringWithFormat:@"%@%.f%@", NSLocalizedString(@"treatment_DetailNumber", nil), (count - 1) * 5, NSLocalizedString(@"treatment_DetailMinute", nil)];
    }
    NSArray *timeArray = [timeLabelString componentsSeparatedByString:@"-"];
    NSLog(@"array:%@", timeArray);
    if (timeArray.count == 2) {
        timeLabelString = timeArray[1];
    }
    UILabel *timeLabel = [UILabel new];
    timeLabel.font = [HAppUIModel mediumFont8];
    timeLabel.textColor = [HAppUIModel grayColor18];
    timeLabel.text = timeLabelString;
    
    CGSize timeLabel_Size = [timeLabelString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel mediumFont8]}];
    timeLabel_Size = CGSizeMake(ceilf(timeLabel_Size.width), ceilf(timeLabel_Size.height));
    timeLabel.frame = CGRectMake(0, 0, timeLabel_Size.width, timeLabel_Size.height);
    timeLabel.center = CGPointMake(horizontalSpace7 + timeLabel_Size.width * 0.5, verticalSpace10 + timeLabel_Size.height * 0.5);
    [showView addSubview:timeLabel];
    
    // ———————————————————————————————————— 小圆点 ——————————————————————————————————————————————————————————————
    UIView *phasePointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace8, horizontalSpace8)];
    phasePointView.backgroundColor = [HAppUIModel orangeColor7];
    [phasePointView.layer setMasksToBounds:YES];
    [phasePointView.layer setCornerRadius:horizontalSpace8 * 0.5];
    phasePointView.center = CGPointMake(horizontalSpace7 + horizontalSpace8 * 0.5, verticalSpace10 + timeLabel_Size.height + verticalSpace12 + horizontalSpace8 * 0.5);
    [showView addSubview:phasePointView];
    
    UIView *resistancePointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace8, horizontalSpace8)];
    resistancePointView.backgroundColor = [HAppUIModel purpleColor4];
    [resistancePointView.layer setMasksToBounds:YES];
    [resistancePointView.layer setCornerRadius:horizontalSpace8 * 0.5];
    resistancePointView.center = CGPointMake(horizontalSpace7 + horizontalSpace8 * 0.5, verticalSpace10 + timeLabel_Size.height + verticalSpace12 + horizontalSpace8 * 1.5 + verticalSpace7);
    [showView addSubview:resistancePointView];
    
    UIView *reactancePointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace8, horizontalSpace8)];
    reactancePointView.backgroundColor = [HAppUIModel greenColor4];
    [reactancePointView.layer setMasksToBounds:YES];
    [reactancePointView.layer setCornerRadius:horizontalSpace8 * 0.5];
    reactancePointView.center = CGPointMake(horizontalSpace7 + horizontalSpace8 * 0.5, verticalSpace10 + timeLabel_Size.height + verticalSpace12 + horizontalSpace8 * 2.5 + verticalSpace7 * 2);
    [showView addSubview:reactancePointView];
    // ——————————————————————————————————————————————————————————————————————————————————————————————————————————————
    // ———————————————————————————————————————— 文字部分 ——————————————————————————————————————————————————————————
    
    NSString *phaseDataString = [NSString stringWithFormat:@"%.1f  %@", [[self.phaseArray objectAtIndex:(count - 1)] floatValue], NSLocalizedString(@"treatment_DetailPhase", nil)];
    NSArray *phaseArray = [phaseDataString componentsSeparatedByString:@"-"];
    NSLog(@"array:%@", phaseArray);
    if (phaseArray.count == 2) {
        phaseDataString = phaseArray[1];
    }
    UILabel *phaseDataLabel = [UILabel new];
    phaseDataLabel.font = [HAppUIModel normalFont8];
    phaseDataLabel.textColor = [HAppUIModel grayColor18];
    phaseDataLabel.text = phaseDataString;
    CGSize phaseDataLabel_Size = [phaseDataString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont8]}];
    phaseDataLabel_Size = CGSizeMake(ceilf(phaseDataLabel_Size.width), ceilf(phaseDataLabel_Size.height));
    phaseDataLabel.frame = CGRectMake(0, 0, phaseDataLabel_Size.width, phaseDataLabel_Size.height);
    phaseDataLabel.center = CGPointMake(horizontalSpace10 + phaseDataLabel_Size.width * 0.5, verticalSpace10 + timeLabel_Size.height + verticalSpace12 + horizontalSpace8 * 0.5);
    [showView addSubview:phaseDataLabel];
    
    NSString *resistanceDataString = [NSString stringWithFormat:@"%@  %@", [self.resistanceArray objectAtIndex:(count - 1)], NSLocalizedString(@"treatment_DetailResistance", nil)];
    UILabel *resistanceDataLabel = [UILabel new];
    resistanceDataLabel.font = [HAppUIModel normalFont8];
    resistanceDataLabel.textColor = [HAppUIModel grayColor18];
    resistanceDataLabel.text = resistanceDataString;
    CGSize resistanceDataLabel_Size = [resistanceDataString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont8]}];
    resistanceDataLabel_Size = CGSizeMake(ceilf(resistanceDataLabel_Size.width), ceilf(resistanceDataLabel_Size.height));
    resistanceDataLabel.frame = CGRectMake(0, 0, resistanceDataLabel_Size.width, resistanceDataLabel_Size.height);
    resistanceDataLabel.center = CGPointMake(horizontalSpace10 + resistanceDataLabel_Size.width * 0.5, verticalSpace10 + timeLabel_Size.height + verticalSpace12 + horizontalSpace8 * 1.5 + verticalSpace7);
    [showView addSubview:resistanceDataLabel];
    
    NSString *reactanceDataString = [NSString stringWithFormat:@"%@  %@", [self.reactanceArray objectAtIndex:(count - 1)], NSLocalizedString(@"treatment_DetailReactance", nil)];
    UILabel *reactanceDataLabel = [UILabel new];
    reactanceDataLabel.font = [HAppUIModel normalFont8];
    reactanceDataLabel.textColor = [HAppUIModel grayColor18];
    reactanceDataLabel.text = reactanceDataString;
    CGSize reactanceDataLabel_Size = [reactanceDataString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont8]}];
    reactanceDataLabel_Size = CGSizeMake(ceilf(reactanceDataLabel_Size.width), ceilf(reactanceDataLabel_Size.height));
    reactanceDataLabel.frame = CGRectMake(0, 0, reactanceDataLabel_Size.width, reactanceDataLabel_Size.height);
    reactanceDataLabel.center = CGPointMake(horizontalSpace10 + reactanceDataLabel_Size.width * 0.5, verticalSpace10 + timeLabel_Size.height + verticalSpace12 + horizontalSpace8 * 2.5 + verticalSpace7 * 2);
    [showView addSubview:reactanceDataLabel];
    // ————————————————————————————————————————————————————————————————————————————————————————————————————————————————
    //创建手势对象
    UITapGestureRecognizer *viewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapAction:)];
    //配置属性
    viewTap.numberOfTapsRequired = 1;
    viewTap.numberOfTouchesRequired = 1;
    [showView addGestureRecognizer:viewTap];
    [chartScrollView addSubview:showView];
}

- (void)viewTapAction:(UITapGestureRecognizer *)tap {
    // 消除上次视图
    NSLog(@">>> viewTapAction");
    [showView removeFromSuperview];
    [showView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [dottedLineShapeLayer removeFromSuperlayer];
    [resistanceImageView removeFromSuperview];
    [reactanceImageView removeFromSuperview];
    [phaseImageView removeFromSuperview];
}

@end
