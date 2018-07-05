//
//  HMine_TreatmentLogViewController.m
//  PainKARE-TXB
//
//  Created by Anan on 2018/1/5.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import "HMine_TreatmentLogViewController.h"
#import "AppDelegate.h"
#import "HAppUIModel.h"
#import "HTreatmentModel.h"

#import "HTreatmentLogChartView.h"
#import "HMine_TreatmentLog_ResultViewController.h"
#import "HMine_TreatmentLog_DetailViewController.h"

@interface HMine_TreatmentLogViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@end

@implementation HMine_TreatmentLogViewController {
    NSCalendar *calendar;
    
    UIView *mine_TreatmentLogView;
    UITableView *mine_TreatmentLogTableView;
    UILabel *mine_TreatmentLogTipLabel;
    
    UIImageView *leftArrowImageView;
    UIImageView *rightArrowImageView;
    
    UIScrollView *positionSwitch;
    int positionSwitchPages;
    CGFloat positionSwitchOriginX;
    NSMutableArray *positionBtnArray;
    
    UIButton *threeTimesBtn;
    UIButton *sevenTimesBtn;
    UIButton *oneWeekBtn;
    UIButton *oneMonthBtn;
    
    HTreatmentLogChartView *TreatmentLogChartView;
    
    UIButton *resultButton;
    
    NSMutableArray *selectedTreatmentLog_List;
    CGFloat cellHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    cellHeight = [HAppUIModel baseLongChangeLength:67.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    positionBtnArray = [NSMutableArray array];
    selectedTreatmentLog_List = [NSMutableArray array];
    calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];// 指定日历的算法
    
    self.view.backgroundColor = [HAppUIModel whiteColor3];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationItem.title = NSLocalizedString(@"mine_TreatmentLogNavigationTitle", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[HAppUIModel titleFont2], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // 设置返回按钮
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc] init];
    backbutton.title = @"";
    self.navigationItem.backBarButtonItem = backbutton;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    mine_TreatmentLogView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_HEIGHT + 44)];
    mine_TreatmentLogView.backgroundColor = [HAppUIModel mainColor1];
    [self.view addSubview:mine_TreatmentLogView];
    
    mine_TreatmentLogTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    mine_TreatmentLogTipLabel.textColor = [HAppUIModel grayColor1];
    mine_TreatmentLogTipLabel.font = [HAppUIModel normalFont1];
    [mine_TreatmentLogTipLabel setTextAlignment:NSTextAlignmentCenter];
    mine_TreatmentLogTipLabel.text = @"一句话提示";
    mine_TreatmentLogTipLabel.alpha = 0;
    [mine_TreatmentLogView addSubview:mine_TreatmentLogTipLabel];
    
    [self createTopView];
    [self createSelectedPositionTableView];
}

- (void)createTopView {
    CGFloat radiusI = [HAppUIModel baseWidthChangeLength:5.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat borderWidthI = [HAppUIModel baseWidthChangeLength:1.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topViewHeight = [HAppUIModel baseLongChangeLength:270.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat chartViewHeight = [HAppUIModel baseLongChangeLength:170.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat arrowImageViewSideLength = [HAppUIModel baseWidthChangeLength:15.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topScrollViewWidth = [HAppUIModel baseWidthChangeLength:245.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topScrollViewHeight = [HAppUIModel baseLongChangeLength:30.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat positionBtnWidth = [HAppUIModel baseWidthChangeLength:20.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat positionBtnHeight = [HAppUIModel baseLongChangeLength:30.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    
    CGFloat horizontalSpaceI = [HAppUIModel baseWidthChangeLength:30.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat horizontalSpaceII = [HAppUIModel baseWidthChangeLength:45.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat horizontalSpaceIII = [HAppUIModel baseWidthChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat horizontalSpaceIV = [HAppUIModel baseWidthChangeLength:65.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat horizontalSpaceV = [HAppUIModel baseWidthChangeLength:122.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    
    CGFloat verticalSpaceI = [HAppUIModel baseLongChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat verticalSpaceII = [HAppUIModel baseLongChangeLength:26.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat verticalSpaceIII = [HAppUIModel baseLongChangeLength:2.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat verticalSpaceIV = [HAppUIModel baseLongChangeLength:32.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, STATUS_HEIGHT + 44 + verticalSpaceI, SCREEN_WIDTH , topViewHeight)];
    topView.backgroundColor = [HAppUIModel whiteColor4];
    [self.view addSubview:topView];
    
    // ——————————————————————————— 分析部位选择 ————————————————————————————————————————————
    leftArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, arrowImageViewSideLength, arrowImageViewSideLength)];
    leftArrowImageView.image = [UIImage imageNamed:@"smallLeftArrow"];
    leftArrowImageView.center = CGPointMake(horizontalSpaceI + arrowImageViewSideLength * 0.5, topScrollViewHeight * 0.5);
    [topView addSubview:leftArrowImageView];
    
    rightArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, arrowImageViewSideLength, arrowImageViewSideLength)];
    rightArrowImageView.image = [UIImage imageNamed:@"smallRightArrow"];
    rightArrowImageView.center = CGPointMake(SCREEN_WIDTH - horizontalSpaceI - arrowImageViewSideLength * 0.5, topScrollViewHeight * 0.5);
    [topView addSubview:rightArrowImageView];
    
    positionSwitch = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, topScrollViewWidth, topScrollViewHeight)];
    positionSwitch.center = CGPointMake(SCREEN_WIDTH * 0.5, topScrollViewHeight * 0.5);
    positionSwitch.delegate = self;
    //设置取消触摸
    positionSwitch.canCancelContentTouches = NO;
    //取消滑条
    [positionSwitch setShowsVerticalScrollIndicator:NO];
    [positionSwitch setShowsHorizontalScrollIndicator:NO];
    //是否自动裁剪超出部分
    positionSwitch.clipsToBounds = YES;
    //设置是否可以缩放
    positionSwitch.scrollEnabled = YES;
    //设置是否可以进行页面切换
    positionSwitch.pagingEnabled = NO;
    //设置在拖拽的时候是否锁定其在水平或垂直的方向
    positionSwitch.directionalLockEnabled = YES;
    //用来记录页数
    positionSwitchPages = 0;
    //用来记录ScrollView的X坐标
    positionSwitchOriginX = 0;
    
    for (NSDictionary *positionDic in ApplicationDelegate.positionList) {
        NSString *positionName = [positionDic valueForKey:@"name"];
        UIButton *positionBtn = [UIButton new];
        [positionBtn setTitle:positionName forState:UIControlStateNormal];
        positionBtn.titleLabel.font = [HAppUIModel normalFont2];
        [positionBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateSelected];
        [positionBtn setTitleColor:[HAppUIModel grayColor9] forState:UIControlStateNormal];
        [positionBtn setBackgroundColor:[UIColor clearColor]];
        
        CGSize positionBtnSize = [positionName sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
        positionBtnSize = CGSizeMake(ceilf(positionBtnSize.width), positionBtnHeight);
        positionBtn.frame = CGRectMake(positionSwitchOriginX, 0, positionBtnSize.width + positionBtnWidth, positionBtnHeight);
        [positionBtn addTarget:self action:@selector(positionSwitchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [positionSwitch addSubview:positionBtn];
        [positionBtnArray addObject:positionBtn];
        positionSwitchOriginX += positionBtnSize.width + positionBtnWidth;
        positionSwitchPages++;
    }
    [positionSwitch setContentSize:CGSizeMake(positionSwitchOriginX, 0)];
    [topView addSubview:positionSwitch];
    // —————————————————————————————————————————————————————————————————————————————————————
    
    // —————————————————————————————— 分析按钮 * 4 —————————————————————————————————————————————
    threeTimesBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, horizontalSpaceIV, verticalSpaceII)];
    [threeTimesBtn setTitle:NSLocalizedString(@"mine_TreatmentLogSelectThreeTimes", nil) forState:UIControlStateNormal];
    [threeTimesBtn setBackgroundColor:[UIColor clearColor]];
    threeTimesBtn.titleLabel.font = [HAppUIModel normalFont2];
    [threeTimesBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
    [threeTimesBtn.layer setCornerRadius:radiusI];
    [threeTimesBtn.layer setBorderColor:[HAppUIModel mainColor1].CGColor];
    [threeTimesBtn.layer setBorderWidth:borderWidthI];
    threeTimesBtn.center = CGPointMake(horizontalSpaceII + horizontalSpaceIV * 0.5, topScrollViewHeight + verticalSpaceIII + verticalSpaceII * 0.5);
    [threeTimesBtn addTarget:self action:@selector(threeTimesBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:threeTimesBtn];
    
    sevenTimesBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, horizontalSpaceIV, verticalSpaceII)];
    [sevenTimesBtn setTitle:NSLocalizedString(@"mine_TreatmentLogSelectSevenTimes", nil) forState:UIControlStateNormal];
    [sevenTimesBtn setBackgroundColor:[UIColor clearColor]];
    sevenTimesBtn.titleLabel.font = [HAppUIModel normalFont2];
    [sevenTimesBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
    [sevenTimesBtn.layer setCornerRadius:radiusI];
    [sevenTimesBtn.layer setBorderColor:[HAppUIModel mainColor1].CGColor];
    [sevenTimesBtn.layer setBorderWidth:borderWidthI];
    sevenTimesBtn.center = CGPointMake(horizontalSpaceII + horizontalSpaceIV * 1.5 + horizontalSpaceIII, topScrollViewHeight + verticalSpaceIII + verticalSpaceII * 0.5);
    [sevenTimesBtn addTarget:self action:@selector(sevenTimesBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:sevenTimesBtn];
    
    oneWeekBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, horizontalSpaceIV, verticalSpaceII)];
    [oneWeekBtn setTitle:NSLocalizedString(@"mine_TreatmentLogSelectOneWeek", nil) forState:UIControlStateNormal];
    [oneWeekBtn setBackgroundColor:[UIColor clearColor]];
    oneWeekBtn.titleLabel.font = [HAppUIModel normalFont2];
    [oneWeekBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
    [oneWeekBtn.layer setCornerRadius:radiusI];
    [oneWeekBtn.layer setBorderColor:[HAppUIModel mainColor1].CGColor];
    [oneWeekBtn.layer setBorderWidth:borderWidthI];
    oneWeekBtn.center = CGPointMake(horizontalSpaceII + horizontalSpaceIV * 2.5 + horizontalSpaceIII * 2, topScrollViewHeight + verticalSpaceIII + verticalSpaceII * 0.5);
    [oneWeekBtn addTarget:self action:@selector(oneWeekBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:oneWeekBtn];
    
    oneMonthBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, horizontalSpaceIV, verticalSpaceII)];
    [oneMonthBtn setTitle:NSLocalizedString(@"mine_TreatmentLogSelectOneMonth", nil) forState:UIControlStateNormal];
    [oneMonthBtn setBackgroundColor:[UIColor clearColor]];
    oneMonthBtn.titleLabel.font = [HAppUIModel normalFont2];
    [oneMonthBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
    [oneMonthBtn.layer setCornerRadius:radiusI];
    [oneMonthBtn.layer setBorderColor:[HAppUIModel mainColor1].CGColor];
    [oneMonthBtn.layer setBorderWidth:borderWidthI];
    oneMonthBtn.center = CGPointMake(horizontalSpaceII + horizontalSpaceIV * 3.5 + horizontalSpaceIII * 3, topScrollViewHeight + verticalSpaceIII + verticalSpaceII * 0.5);
    [oneMonthBtn addTarget:self action:@selector(oneMonthBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:oneMonthBtn];
    // ——————————————————————————————————————————————————————————————————————————————————————
    // ———————————————————————————— 曲线图 ——————————————————————————————————————————
    TreatmentLogChartView = [[HTreatmentLogChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, chartViewHeight)];
    TreatmentLogChartView.center = CGPointMake(SCREEN_WIDTH * 0.5, topScrollViewHeight + verticalSpaceIII + verticalSpaceII + verticalSpaceIII + chartViewHeight * 0.5);
    [TreatmentLogChartView initWithView];
    [topView addSubview:TreatmentLogChartView];
    // ————————————————————————————————————————————————————————————————————————————————
    // —————————————————————————————— 分析结果 ——————————————————————————————————————————————
    resultButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, horizontalSpaceV, verticalSpaceIV)];
    
    
    if ([HAppUIModel UIViewIsChinese] == YES){
        [resultButton setImage:[UIImage imageNamed:@"report"] forState:UIControlStateNormal];
    }
    else{
        [resultButton setImage:[UIImage imageNamed:@"reportEng"] forState:UIControlStateNormal];
    }
    
    
    resultButton.center = CGPointMake(horizontalSpaceI + horizontalSpaceV * 0.5, (topScrollViewHeight + verticalSpaceIII + verticalSpaceII + verticalSpaceIII + chartViewHeight + topViewHeight) * 0.5);
    [resultButton addTarget:self action:@selector(resultButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:resultButton];
    // ——————————————————————————————————————————————————————————————————————————————————————
}

- (void)createSelectedPositionTableView {
    CGFloat topViewHeight = [HAppUIModel baseLongChangeLength:270.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat verticalSpaceI = [HAppUIModel baseLongChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    
    mine_TreatmentLogTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_HEIGHT + 44 + verticalSpaceI + topViewHeight + verticalSpaceI, SCREEN_WIDTH, SCREEN_HEIGHT - (STATUS_HEIGHT + 44 + verticalSpaceI + topViewHeight + verticalSpaceI))];
    mine_TreatmentLogTableView.delegate = self;
    mine_TreatmentLogTableView.dataSource = self;
    [mine_TreatmentLogTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];   //取消 cell 之间的横线
    mine_TreatmentLogTableView.backgroundColor = [HAppUIModel whiteColor3];
    [mine_TreatmentLogTableView setShowsVerticalScrollIndicator:NO]; //取消滑条
    [self.view addSubview:mine_TreatmentLogTableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [selectedTreatmentLog_List count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifiter = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiter];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiter];
    }
    CGFloat imageViewSideLength = [HAppUIModel baseWidthChangeLength:13.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat rightArrowImageViewSideLength = [HAppUIModel baseWidthChangeLength:15.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    
    CGFloat horizontalSpaceI = [HAppUIModel baseWidthChangeLength:17.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat horizontalSpaceII = [HAppUIModel baseWidthChangeLength:7.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat horizontalSpaceIII = [HAppUIModel baseWidthChangeLength:15.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat horizontalSpaceIV = [HAppUIModel baseWidthChangeLength:228.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    
    CGFloat verticalSpaceI = [HAppUIModel baseLongChangeLength:15.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat verticalSpaceII = [HAppUIModel baseLongChangeLength:6.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIImageView *startTimeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageViewSideLength, imageViewSideLength)];
    startTimeImageView.image = [UIImage imageNamed:@"startTime"];
    startTimeImageView.center = CGPointMake(horizontalSpaceI + imageViewSideLength * 0.5, verticalSpaceI + imageViewSideLength * 0.5);
    [cell.contentView addSubview:startTimeImageView];
    
    UIImageView *durationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageViewSideLength, imageViewSideLength)];
    durationImageView.image = [UIImage imageNamed:@"duration"];
    durationImageView.center = CGPointMake(horizontalSpaceI + imageViewSideLength * 0.5, verticalSpaceI + verticalSpaceII + imageViewSideLength * 1.5);
    [cell.contentView addSubview:durationImageView];
    
    UILabel *startTimeLabel = [UILabel new];
    startTimeLabel.font = [HAppUIModel mediumFont5];
    startTimeLabel.textColor = [HAppUIModel grayColor3];
    startTimeLabel.text = NSLocalizedString(@"mine_TreatmentLogStartTime", nil);
    CGSize startTimeLabel_Size = [NSLocalizedString(@"mine_TreatmentLogStartTime", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel mediumFont5]}];
    startTimeLabel_Size = CGSizeMake(ceilf(startTimeLabel_Size.width), ceilf(startTimeLabel_Size.height));
    startTimeLabel.frame = CGRectMake(0, 0, startTimeLabel_Size.width, startTimeLabel_Size.height);
    startTimeLabel.center = CGPointMake(horizontalSpaceI + imageViewSideLength + horizontalSpaceII + startTimeLabel_Size.width * 0.5, verticalSpaceI + imageViewSideLength * 0.5);
    [cell.contentView addSubview:startTimeLabel];
    
    UILabel *durationLabel = [UILabel new];
    durationLabel.font = [HAppUIModel mediumFont5];
    durationLabel.textColor = [HAppUIModel grayColor3];
    durationLabel.text = NSLocalizedString(@"mine_TreatmentLogDuration", nil);
    CGSize durationLabel_Size = [NSLocalizedString(@"mine_TreatmentLogDuration", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel mediumFont5]}];
    durationLabel_Size = CGSizeMake(ceilf(durationLabel_Size.width), ceilf(durationLabel_Size.height));
    durationLabel.frame = CGRectMake(0, 0, durationLabel_Size.width, durationLabel_Size.height);
    durationLabel.center = CGPointMake(horizontalSpaceI + imageViewSideLength + horizontalSpaceII + durationLabel_Size.width * 0.5, verticalSpaceI + verticalSpaceII + imageViewSideLength * 1.5);
    [cell.contentView addSubview:durationLabel];
    
    NSString *gettedStartTimeDataString = [NSString stringWithFormat:@"%@", [[selectedTreatmentLog_List objectAtIndex:indexPath.row] valueForKey:@"start_time"]];
    NSLog(@"qwer %@", gettedStartTimeDataString);
    NSString *startTimeDataString = [gettedStartTimeDataString substringToIndex:16];
    UILabel *startTimeDataLabel = [UILabel new];
    startTimeDataLabel.font = [HAppUIModel mediumFont5];
    startTimeDataLabel.textColor = [HAppUIModel grayColor13];
    startTimeDataLabel.text = startTimeDataString;
    CGSize startTimeDataLabel_Size = [startTimeDataString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel mediumFont5]}];
    startTimeDataLabel_Size = CGSizeMake(ceilf(startTimeDataLabel_Size.width), ceilf(startTimeDataLabel_Size.height));
    startTimeDataLabel.frame = CGRectMake(0, 0, startTimeDataLabel_Size.width, startTimeDataLabel_Size.height);
    startTimeDataLabel.center = CGPointMake(horizontalSpaceI + imageViewSideLength + horizontalSpaceII + startTimeLabel_Size.width + startTimeDataLabel_Size.width * 0.5, verticalSpaceI + imageViewSideLength * 0.5);
    [cell.contentView addSubview:startTimeDataLabel];
    
    NSString *durationDataString = [NSString stringWithFormat:@"%@%@", [[selectedTreatmentLog_List objectAtIndex:indexPath.row] valueForKey:@"duration"], NSLocalizedString(@"mine_TreatmentLogMinute", nil)];
    UILabel *durationDataLabel = [UILabel new];
    durationDataLabel.font = [HAppUIModel mediumFont5];
    durationDataLabel.textColor = [HAppUIModel grayColor13];
    durationDataLabel.text = durationDataString;
    CGSize durationDataLabel_Size = [durationDataString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel mediumFont5]}];
    durationDataLabel_Size = CGSizeMake(ceilf(durationDataLabel_Size.width), ceilf(durationDataLabel_Size.height));
    durationDataLabel.frame = CGRectMake(0, 0, durationDataLabel_Size.width, durationDataLabel_Size.height);
    durationDataLabel.center = CGPointMake(horizontalSpaceI + imageViewSideLength + horizontalSpaceII + durationLabel_Size.width + durationDataLabel_Size.width * 0.5, verticalSpaceI + verticalSpaceII + imageViewSideLength * 1.5);
    [cell.contentView addSubview:durationDataLabel];
    
    UILabel *phaseLabel = [UILabel new];
    phaseLabel.font = [HAppUIModel mediumFont6];
    phaseLabel.textColor = [HAppUIModel grayColor6];
    phaseLabel.text = NSLocalizedString(@"mine_TreatmentLogPhase", nil);
    CGSize phaseLabel_Size = [NSLocalizedString(@"mine_TreatmentLogPhase", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel mediumFont6]}];
    phaseLabel_Size = CGSizeMake(ceilf(phaseLabel_Size.width), ceilf(phaseLabel_Size.height));
    phaseLabel.frame = CGRectMake(0, 0, phaseLabel_Size.width, phaseLabel_Size.height);
    phaseLabel.center = CGPointMake(horizontalSpaceIV + phaseLabel_Size.width * 0.5, cellHeight * 0.5);
    [cell.contentView addSubview:phaseLabel];
    
    NSArray *phaseDataArray = [NSArray arrayWithArray:[[selectedTreatmentLog_List objectAtIndex:indexPath.row] valueForKey:@"phase"]];
    CGFloat averageValue = [[phaseDataArray valueForKeyPath:@"@avg.floatValue"] floatValue];
    NSString *phaseDataString = [NSString stringWithFormat:@"%.f", averageValue];
    UILabel *phaseDataLabel = [UILabel new];
    phaseDataLabel.font = [HAppUIModel semiboldFont1];
    phaseDataLabel.textColor = [HAppUIModel orangeColor5];
    phaseDataLabel.text = phaseDataString;
    CGSize phaseDataLabel_Size = [phaseDataString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel semiboldFont1]}];
    phaseDataLabel_Size = CGSizeMake(ceilf(phaseDataLabel_Size.width), ceilf(phaseDataLabel_Size.height));
    phaseDataLabel.frame = CGRectMake(0, 0, phaseDataLabel_Size.width, phaseDataLabel_Size.height);
    phaseDataLabel.center = CGPointMake(horizontalSpaceIV + phaseLabel_Size.width + phaseDataLabel_Size.width * 0.5, cellHeight * 0.5);
    [cell.contentView addSubview:phaseDataLabel];
    
    UIImageView *rightArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rightArrowImageViewSideLength, rightArrowImageViewSideLength)];
    rightArrowImageView.image = [UIImage imageNamed:@"rightArrow"];
    rightArrowImageView.center = CGPointMake(SCREEN_WIDTH - horizontalSpaceIII - rightArrowImageViewSideLength * 0.5, cellHeight * 0.5);
    [cell.contentView addSubview:rightArrowImageView];
    
    cell.backgroundColor = [HAppUIModel whiteColor4];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [HAppUIModel baseLongChangeLength:11.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [HAppUIModel baseLongChangeLength:11.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel])];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 跳转页面
    HMine_TreatmentLog_DetailViewController *mine_TreatmentLog_DetailVC = [HMine_TreatmentLog_DetailViewController new];
    mine_TreatmentLog_DetailVC.selectedTreatmentLogDictionary = [selectedTreatmentLog_List objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:mine_TreatmentLog_DetailVC animated:YES];
    // 取消选中效果
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}
#pragma mark >>> 状态监测
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"水平或竖直方向拖动");
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"拖动结束Dragging");
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    NSLog(@"将要停止的时候调用");
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollView - offset.x = %ld", (long)scrollView.contentOffset.x);
}
#pragma mark >>> positionSwitch 按钮点击
- (void)positionSwitchButtonAction:(UIButton *)sender {
    NSLog(@">>> sender %@", sender.titleLabel.text);
    for (UIButton *positionBtn in positionBtnArray) {
        if (positionBtn == sender) {
            [positionBtn setSelected:YES];
            // 先清空获取的治疗记录
            [selectedTreatmentLog_List removeAllObjects];
            NSString *positionString = [HTreatmentModel getPositionWith:(int)[positionBtnArray indexOfObject:positionBtn]];
            NSLog(@">>> %@", positionString);
            for (NSDictionary *logDic in ApplicationDelegate.treatmentLogs) {
                if ([[logDic objectForKey:@"position"] isEqualToString:positionString]) {
                    [selectedTreatmentLog_List addObject:logDic];
                }
            }
            SLog(@">>> 要显示的治疗记录 %@", selectedTreatmentLog_List);
            [mine_TreatmentLogTableView reloadData];
            
            // 将所有phase求出平均值，再添加到数组中
            NSMutableArray *showPhaseArr = [NSMutableArray array];
            for (NSDictionary *dic in selectedTreatmentLog_List) {
                NSArray *phaseArray = [NSArray arrayWithArray:[dic valueForKey:@"phase"]];
                [showPhaseArr addObject:[phaseArray valueForKeyPath:@"@avg.floatValue"]];
            }
            
            [TreatmentLogChartView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            TreatmentLogChartView.selectedTreatmentLog_PhaseList = showPhaseArr;
            [TreatmentLogChartView reloadChartView];
            
            [threeTimesBtn setBackgroundColor:[UIColor clearColor]];
            [sevenTimesBtn setBackgroundColor:[UIColor clearColor]];
            [oneWeekBtn setBackgroundColor:[UIColor clearColor]];
            [oneMonthBtn setBackgroundColor:[UIColor clearColor]];
            
            [threeTimesBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
            [sevenTimesBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
            [oneWeekBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
            [oneMonthBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
        } else {
            [positionBtn setSelected:NO];
        }
    }
}
// ———————————————————— 分析按钮 * 4 ————————————————————————————————————————
- (void)threeTimesBtnAction:(UIButton *)sender {
    NSLog(@">>> threeTimesBtnAction");
    // ————————————————————- 处理操作 ——————————————————————————
    int selected_Count;
    if ([selectedTreatmentLog_List count] > 3) {
        selected_Count = 3;
    } else {
        selected_Count = (int)[selectedTreatmentLog_List count];
    }
    // 保存selectedTreatmentLog_List
    NSArray *saveLog_list = [NSArray arrayWithArray:selectedTreatmentLog_List];
    
    [selectedTreatmentLog_List removeAllObjects];
    for (int i = 0; i < selected_Count; i ++) {
        [selectedTreatmentLog_List addObject:[saveLog_list objectAtIndex:i]];
    }
    [mine_TreatmentLogTableView reloadData];
    // 将所有phase求出平均值，再添加到数组中
    NSMutableArray *showPhaseArr = [NSMutableArray array];
    for (NSDictionary *dic in selectedTreatmentLog_List) {
        NSArray *phaseArray = [NSArray arrayWithArray:[dic valueForKey:@"phase"]];
        [showPhaseArr addObject:[phaseArray valueForKeyPath:@"@avg.floatValue"]];
    }
    [TreatmentLogChartView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    TreatmentLogChartView.selectedTreatmentLog_PhaseList = showPhaseArr;
    [TreatmentLogChartView reloadChartView];
    
    // 结束将保存的selectedTreatmentLog_List重新返回
    [selectedTreatmentLog_List removeAllObjects];
    selectedTreatmentLog_List = [NSMutableArray arrayWithArray:saveLog_list];
    // ————————————————————————————————————————————————————————————
    [threeTimesBtn setBackgroundColor:[HAppUIModel mainColor1]];
    [sevenTimesBtn setBackgroundColor:[UIColor clearColor]];
    [oneWeekBtn setBackgroundColor:[UIColor clearColor]];
    [oneMonthBtn setBackgroundColor:[UIColor clearColor]];
    
    [threeTimesBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sevenTimesBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
    [oneWeekBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
    [oneMonthBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
}
- (void)sevenTimesBtnAction:(UIButton *)sender {
    NSLog(@">>> sevenTimesBtnAction");
    // ————————————————————- 处理操作 ——————————————————————————
    int selected_Count;
    if ([selectedTreatmentLog_List count] > 7) {
        selected_Count = 3;
    } else {
        selected_Count = (int)[selectedTreatmentLog_List count];
    }
    // 保存selectedTreatmentLog_List
    NSArray *saveLog_list = [NSArray arrayWithArray:selectedTreatmentLog_List];
    
    [selectedTreatmentLog_List removeAllObjects];
    for (int i = 0; i < selected_Count; i ++) {
        [selectedTreatmentLog_List addObject:[saveLog_list objectAtIndex:i]];
    }
    [mine_TreatmentLogTableView reloadData];
    // 将所有phase求出平均值，再添加到数组中
    NSMutableArray *showPhaseArr = [NSMutableArray array];
    for (NSDictionary *dic in selectedTreatmentLog_List) {
        NSArray *phaseArray = [NSArray arrayWithArray:[dic valueForKey:@"phase"]];
        [showPhaseArr addObject:[phaseArray valueForKeyPath:@"@avg.floatValue"]];
    }
    [TreatmentLogChartView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    TreatmentLogChartView.selectedTreatmentLog_PhaseList = showPhaseArr;
    [TreatmentLogChartView reloadChartView];
    
    // 结束将保存的selectedTreatmentLog_List重新返回
    [selectedTreatmentLog_List removeAllObjects];
    selectedTreatmentLog_List = [NSMutableArray arrayWithArray:saveLog_list];
    // ————————————————————————————————————————————————————————————
    [threeTimesBtn setBackgroundColor:[UIColor clearColor]];
    [sevenTimesBtn setBackgroundColor:[HAppUIModel mainColor1]];
    [oneWeekBtn setBackgroundColor:[UIColor clearColor]];
    [oneMonthBtn setBackgroundColor:[UIColor clearColor]];
    
    [threeTimesBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
    [sevenTimesBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [oneWeekBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
    [oneMonthBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
}
- (void)oneWeekBtnAction:(UIButton *)sender {
    NSLog(@">>> oneWeekBtnAction");
    // ————————————————————- 处理操作 ——————————————————————————
    // 保存selectedTreatmentLog_List
    NSArray *saveLog_list = [NSArray arrayWithArray:selectedTreatmentLog_List];
    
    [selectedTreatmentLog_List removeAllObjects];
    for (int i = 0; i < [saveLog_list count]; i ++) {
        NSDate *now = [NSDate date];
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // 年-月-日 时:分:秒
        // 这个格式可以随便定义,比如：@"yyyy,MM,dd,HH,mm,ss"
        NSString * dateStr = [[saveLog_list objectAtIndex:i] objectForKey:@"start_time"];
        NSDate * date = [formatter dateFromString:dateStr];
        NSDateComponents *comps = [calendar components:NSCalendarUnitDay fromDate:date toDate:now options:0];
        NSLog(@"comps %@", comps);
        if (comps.day < 7) {
            [selectedTreatmentLog_List addObject:[saveLog_list objectAtIndex:i]];
        }
    }
    [mine_TreatmentLogTableView reloadData];
    // 将所有phase求出平均值，再添加到数组中
    NSMutableArray *showPhaseArr = [NSMutableArray array];
    for (NSDictionary *dic in selectedTreatmentLog_List) {
        NSArray *phaseArray = [NSArray arrayWithArray:[dic valueForKey:@"phase"]];
        [showPhaseArr addObject:[phaseArray valueForKeyPath:@"@avg.floatValue"]];
    }
    [TreatmentLogChartView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    TreatmentLogChartView.selectedTreatmentLog_PhaseList = showPhaseArr;
    [TreatmentLogChartView reloadChartView];
    
    // 结束将保存的selectedTreatmentLog_List重新返回
    [selectedTreatmentLog_List removeAllObjects];
    selectedTreatmentLog_List = [NSMutableArray arrayWithArray:saveLog_list];
    // ————————————————————————————————————————————————————————————
    
    [threeTimesBtn setBackgroundColor:[UIColor clearColor]];
    [sevenTimesBtn setBackgroundColor:[UIColor clearColor]];
    [oneWeekBtn setBackgroundColor:[HAppUIModel mainColor1]];
    [oneMonthBtn setBackgroundColor:[UIColor clearColor]];
    
    [threeTimesBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
    [sevenTimesBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
    [oneWeekBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [oneMonthBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
}
- (void)oneMonthBtnAction:(UIButton *)sender {
    NSLog(@">>> oneMonthBtnAction");
    // ————————————————————- 处理操作 ——————————————————————————
    // 保存selectedTreatmentLog_List
    NSArray *saveLog_list = [NSArray arrayWithArray:selectedTreatmentLog_List];
    
    [selectedTreatmentLog_List removeAllObjects];
    for (int i = 0; i < [saveLog_list count]; i ++) {
        NSDate *now = [NSDate date];
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // 年-月-日 时:分:秒
        // 这个格式可以随便定义,比如：@"yyyy,MM,dd,HH,mm,ss"
        NSString * dateStr = [[saveLog_list objectAtIndex:i] objectForKey:@"start_time"];
        NSDate * date = [formatter dateFromString:dateStr];
        NSDateComponents *comps = [calendar components:NSCalendarUnitDay fromDate:date toDate:now options:0];
        NSLog(@"comps %@", comps);
        if (comps.day < 30) {
            [selectedTreatmentLog_List addObject:[saveLog_list objectAtIndex:i]];
        }
    }
    [mine_TreatmentLogTableView reloadData];
    // 将所有phase求出平均值，再添加到数组中
    NSMutableArray *showPhaseArr = [NSMutableArray array];
    for (NSDictionary *dic in selectedTreatmentLog_List) {
        NSArray *phaseArray = [NSArray arrayWithArray:[dic valueForKey:@"phase"]];
        [showPhaseArr addObject:[phaseArray valueForKeyPath:@"@avg.floatValue"]];
    }
    [TreatmentLogChartView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    TreatmentLogChartView.selectedTreatmentLog_PhaseList = showPhaseArr;
    [TreatmentLogChartView reloadChartView];
    
    // 结束将保存的selectedTreatmentLog_List重新返回
    [selectedTreatmentLog_List removeAllObjects];
    selectedTreatmentLog_List = [NSMutableArray arrayWithArray:saveLog_list];
    // ————————————————————————————————————————————————————————————
    [threeTimesBtn setBackgroundColor:[UIColor clearColor]];
    [sevenTimesBtn setBackgroundColor:[UIColor clearColor]];
    [oneWeekBtn setBackgroundColor:[UIColor clearColor]];
    [oneMonthBtn setBackgroundColor:[HAppUIModel mainColor1]];
    
    [threeTimesBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
    [sevenTimesBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
    [oneWeekBtn setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
    [oneMonthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
// ————————————————————————————————————————————————————————————————————————————

- (void)resultButtonAction:(UIButton *)sender {
    HMine_TreatmentLog_ResultViewController *mine_TreatmentLog_ResultVC = [HMine_TreatmentLog_ResultViewController new];
    [self.navigationController pushViewController:mine_TreatmentLog_ResultVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@">>> 进入 Mine - TreatmentLog");
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
