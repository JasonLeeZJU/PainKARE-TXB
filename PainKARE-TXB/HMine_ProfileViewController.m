//
//  HMine_ProfileViewController.m
//  PainKARE-TXB
//
//  Created by Anan on 2018/1/18.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import "HMine_ProfileViewController.h"
#import "AppDelegate.h"
#import "HAppUIModel.h"
#import <AFNetworking/AFNetworking.h>

//#import "MBProgressHUD.h"
//#import "MBProgressHUD+MJ.h"

@interface HMine_ProfileViewController () <UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource,UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate>

@end

@implementation HMine_ProfileViewController {
    UIView *mine_ProfileView;
    UITableView *mine_ProfileTableView;
    UILabel *mine_ProfileTipLabel;
    
    UIButton *saveButton;
    
    UIImageView *heightImageView;
    UIImageView *weightImageView;
    UIImageView *raceImageView;
    UIImageView *ageImageView;
    UIImageView *genderImageView;
    UIImageView *pacemakerImageView;
    
//    UILabel *heightDataLabel;
//    UILabel *weightDataLabel;
    
    UITextField *heightDataTextField;
    UITextField *weightDataTextField;
    UITextField *phoneDataTextField;
    UITextField *mailDataTextField;
    UITextField *healthDataTextField;
    
    UILabel *raceDataLabel;
    UILabel *ageDataLabel;
    UILabel *genderDataLabel;
//    UILabel *pacemakerDataLabel;
    UILabel *bloodTypeDataLabel;
    
    UITextView *healthTextView;
    
    UIView *transparentView;
    UIView *clearView;
    
    UIPickerView *racePickerView;
    UIPickerView *agePickerView;
    UIPickerView *genderPickerView;
//    UIPickerView *pacemakerPickerView;
    UIPickerView *bloodTypePickerView;
    
    UIButton *leftSelectedButton;
    UIButton *rightSelectedButton;
    
    UIView *raceToolView;
    UIView *ageToolView;
    UIView *genderToolView;
//    UIView *pacemakerToolView;
    UIView *bloodTypeToolView;
    
    NSArray *raceList;
    NSArray *ageList;
    NSArray *genderList;
//    NSArray *pacemakerList;
    NSArray *bloodTypeList;
    
    int offsetStyle; // 0: 不偏移 1: 电话偏移 2: 邮箱偏移 3: 健康状况偏移
    
    NSString *heightDataString;
    NSString *weightDataString;
    NSString *raceDataString;
    NSString *ageDataString;
    NSString *genderDataString;
    NSString *pacemakerDataString;
    NSString *bloodTypeDataString;
    NSString *phoneDataString;
    NSString *mailDataString;
    NSString *healthDataString;
    
    // —————————— 适配 ————————————————————————————
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
    CGFloat horizontalSpace11;
    CGFloat horizontalSpace12;
    CGFloat horizontalSpace13;
    CGFloat horizontalSpace14;
    
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
    
    CGRect keyboardRect;
    // ————————————————————————————————————————————————
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 监听键盘开/关
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.view.backgroundColor = [HAppUIModel whiteColor3];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationItem.title = NSLocalizedString(@"mine_ProfileNavigationTitle", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[HAppUIModel titleFont2], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // ———————————— 数据处理 ————————————————————————————————
    
    offsetStyle = 0;
    
    raceList = @[NSLocalizedString(@"Profile_Race_Choice1", nil), NSLocalizedString(@"Profile_Race_Choice2", nil), NSLocalizedString(@"Profile_Race_Choice3", nil), NSLocalizedString(@"Profile_Race_Choice4", nil), NSLocalizedString(@"Profile_Race_Choice5", nil)];
    
    //ageList = @[@"4-14岁", @"15-22岁", @"23-39岁", @"40-55岁", @"55岁以上"];
    ageList = @[NSLocalizedString(@"Profile_Age_Choice1", nil), NSLocalizedString(@"Profile_Age_Choice2", nil), NSLocalizedString(@"Profile_Age_Choice3", nil), NSLocalizedString(@"Profile_Age_Choice4", nil), NSLocalizedString(@"Profile_Age_Choice5", nil)];
    
    //genderList = @[@"男人", @"女人"];
    genderList = @[NSLocalizedString(@"Profile_Gender_Choice1", nil), NSLocalizedString(@"Profile_Gender_Choice2", nil)];
                
//  pacemakerList = @[@"有", @"没有"];
    bloodTypeList = @[@"A", @"B", @"AB", @"O"];
    
    heightDataString = [NSString new];
    weightDataString = [NSString new];
    raceDataString = [NSString new];
    ageDataString = [NSString new];
    genderDataString = [NSString new];
    pacemakerDataString = [NSString new];
    bloodTypeDataString = [NSString new];
    phoneDataString = [NSString new];
    mailDataString = [NSString new];
    healthDataString = [NSString new];
    
    
    if (ApplicationDelegate.profile) {
        heightDataString = [NSString stringWithFormat:@"%@", [ApplicationDelegate.profile objectForKey:@"Height"]];
        weightDataString = [NSString stringWithFormat:@"%@", [ApplicationDelegate.profile objectForKey:@"Weight"]];
        raceDataString = [NSString stringWithFormat:@"%@", [ApplicationDelegate.profile objectForKey:@"Race"]];
        ageDataString = [NSString stringWithFormat:@"%@", [ApplicationDelegate.profile objectForKey:@"AgeGroup"]];
        genderDataString = [NSString stringWithFormat:@"%@", [ApplicationDelegate.profile objectForKey:@"Sex"]];
        pacemakerDataString = [NSString stringWithFormat:@"%@", [ApplicationDelegate.profile objectForKey:@"Pacemaker"]];
        if ([[ApplicationDelegate.profile objectForKey:@"Pacemaker"] intValue] == 0) {
            [rightSelectedButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        }
        if ([[ApplicationDelegate.profile objectForKey:@"Pacemaker"] intValue] == 1) {
            [leftSelectedButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        }
        bloodTypeDataString = [NSString stringWithFormat:@"%@", [ApplicationDelegate.profile objectForKey:@"BloodType"]];
        phoneDataString = [NSString stringWithFormat:@"%@", [ApplicationDelegate.profile objectForKey:@"Phone"]];
        mailDataString = [NSString stringWithFormat:@"%@", [ApplicationDelegate.profile objectForKey:@"Mail"]];
        healthDataString = [NSString stringWithFormat:@"%@", [ApplicationDelegate.profile objectForKey:@"Health"]];
    }
    
    horizontalSpace1 = [HAppUIModel baseWidthChangeLength:15.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace2 = [HAppUIModel baseWidthChangeLength:12.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace3 = [HAppUIModel baseWidthChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace4 = [HAppUIModel baseWidthChangeLength:329.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace5 = [HAppUIModel baseWidthChangeLength:33.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace6 = [HAppUIModel baseWidthChangeLength:19.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace7 = [HAppUIModel baseWidthChangeLength:60.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace8 = [HAppUIModel baseWidthChangeLength:120.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace9 = [HAppUIModel baseWidthChangeLength:235.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace10 = [HAppUIModel baseWidthChangeLength:315.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace11 = [HAppUIModel baseWidthChangeLength:30.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace12 = [HAppUIModel baseWidthChangeLength:271.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace13 = [HAppUIModel baseWidthChangeLength:351.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace14 = [HAppUIModel baseWidthChangeLength:345.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    
    verticalSpace1 = [HAppUIModel baseLongChangeLength:58.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace2 = [HAppUIModel baseLongChangeLength:11.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace3 = [HAppUIModel baseLongChangeLength:52.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace4 = [HAppUIModel baseLongChangeLength:24.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace5 = [HAppUIModel baseLongChangeLength:44.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace6 = [HAppUIModel baseLongChangeLength:219.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace7 = [HAppUIModel baseLongChangeLength:46.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace8 = [HAppUIModel baseLongChangeLength:100.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace9 = [HAppUIModel baseLongChangeLength:190.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace10 = [HAppUIModel baseLongChangeLength:56.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace11 = [HAppUIModel baseLongChangeLength:110.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    // —————————————————————————————————————————————————————————————————————————————————
    
    mine_ProfileTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_HEIGHT + 44, SCREEN_WIDTH, SCREEN_HEIGHT - (STATUS_HEIGHT + 44))];
    mine_ProfileTableView.delegate = self;
    mine_ProfileTableView.dataSource = self;
    [mine_ProfileTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];   // cell 之间的横线
    mine_ProfileTableView.backgroundColor = [HAppUIModel whiteColor3];
    [mine_ProfileTableView setShowsVerticalScrollIndicator:NO]; //取消滑条
    [self.view addSubview:mine_ProfileTableView];
    
    saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace4, verticalSpace3)];
    
    if ([HAppUIModel UIViewIsChinese] == YES){
        [saveButton setImage:[UIImage imageNamed:@"saveButton"] forState:UIControlStateNormal];
        [saveButton setImage:[UIImage imageNamed:@"saveButtonSelected"] forState:UIControlStateSelected];
        [saveButton setImage:[UIImage imageNamed:@"saveButtonDisable"] forState:UIControlStateDisabled];
    }
    else{
        [saveButton setImage:[UIImage imageNamed:@"saveButtonEng"] forState:UIControlStateNormal];
        [saveButton setImage:[UIImage imageNamed:@"saveButtonSelectedEng"] forState:UIControlStateSelected];
        [saveButton setImage:[UIImage imageNamed:@"saveButtonDisableEng"] forState:UIControlStateDisabled];
    }

    
    [saveButton setEnabled:NO];
    saveButton.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT - verticalSpace4 - verticalSpace3 * 0.5);
    [saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
    mine_ProfileView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_HEIGHT + 44)];
    mine_ProfileView.backgroundColor = [HAppUIModel mainColor1];
    [self.view addSubview:mine_ProfileView];
    
    // —————————————————————— 选择框（pickerView） ————————————————————————————————————————————
    // 透明背景
    [self createTransparentView];
    [self createClearViewView];
    //  ———————————————————————————————————— 种族 ——————————————————————————————————————
    raceToolView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - verticalSpace6 - verticalSpace7, SCREEN_WIDTH, verticalSpace7)];
    raceToolView.backgroundColor = [HAppUIModel whiteColor4];
//    [self.view addSubview:raceToolView];
    UIButton *raceCancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, verticalSpace7)];
    raceCancelButton.titleLabel.font = [HAppUIModel normalFont2];
    [raceCancelButton setTitle:NSLocalizedString(@"mine_ProfileCancel", nil) forState:UIControlStateNormal];
    [raceCancelButton setTitleColor:[HAppUIModel grayColor3] forState:UIControlStateNormal];
    CGSize raceCancelButton_Size = [NSLocalizedString(@"mine_ProfileCancel", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
    raceCancelButton_Size = CGSizeMake(ceilf(raceCancelButton_Size.width), ceilf(verticalSpace7));
    raceCancelButton.frame = CGRectMake(0, 0, raceCancelButton_Size.width, verticalSpace7);
    raceCancelButton.center = CGPointMake(horizontalSpace6 + raceCancelButton_Size.width * 0.5, verticalSpace7 * 0.5);
    [raceCancelButton addTarget:self action:@selector(raceCancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [raceToolView addSubview:raceCancelButton];
    
    UIButton *raceDoneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, verticalSpace7)];
    raceDoneButton.titleLabel.font = [HAppUIModel normalFont2];
    [raceDoneButton setTitle:NSLocalizedString(@"mine_ProfileDone", nil) forState:UIControlStateNormal];
    [raceDoneButton setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
    CGSize raceDoneButton_Size = [NSLocalizedString(@"mine_ProfileDone", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
    raceDoneButton_Size = CGSizeMake(ceilf(raceDoneButton_Size.width), ceilf(verticalSpace7));
    raceDoneButton.frame = CGRectMake(0, 0, raceDoneButton_Size.width, verticalSpace7);
    raceDoneButton.center = CGPointMake(SCREEN_WIDTH - (horizontalSpace6 + raceDoneButton_Size.width * 0.5), verticalSpace7 * 0.5);
    [raceDoneButton addTarget:self action:@selector(raceDoneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [raceToolView addSubview:raceDoneButton];

    racePickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - verticalSpace6, SCREEN_WIDTH, verticalSpace6)];
    racePickerView.dataSource = self;
    racePickerView.delegate = self;
    racePickerView.backgroundColor = [HAppUIModel whiteColor4];
//    [self.view addSubview:racePickerView];
    // ————————————————————————————————————————————————————————————————————————————————————————————
    
    //  ———————————————————————————————————— 年龄组 ——————————————————————————————————————
    ageToolView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - verticalSpace6 - verticalSpace7, SCREEN_WIDTH, verticalSpace7)];
    ageToolView.backgroundColor = [HAppUIModel whiteColor4];
    //    [self.view addSubview:raceToolView];
    UIButton *ageCancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, verticalSpace7)];
    ageCancelButton.titleLabel.font = [HAppUIModel normalFont2];
    [ageCancelButton setTitle:NSLocalizedString(@"mine_ProfileCancel", nil) forState:UIControlStateNormal];
    [ageCancelButton setTitleColor:[HAppUIModel grayColor3] forState:UIControlStateNormal];
    CGSize ageCancelButton_Size = [NSLocalizedString(@"mine_ProfileCancel", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
    ageCancelButton_Size = CGSizeMake(ceilf(ageCancelButton_Size.width), ceilf(verticalSpace7));
    ageCancelButton.frame = CGRectMake(0, 0, ageCancelButton_Size.width, verticalSpace7);
    ageCancelButton.center = CGPointMake(horizontalSpace6 + ageCancelButton_Size.width * 0.5, verticalSpace7 * 0.5);
    [ageCancelButton addTarget:self action:@selector(ageCancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [ageToolView addSubview:ageCancelButton];
    
    UIButton *ageDoneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, verticalSpace7)];
    ageDoneButton.titleLabel.font = [HAppUIModel normalFont2];
    [ageDoneButton setTitle:NSLocalizedString(@"mine_ProfileDone", nil) forState:UIControlStateNormal];
    [ageDoneButton setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
    CGSize ageDoneButton_Size = [NSLocalizedString(@"mine_ProfileDone", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
    ageDoneButton_Size = CGSizeMake(ceilf(ageDoneButton_Size.width), ceilf(verticalSpace7));
    ageDoneButton.frame = CGRectMake(0, 0, ageDoneButton_Size.width, verticalSpace7);
    ageDoneButton.center = CGPointMake(SCREEN_WIDTH - (horizontalSpace6 + ageDoneButton_Size.width * 0.5), verticalSpace7 * 0.5);
    [ageDoneButton addTarget:self action:@selector(ageDoneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [ageToolView addSubview:ageDoneButton];
    
    agePickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - verticalSpace6, SCREEN_WIDTH, verticalSpace6)];
    agePickerView.dataSource = self;
    agePickerView.delegate = self;
    agePickerView.backgroundColor = [HAppUIModel whiteColor4];
    //    [self.view addSubview:racePickerView];
    // ————————————————————————————————————————————————————————————————————————————————————————————
    
    //  ———————————————————————————————————— 性别 ——————————————————————————————————————
    genderToolView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - verticalSpace6 - verticalSpace7, SCREEN_WIDTH, verticalSpace7)];
    genderToolView.backgroundColor = [HAppUIModel whiteColor4];
    //    [self.view addSubview:raceToolView];
    UIButton *genderCancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, verticalSpace7)];
    genderCancelButton.titleLabel.font = [HAppUIModel normalFont2];
    [genderCancelButton setTitle:NSLocalizedString(@"mine_ProfileCancel", nil) forState:UIControlStateNormal];
    [genderCancelButton setTitleColor:[HAppUIModel grayColor3] forState:UIControlStateNormal];
    CGSize genderCancelButton_Size = [NSLocalizedString(@"mine_ProfileCancel", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
    genderCancelButton_Size = CGSizeMake(ceilf(genderCancelButton_Size.width), ceilf(verticalSpace7));
    genderCancelButton.frame = CGRectMake(0, 0, genderCancelButton_Size.width, verticalSpace7);
    genderCancelButton.center = CGPointMake(horizontalSpace6 + genderCancelButton_Size.width * 0.5, verticalSpace7 * 0.5);
    [genderCancelButton addTarget:self action:@selector(genderCancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [genderToolView addSubview:genderCancelButton];
    
    UIButton *genderDoneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, verticalSpace7)];
    genderDoneButton.titleLabel.font = [HAppUIModel normalFont2];
    [genderDoneButton setTitle:NSLocalizedString(@"mine_ProfileDone", nil) forState:UIControlStateNormal];
    [genderDoneButton setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
    CGSize genderDoneButton_Size = [NSLocalizedString(@"mine_ProfileDone", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
    genderDoneButton_Size = CGSizeMake(ceilf(genderDoneButton_Size.width), ceilf(verticalSpace7));
    genderDoneButton.frame = CGRectMake(0, 0, genderDoneButton_Size.width, verticalSpace7);
    genderDoneButton.center = CGPointMake(SCREEN_WIDTH - (horizontalSpace6 + genderDoneButton_Size.width * 0.5), verticalSpace7 * 0.5);
    [genderDoneButton addTarget:self action:@selector(genderDoneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [genderToolView addSubview:genderDoneButton];
    
    genderPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - verticalSpace6, SCREEN_WIDTH, verticalSpace6)];
    genderPickerView.dataSource = self;
    genderPickerView.delegate = self;
    genderPickerView.backgroundColor = [HAppUIModel whiteColor4];
    //    [self.view addSubview:racePickerView];
    // ————————————————————————————————————————————————————————————————————————————————————————————
    
    //  ———————————————————————————————————— 心脏起搏器 ——————————————————————————————————————
//    pacemakerToolView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - verticalSpace6 - verticalSpace7, SCREEN_WIDTH, verticalSpace7)];
//    pacemakerToolView.backgroundColor = [HAppUIModel whiteColor4];
    //    [self.view addSubview:raceToolView];
    
//    UIButton *pacemakerCancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, verticalSpace7)];
//    pacemakerCancelButton.titleLabel.font = [HAppUIModel normalFont2];
//    [pacemakerCancelButton setTitle:NSLocalizedString(@"mine_ProfileCancel", nil) forState:UIControlStateNormal];
//    [pacemakerCancelButton setTitleColor:[HAppUIModel grayColor3] forState:UIControlStateNormal];
//    CGSize pacemakerCancelButton_Size = [NSLocalizedString(@"mine_ProfileCancel", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
//    pacemakerCancelButton_Size = CGSizeMake(ceilf(pacemakerCancelButton_Size.width), ceilf(verticalSpace7));
//    pacemakerCancelButton.frame = CGRectMake(0, 0, pacemakerCancelButton_Size.width, verticalSpace7);
//    pacemakerCancelButton.center = CGPointMake(horizontalSpace6 + pacemakerCancelButton_Size.width * 0.5, verticalSpace7 * 0.5);
//    [pacemakerCancelButton addTarget:self action:@selector(pacemakerCancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [pacemakerToolView addSubview:pacemakerCancelButton];
    
//    UIButton *pacemakerDoneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, verticalSpace7)];
//    pacemakerDoneButton.titleLabel.font = [HAppUIModel normalFont2];
//    [pacemakerDoneButton setTitle:NSLocalizedString(@"mine_ProfileDone", nil) forState:UIControlStateNormal];
//    [pacemakerDoneButton setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
//    CGSize pacemakerDoneButton_Size = [NSLocalizedString(@"mine_ProfileDone", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
//    pacemakerDoneButton_Size = CGSizeMake(ceilf(pacemakerDoneButton_Size.width), ceilf(verticalSpace7));
//    pacemakerDoneButton.frame = CGRectMake(0, 0, pacemakerDoneButton_Size.width, verticalSpace7);
//    pacemakerDoneButton.center = CGPointMake(SCREEN_WIDTH - (horizontalSpace6 + pacemakerDoneButton_Size.width * 0.5), verticalSpace7 * 0.5);
//    [pacemakerDoneButton addTarget:self action:@selector(pacemakerDoneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [pacemakerToolView addSubview:pacemakerDoneButton];
    
//    pacemakerPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - verticalSpace6, SCREEN_WIDTH, verticalSpace6)];
//    pacemakerPickerView.dataSource = self;
//    pacemakerPickerView.delegate = self;
//    pacemakerPickerView.backgroundColor = [HAppUIModel whiteColor4];
    //    [self.view addSubview:racePickerView];
    // ————————————————————————————————————————————————————————————————————————————————————————————
    
    // ———————————————————————————————— 血型 ——————————————————————————————————————————
    bloodTypeToolView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - verticalSpace6 - verticalSpace7, SCREEN_WIDTH, verticalSpace7)];
    bloodTypeToolView.backgroundColor = [HAppUIModel whiteColor4];
    //    [self.view addSubview:raceToolView];
    UIButton *bloodTypeCancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, verticalSpace7)];
    bloodTypeCancelButton.titleLabel.font = [HAppUIModel normalFont2];
    [bloodTypeCancelButton setTitle:NSLocalizedString(@"mine_ProfileCancel", nil) forState:UIControlStateNormal];
    [bloodTypeCancelButton setTitleColor:[HAppUIModel grayColor3] forState:UIControlStateNormal];
    CGSize bloodTypeCancelButton_Size = [NSLocalizedString(@"mine_ProfileCancel", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
    bloodTypeCancelButton_Size = CGSizeMake(ceilf(bloodTypeCancelButton_Size.width), ceilf(verticalSpace7));
    bloodTypeCancelButton.frame = CGRectMake(0, 0, bloodTypeCancelButton_Size.width, verticalSpace7);
    bloodTypeCancelButton.center = CGPointMake(horizontalSpace6 + bloodTypeCancelButton_Size.width * 0.5, verticalSpace7 * 0.5);
    [bloodTypeCancelButton addTarget:self action:@selector(bloodTypeCancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bloodTypeToolView addSubview:bloodTypeCancelButton];
    
    UIButton *bloodTypeDoneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, verticalSpace7)];
    bloodTypeDoneButton.titleLabel.font = [HAppUIModel normalFont2];
    [bloodTypeDoneButton setTitle:NSLocalizedString(@"mine_ProfileDone", nil) forState:UIControlStateNormal];
    [bloodTypeDoneButton setTitleColor:[HAppUIModel mainColor1] forState:UIControlStateNormal];
    CGSize bloodTypeDoneButton_Size = [NSLocalizedString(@"mine_ProfileDone", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
    bloodTypeDoneButton_Size = CGSizeMake(ceilf(bloodTypeDoneButton_Size.width), ceilf(verticalSpace7));
    bloodTypeDoneButton.frame = CGRectMake(0, 0, bloodTypeDoneButton_Size.width, verticalSpace7);
    bloodTypeDoneButton.center = CGPointMake(SCREEN_WIDTH - (horizontalSpace6 + bloodTypeDoneButton_Size.width * 0.5), verticalSpace7 * 0.5);
    [bloodTypeDoneButton addTarget:self action:@selector(bloodTypeDoneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bloodTypeToolView addSubview:bloodTypeDoneButton];
    
    bloodTypePickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - verticalSpace6, SCREEN_WIDTH, verticalSpace6)];
    bloodTypePickerView.dataSource = self;
    bloodTypePickerView.delegate = self;
    bloodTypePickerView.backgroundColor = [HAppUIModel whiteColor4];
    // ————————————————————————————————————————————————————————————————————————————————————————————
    
    // ————————————————————————————————————————————————————————————————————————————————
}

// ———————————————————————————————— 透明 ——————————————————————————————————————————————————
- (void)createTransparentView {
    transparentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    transparentView.backgroundColor = [HAppUIModel transparentColor1];
    [ApplicationDelegate.window addSubview:transparentView];
    [transparentView setHidden:YES];
}

- (void)createClearViewView {
    clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    clearView.backgroundColor = [UIColor clearColor];
    [ApplicationDelegate.window addSubview:clearView];
    [clearView setHidden:YES];
    
    //创建手势对象
    UITapGestureRecognizer *viewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapAction:)];
    //配置属性
    viewTap.numberOfTapsRequired = 1;
    viewTap.numberOfTouchesRequired = 1;
    [clearView addGestureRecognizer:viewTap];
}

// 触摸动作
- (void)viewTapAction:(UITapGestureRecognizer *)tap {
    // 消除上次视图
    NSLog(@">>> profile - viewTapAction");
    [clearView setHidden:YES];
    [heightDataTextField resignFirstResponder];
    [weightDataTextField resignFirstResponder];
    [phoneDataTextField resignFirstResponder];
    [mailDataTextField resignFirstResponder];
    [healthTextView resignFirstResponder];
}
// ——————————————————————————————————————————————————————————————————————————————————————————————

// ———————————————————————————————— TableView ——————————————————————————————————————————————————————
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifiter = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiter];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiter];
    }
    // 清空视图
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.backgroundColor = [HAppUIModel whiteColor4];
        
        UILabel *heightLabel = [UILabel new];
        heightLabel.font = [HAppUIModel normalFont1];
        heightLabel.textColor = [HAppUIModel grayColor5];
        heightLabel.text = NSLocalizedString(@"mine_ProfileHeight", nil);
        CGSize heightLabel_Size = [NSLocalizedString(@"mine_ProfileHeight", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
        heightLabel_Size = CGSizeMake(ceilf(heightLabel_Size.width), ceilf(heightLabel_Size.height));
        heightLabel.frame = CGRectMake(0, 0, heightLabel_Size.width, heightLabel_Size.height);
        heightLabel.center = CGPointMake(horizontalSpace1 + heightLabel_Size.width * 0.5, verticalSpace1 * 0.5);
        [cell.contentView addSubview:heightLabel];
        
        heightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace2, horizontalSpace2)];
        heightImageView.image = [UIImage imageNamed:@"asterisk"];
        heightImageView.center = CGPointMake(horizontalSpace1 + heightLabel_Size.width + horizontalSpace3 + horizontalSpace2 * 0.5, verticalSpace1 * 0.5);
        [cell.contentView addSubview:heightImageView];
        
        heightDataTextField = [UITextField new];
        heightDataTextField.font = [HAppUIModel normalFont5];
        if ([heightDataString isEqualToString:@""] || heightDataString == nil) {
            heightDataTextField.textColor = [HAppUIModel grayColor22];
            heightDataTextField.text = NSLocalizedString(@"mine_ProfileEnter", nil);
        } else {
            heightDataTextField.textColor = [HAppUIModel grayColor3];
            heightDataTextField.text = heightDataString;
        }
        CGSize heightDataLabel_Size = [NSLocalizedString(@"mine_ProfileEnter", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont5]}];
        heightDataLabel_Size = CGSizeMake(ceilf(heightDataLabel_Size.width), ceilf(heightDataLabel_Size.height));
        heightDataTextField.frame = CGRectMake(0, 0, horizontalSpace8, heightDataLabel_Size.height);
        heightDataTextField.center = CGPointMake(SCREEN_WIDTH - horizontalSpace1 - horizontalSpace8 * 0.5, verticalSpace1 * 0.5);
        [heightDataTextField setTextAlignment:NSTextAlignmentRight];
        heightDataTextField.keyboardType = UIKeyboardTypeNumberPad;
        heightDataTextField.delegate = self;
        [cell.contentView addSubview:heightDataTextField];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.backgroundColor = [HAppUIModel whiteColor4];
        
        UILabel *weightLabel = [UILabel new];
        weightLabel.font = [HAppUIModel normalFont1];
        weightLabel.textColor = [HAppUIModel grayColor5];
        weightLabel.text = NSLocalizedString(@"mine_ProfileWeight", nil);
        CGSize weightLabel_Size = [NSLocalizedString(@"mine_ProfileWeight", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
        weightLabel_Size = CGSizeMake(ceilf(weightLabel_Size.width), ceilf(weightLabel_Size.height));
        weightLabel.frame = CGRectMake(0, 0, weightLabel_Size.width, weightLabel_Size.height);
        weightLabel.center = CGPointMake(horizontalSpace1 + weightLabel_Size.width * 0.5, verticalSpace1 * 0.5);
        [cell.contentView addSubview:weightLabel];
        
        weightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace2, horizontalSpace2)];
        weightImageView.image = [UIImage imageNamed:@"asterisk"];
        weightImageView.center = CGPointMake(horizontalSpace1 + weightLabel_Size.width + horizontalSpace3 + horizontalSpace2 * 0.5, verticalSpace1 * 0.5);
        [cell.contentView addSubview:weightImageView];
        
        weightDataTextField = [UITextField new];
        weightDataTextField.font = [HAppUIModel normalFont5];
        if ([weightDataString isEqualToString:@""] || weightDataString == nil) {
            weightDataTextField.textColor = [HAppUIModel grayColor22];
            weightDataTextField.text = NSLocalizedString(@"mine_ProfileEnter", nil);
        } else {
            weightDataTextField.textColor = [HAppUIModel grayColor3];
            weightDataTextField.text = weightDataString;
        }
        CGSize weightDataLabel_Size = [NSLocalizedString(@"mine_ProfileEnter", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont5]}];
        weightDataLabel_Size = CGSizeMake(ceilf(weightDataLabel_Size.width), ceilf(weightDataLabel_Size.height));
        weightDataTextField.frame = CGRectMake(0, 0, horizontalSpace8, weightDataLabel_Size.height);
        weightDataTextField.center = CGPointMake(SCREEN_WIDTH - horizontalSpace1 - horizontalSpace8 * 0.5, verticalSpace1 * 0.5);
        [weightDataTextField setTextAlignment:NSTextAlignmentRight];
        weightDataTextField.keyboardType = UIKeyboardTypeNumberPad;
        weightDataTextField.delegate = self;
        [cell.contentView addSubview:weightDataTextField];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        cell.backgroundColor = [HAppUIModel whiteColor4];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *raceLabel = [UILabel new];
        raceLabel.font = [HAppUIModel normalFont1];
        raceLabel.textColor = [HAppUIModel grayColor5];
        raceLabel.text = NSLocalizedString(@"mine_ProfileRace", nil);
        CGSize raceLabel_Size = [NSLocalizedString(@"mine_ProfileRace", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
        raceLabel_Size = CGSizeMake(ceilf(raceLabel_Size.width), ceilf(raceLabel_Size.height));
        raceLabel.frame = CGRectMake(0, 0, raceLabel_Size.width, raceLabel_Size.height);
        raceLabel.center = CGPointMake(horizontalSpace1 + raceLabel_Size.width * 0.5, verticalSpace1 * 0.5);
        [cell.contentView addSubview:raceLabel];
        
        raceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace2, horizontalSpace2)];
        raceImageView.image = [UIImage imageNamed:@"asterisk"];
        raceImageView.center = CGPointMake(horizontalSpace1 + raceLabel_Size.width + horizontalSpace3 + horizontalSpace2 * 0.5, verticalSpace1 * 0.5);
        [cell.contentView addSubview:raceImageView];
        
        raceDataLabel = [UILabel new];
        raceDataLabel.font = [HAppUIModel normalFont5];
        if ([raceDataString isEqualToString:@""] || raceDataString == nil) {
            raceDataLabel.textColor = [HAppUIModel grayColor22];
            raceDataLabel.text = NSLocalizedString(@"mine_ProfileChoose", nil);
        } else {
            raceDataLabel.textColor = [HAppUIModel grayColor3];
            raceDataLabel.text = raceDataString;
        }
        CGSize raceDataLabel_Size = [NSLocalizedString(@"mine_ProfileChoose", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont5]}];
        raceDataLabel_Size = CGSizeMake(ceilf(raceDataLabel_Size.width), ceilf(raceDataLabel_Size.height));
        raceDataLabel.frame = CGRectMake(0, 0, horizontalSpace8, raceDataLabel_Size.height);
        raceDataLabel.center = CGPointMake(SCREEN_WIDTH - horizontalSpace5 - horizontalSpace8 * 0.5, verticalSpace1 * 0.5);
        [raceDataLabel setTextAlignment:NSTextAlignmentRight];
        [cell.contentView addSubview:raceDataLabel];
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        cell.backgroundColor = [HAppUIModel whiteColor4];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *ageLabel = [UILabel new];
        ageLabel.font = [HAppUIModel normalFont1];
        ageLabel.textColor = [HAppUIModel grayColor5];
        ageLabel.text = NSLocalizedString(@"mine_ProfileAge", nil);
        CGSize ageLabel_Size = [NSLocalizedString(@"mine_ProfileAge", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
        ageLabel_Size = CGSizeMake(ceilf(ageLabel_Size.width), ceilf(ageLabel_Size.height));
        ageLabel.frame = CGRectMake(0, 0, ageLabel_Size.width, ageLabel_Size.height);
        ageLabel.center = CGPointMake(horizontalSpace1 + ageLabel_Size.width * 0.5, verticalSpace1 * 0.5);
        [cell.contentView addSubview:ageLabel];
        
        ageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace2, horizontalSpace2)];
        ageImageView.image = [UIImage imageNamed:@"asterisk"];
        ageImageView.center = CGPointMake(horizontalSpace1 + ageLabel_Size.width + horizontalSpace3 + horizontalSpace2 * 0.5, verticalSpace1 * 0.5);
        [cell.contentView addSubview:ageImageView];
        
        ageDataLabel = [UILabel new];
        ageDataLabel.font = [HAppUIModel normalFont5];
        if ([ageDataString isEqualToString:@""] || ageDataString == nil) {
            ageDataLabel.textColor = [HAppUIModel grayColor22];
            ageDataLabel.text = NSLocalizedString(@"mine_ProfileChoose", nil);
        } else {
            ageDataLabel.textColor = [HAppUIModel grayColor3];
            ageDataLabel.text = ageDataString;
        }
        CGSize ageDataLabel_Size = [NSLocalizedString(@"mine_ProfileChoose", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont5]}];
        ageDataLabel_Size = CGSizeMake(ceilf(ageDataLabel_Size.width), ceilf(ageDataLabel_Size.height));
        ageDataLabel.frame = CGRectMake(0, 0, horizontalSpace8, ageDataLabel_Size.height);
        ageDataLabel.center = CGPointMake(SCREEN_WIDTH - horizontalSpace5 - horizontalSpace8 * 0.5, verticalSpace1 * 0.5);
        [ageDataLabel setTextAlignment:NSTextAlignmentRight];
        [cell.contentView addSubview:ageDataLabel];
    }
    if (indexPath.section == 0 && indexPath.row == 4) {
        cell.backgroundColor = [HAppUIModel whiteColor4];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *genderLabel = [UILabel new];
        genderLabel.font = [HAppUIModel normalFont1];
        genderLabel.textColor = [HAppUIModel grayColor5];
        genderLabel.text = NSLocalizedString(@"mine_ProfileGender", nil);
        CGSize genderLabel_Size = [NSLocalizedString(@"mine_ProfileGender", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
        genderLabel_Size = CGSizeMake(ceilf(genderLabel_Size.width), ceilf(genderLabel_Size.height));
        genderLabel.frame = CGRectMake(0, 0, genderLabel_Size.width, genderLabel_Size.height);
        genderLabel.center = CGPointMake(horizontalSpace1 + genderLabel_Size.width * 0.5, verticalSpace1 * 0.5);
        [cell.contentView addSubview:genderLabel];
        
        genderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace2, horizontalSpace2)];
        genderImageView.image = [UIImage imageNamed:@"asterisk"];
        genderImageView.center = CGPointMake(horizontalSpace1 + genderLabel_Size.width + horizontalSpace3 + horizontalSpace2 * 0.5, verticalSpace1 * 0.5);
        [cell.contentView addSubview:genderImageView];
        
        genderDataLabel = [UILabel new];
        genderDataLabel.font = [HAppUIModel normalFont5];
        if ([genderDataString isEqualToString:@""] || genderDataString == nil) {
            genderDataLabel.textColor = [HAppUIModel grayColor22];
            genderDataLabel.text = NSLocalizedString(@"mine_ProfileChoose", nil);
        } else {
            genderDataLabel.textColor = [HAppUIModel grayColor3];
            genderDataLabel.text = genderDataString;
        }
        CGSize genderDataLabel_Size = [NSLocalizedString(@"mine_ProfileChoose", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont5]}];
        genderDataLabel_Size = CGSizeMake(ceilf(genderDataLabel_Size.width), ceilf(genderDataLabel_Size.height));
        genderDataLabel.frame = CGRectMake(0, 0, horizontalSpace8, genderDataLabel_Size.height);
        genderDataLabel.center = CGPointMake(SCREEN_WIDTH - horizontalSpace5 - horizontalSpace8 * 0.5, verticalSpace1 * 0.5);
        [genderDataLabel setTextAlignment:NSTextAlignmentRight];
        [cell.contentView addSubview:genderDataLabel];
    }
    if (indexPath.section == 0 && indexPath.row == 5) {
        cell.backgroundColor = [HAppUIModel whiteColor4];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *pacemakerLabel = [UILabel new];
        pacemakerLabel.font = [HAppUIModel normalFont1];
        pacemakerLabel.textColor = [HAppUIModel grayColor5];
        pacemakerLabel.text = NSLocalizedString(@"mine_ProfilePacemaker", nil);
        CGSize pacemakerLabel_Size = [NSLocalizedString(@"mine_ProfilePacemaker", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
        pacemakerLabel_Size = CGSizeMake(ceilf(pacemakerLabel_Size.width), ceilf(pacemakerLabel_Size.height));
        pacemakerLabel.frame = CGRectMake(0, 0, pacemakerLabel_Size.width, pacemakerLabel_Size.height);
        pacemakerLabel.center = CGPointMake(horizontalSpace1 + pacemakerLabel_Size.width * 0.5, verticalSpace1 * 0.5);
        [cell.contentView addSubview:pacemakerLabel];
        
        pacemakerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace2, horizontalSpace2)];
        pacemakerImageView.image = [UIImage imageNamed:@"asterisk"];
        pacemakerImageView.center = CGPointMake(horizontalSpace1 + pacemakerLabel_Size.width + horizontalSpace3 + horizontalSpace2 * 0.5, verticalSpace1 * 0.5);
        [cell.contentView addSubview:pacemakerImageView];
        
        UILabel *leftSelectedLabel = [UILabel new];
        leftSelectedLabel.font = [HAppUIModel normalFont5];
        leftSelectedLabel.textColor = [HAppUIModel grayColor3];
        leftSelectedLabel.text = NSLocalizedString(@"mine_ProfileLeftSelectedLabel", nil);
        CGSize leftSelectedLabel_Size = [NSLocalizedString(@"mine_ProfileLeftSelectedLabel", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont5]}];
        leftSelectedLabel_Size = CGSizeMake(ceilf(leftSelectedLabel_Size.width), ceilf(leftSelectedLabel_Size.height));
        leftSelectedLabel.frame = CGRectMake(0, 0, leftSelectedLabel_Size.width, leftSelectedLabel_Size.height);
        leftSelectedLabel.center = CGPointMake(horizontalSpace9 + leftSelectedLabel_Size.width * 0.5, verticalSpace1 * 0.5);
        [cell.contentView addSubview:leftSelectedLabel];
        
        UILabel *rightSelectedLabel = [UILabel new];
        rightSelectedLabel.font = [HAppUIModel normalFont5];
        rightSelectedLabel.textColor = [HAppUIModel grayColor3];
        rightSelectedLabel.text = NSLocalizedString(@"mine_ProfileRightSelectedLabel", nil);
        CGSize rightSelectedLabel_Size = [NSLocalizedString(@"mine_ProfileRightSelectedLabel", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont5]}];
        rightSelectedLabel_Size = CGSizeMake(ceilf(rightSelectedLabel_Size.width), ceilf(rightSelectedLabel_Size.height));
        rightSelectedLabel.frame = CGRectMake(0, 0, rightSelectedLabel_Size.width, rightSelectedLabel_Size.height);
        rightSelectedLabel.center = CGPointMake(horizontalSpace10 + rightSelectedLabel_Size.width * 0.5, verticalSpace1 * 0.5);
        [cell.contentView addSubview:rightSelectedLabel];
        
        leftSelectedButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace11, horizontalSpace11)];
        leftSelectedButton.center = CGPointMake(horizontalSpace12, verticalSpace1 * 0.5);
        [leftSelectedButton addTarget:self action:@selector(leftSelectedButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:leftSelectedButton];
        
        rightSelectedButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace11, horizontalSpace11)];
        rightSelectedButton.center = CGPointMake(horizontalSpace13, verticalSpace1 * 0.5);
        [rightSelectedButton addTarget:self action:@selector(rightSelectedButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:rightSelectedButton];
        
        if ([pacemakerDataString isEqualToString:@"0"]) {
            [leftSelectedButton setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
            [rightSelectedButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        } else if ([pacemakerDataString isEqualToString:@"1"]) {
            [leftSelectedButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
            [rightSelectedButton setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        } else {
            [leftSelectedButton setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
            [rightSelectedButton setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        }
        
//        pacemakerDataLabel = [UILabel new];
//        pacemakerDataLabel.font = [HAppUIModel normalFont5];
//        if ([pacemakerDataString isEqualToString:@""] || pacemakerDataString == nil) {
//            pacemakerDataLabel.textColor = [HAppUIModel grayColor22];
//            pacemakerDataLabel.text = NSLocalizedString(@"mine_ProfileChoose", nil);
//        } else {
//            pacemakerDataLabel.textColor = [HAppUIModel grayColor3];
//            pacemakerDataLabel.text = pacemakerDataString;
//        }
//        CGSize pacemakerDataLabel_Size = [NSLocalizedString(@"mine_ProfileChoose", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont5]}];
//        pacemakerDataLabel_Size = CGSizeMake(ceilf(pacemakerDataLabel_Size.width), ceilf(pacemakerDataLabel_Size.height));
//        pacemakerDataLabel.frame = CGRectMake(0, 0, horizontalSpace8, pacemakerDataLabel_Size.height);
//        pacemakerDataLabel.center = CGPointMake(SCREEN_WIDTH - horizontalSpace5 - horizontalSpace8 * 0.5, verticalSpace1 * 0.5);
//        [pacemakerDataLabel setTextAlignment:NSTextAlignmentRight];
//        [cell.contentView addSubview:pacemakerDataLabel];
    }
    if (indexPath.section == 0 && indexPath.row == 6) {
        cell.backgroundColor = [HAppUIModel whiteColor4];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *bloodTypeLabel = [UILabel new];
        bloodTypeLabel.font = [HAppUIModel normalFont1];
        bloodTypeLabel.textColor = [HAppUIModel grayColor5];
        bloodTypeLabel.text = NSLocalizedString(@"mine_ProfileBloodType", nil);
        CGSize bloodTypeLabel_Size = [NSLocalizedString(@"mine_ProfileBloodType", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
        bloodTypeLabel_Size = CGSizeMake(ceilf(bloodTypeLabel_Size.width), ceilf(bloodTypeLabel_Size.height));
        bloodTypeLabel.frame = CGRectMake(0, 0, bloodTypeLabel_Size.width, bloodTypeLabel_Size.height);
        bloodTypeLabel.center = CGPointMake(horizontalSpace1 + bloodTypeLabel_Size.width * 0.5, verticalSpace1 * 0.5);
        [cell.contentView addSubview:bloodTypeLabel];
        
        bloodTypeDataLabel = [UILabel new];
        bloodTypeDataLabel.font = [HAppUIModel normalFont5];
        if ([bloodTypeDataString isEqualToString:@""] || bloodTypeDataString == nil) {
            bloodTypeDataLabel.textColor = [HAppUIModel grayColor22];
            bloodTypeDataLabel.text = NSLocalizedString(@"mine_ProfileChoose", nil);
        } else {
            bloodTypeDataLabel.textColor = [HAppUIModel grayColor3];
            bloodTypeDataLabel.text = bloodTypeDataString;
        }
        CGSize bloodTypeDataLabel_Size = [NSLocalizedString(@"mine_ProfileChoose", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont5]}];
        bloodTypeDataLabel_Size = CGSizeMake(ceilf(bloodTypeDataLabel_Size.width), ceilf(bloodTypeDataLabel_Size.height));
        bloodTypeDataLabel.frame = CGRectMake(0, 0, horizontalSpace8, bloodTypeDataLabel_Size.height);
        bloodTypeDataLabel.center = CGPointMake(SCREEN_WIDTH - horizontalSpace5 - horizontalSpace8 * 0.5, verticalSpace1 * 0.5);
        [bloodTypeDataLabel setTextAlignment:NSTextAlignmentRight];
        [cell.contentView addSubview:bloodTypeDataLabel];
    }
    if (indexPath.section == 0 && indexPath.row == 7) {
        cell.backgroundColor = [HAppUIModel whiteColor4];
        
        UILabel *phoneLabel = [UILabel new];
        phoneLabel.font = [HAppUIModel normalFont1];
        phoneLabel.textColor = [HAppUIModel grayColor5];
        phoneLabel.text = NSLocalizedString(@"mine_ProfilePhone", nil);
        CGSize phoneLabel_Size = [NSLocalizedString(@"mine_ProfilePhone", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
        phoneLabel_Size = CGSizeMake(ceilf(phoneLabel_Size.width), ceilf(phoneLabel_Size.height));
        phoneLabel.frame = CGRectMake(0, 0, phoneLabel_Size.width, phoneLabel_Size.height);
        phoneLabel.center = CGPointMake(horizontalSpace1 + phoneLabel_Size.width * 0.5, verticalSpace1 * 0.5);
        [cell.contentView addSubview:phoneLabel];
        
        phoneDataTextField = [UITextField new];
        phoneDataTextField.font = [HAppUIModel normalFont5];
        if ([phoneDataString isEqualToString:@""] || phoneDataString == nil) {
            phoneDataTextField.textColor = [HAppUIModel grayColor22];
            phoneDataTextField.text = NSLocalizedString(@"mine_ProfileEnter", nil);
        } else {
            phoneDataTextField.textColor = [HAppUIModel grayColor3];
            phoneDataTextField.text = phoneDataString;
        }
        CGSize phoneDataTextField_Size = [NSLocalizedString(@"mine_ProfileEnter", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont5]}];
        phoneDataTextField_Size = CGSizeMake(ceilf(phoneDataTextField_Size.width), ceilf(phoneDataTextField_Size.height));
        phoneDataTextField.frame = CGRectMake(0, 0, horizontalSpace8, phoneDataTextField_Size.height);
        phoneDataTextField.center = CGPointMake(SCREEN_WIDTH - horizontalSpace1 - horizontalSpace8 * 0.5, verticalSpace1 * 0.5);
        [phoneDataTextField setTextAlignment:NSTextAlignmentRight];
        phoneDataTextField.keyboardType = UIKeyboardTypeNumberPad;
        phoneDataTextField.delegate = self;
        [cell.contentView addSubview:phoneDataTextField];
    }
    if (indexPath.section == 0 && indexPath.row == 8) {
        cell.backgroundColor = [HAppUIModel whiteColor4];
        
        UILabel *mailLabel = [UILabel new];
        mailLabel.font = [HAppUIModel normalFont1];
        mailLabel.textColor = [HAppUIModel grayColor5];
        mailLabel.text = NSLocalizedString(@"mine_ProfileMail", nil);
        CGSize mailLabel_Size = [NSLocalizedString(@"mine_ProfileMail", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
        mailLabel_Size = CGSizeMake(ceilf(mailLabel_Size.width), ceilf(mailLabel_Size.height));
        mailLabel.frame = CGRectMake(0, 0, mailLabel_Size.width, mailLabel_Size.height);
        mailLabel.center = CGPointMake(horizontalSpace1 + mailLabel_Size.width * 0.5, verticalSpace1 * 0.5);
        [cell.contentView addSubview:mailLabel];
        
        mailDataTextField = [UITextField new];
        mailDataTextField.font = [HAppUIModel normalFont5];
        if ([mailDataString isEqualToString:@""] || mailDataString == nil) {
            mailDataTextField.textColor = [HAppUIModel grayColor22];
            mailDataTextField.text = NSLocalizedString(@"mine_ProfileEnter", nil);
            CGSize mailDataTextField_Size = [NSLocalizedString(@"mine_ProfileEnter", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont5]}];
            mailDataTextField_Size = CGSizeMake(ceilf(mailDataTextField_Size.width), ceilf(mailDataTextField_Size.height));
            mailDataTextField.frame = CGRectMake(0, 0, horizontalSpace8, mailDataTextField_Size.height);
            mailDataTextField.center = CGPointMake(SCREEN_WIDTH - horizontalSpace1 - horizontalSpace8 * 0.5, verticalSpace1 * 0.5);
        } else {
            mailDataTextField.textColor = [HAppUIModel grayColor3];
            mailDataTextField.text = mailDataString;
            CGSize mailDataTextField_Size = [mailDataString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont5]}];
            mailDataTextField_Size = CGSizeMake(ceilf(mailDataTextField_Size.width), ceilf(mailDataTextField_Size.height));
            mailDataTextField.frame = CGRectMake(0, 0, mailDataTextField_Size.width, mailDataTextField_Size.height);
            mailDataTextField.center = CGPointMake(SCREEN_WIDTH - horizontalSpace1 - mailDataTextField_Size.width * 0.5, verticalSpace1 * 0.5);
        }
        [mailDataTextField setTextAlignment:NSTextAlignmentRight];
        mailDataTextField.keyboardType = UIKeyboardTypeASCIICapable;
        mailDataTextField.delegate = self;
        [cell.contentView addSubview:mailDataTextField];
    }
    if (indexPath.section == 0 && indexPath.row == 9) {
        cell.backgroundColor = [HAppUIModel whiteColor4];
        
        UILabel *healthLabel = [UILabel new];
        healthLabel.font = [HAppUIModel normalFont1];
        healthLabel.textColor = [HAppUIModel grayColor5];
        healthLabel.text = NSLocalizedString(@"mine_ProfileHealth", nil);
        CGSize healthLabel_Size = [NSLocalizedString(@"mine_ProfileHealth", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
        healthLabel_Size = CGSizeMake(ceilf(healthLabel_Size.width), ceilf(healthLabel_Size.height));
        healthLabel.frame = CGRectMake(0, 0, healthLabel_Size.width, healthLabel_Size.height);
        healthLabel.center = CGPointMake(horizontalSpace1 + healthLabel_Size.width * 0.5, verticalSpace1 * 0.5);
        [cell.contentView addSubview:healthLabel];
        
        healthTextView = [UITextView new];
        healthTextView.frame = CGRectMake(0, 0, horizontalSpace14, verticalSpace11);
        healthTextView.layer.cornerRadius = horizontalSpace3; //边框弧度
        healthTextView.layer.borderColor = [HAppUIModel grayColor24].CGColor; //设置边框颜色
        healthTextView.layer.borderWidth = 1; //边框宽度
        healthTextView.backgroundColor = [HAppUIModel whiteColor7];
        healthTextView.font = [HAppUIModel normalFont1];
        healthTextView.textColor = [HAppUIModel grayColor3];
        healthTextView.keyboardType = UIKeyboardTypeDefault;
        healthTextView.returnKeyType = UIReturnKeyDefault;
        healthTextView.delegate = self;
        if ([healthDataString isEqualToString:@""] || healthTextView == nil) {
            ;
        } else {
            healthTextView.text = healthDataString;
        }
        healthTextView.center = CGPointMake(SCREEN_WIDTH * 0.5, verticalSpace10 + verticalSpace11 * 0.5);
        [cell addSubview:healthTextView];
    }
    if (indexPath.section == 0 && indexPath.row == 10) {
        cell.backgroundColor = [UIColor clearColor];
    }
    
    // 取消选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 10) {
        return verticalSpace8;
    }
    if (indexPath.section == 0 && indexPath.row == 9) {
        return verticalSpace9;
    }
    return verticalSpace1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return verticalSpace2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, verticalSpace2)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return verticalSpace2;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, verticalSpace2)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        [heightDataTextField becomeFirstResponder];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        [weightDataTextField becomeFirstResponder];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        [transparentView setHidden:NO];
        [transparentView addSubview:raceToolView];
        [transparentView addSubview:racePickerView];
        if ([raceDataString isEqualToString:@""] || raceDataString == nil) {
            raceDataString = [raceList objectAtIndex:0];
        }
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        [transparentView setHidden:NO];
        [transparentView addSubview:ageToolView];
        [transparentView addSubview:agePickerView];
        if ([ageDataString isEqualToString:@""] || ageDataString == nil) {
            ageDataString = [ageList objectAtIndex:0];
        }
    }
    if (indexPath.section == 0 && indexPath.row == 4) {
        [transparentView setHidden:NO];
        [transparentView addSubview:genderToolView];
        [transparentView addSubview:genderPickerView];
        if ([genderDataString isEqualToString:@""] || genderDataString == nil) {
            genderDataString = [genderList objectAtIndex:0];
        }
    }
    if (indexPath.section == 0 && indexPath.row == 5) {
//        [transparentView setHidden:NO];
//        [transparentView addSubview:pacemakerToolView];
//        [transparentView addSubview:pacemakerPickerView];
//        pacemakerDataString = [pacemakerList objectAtIndex:0];
    }
    if (indexPath.section == 0 && indexPath.row == 6) {
        [transparentView setHidden:NO];
        [transparentView addSubview:bloodTypeToolView];
        [transparentView addSubview:bloodTypePickerView];
        if ([bloodTypeDataString isEqualToString:@""] || bloodTypeDataString == nil) {
            bloodTypeDataString = [bloodTypeList objectAtIndex:0];
        }
    }
    if (indexPath.section == 0 && indexPath.row == 7) {
        [phoneDataTextField becomeFirstResponder];
    }
    if (indexPath.section == 0 && indexPath.row == 8) {
        [mailDataTextField becomeFirstResponder];
    }
    if (indexPath.section == 0 && indexPath.row == 9) {
        [healthTextView becomeFirstResponder];
    }
}
// ———————————————————————————————————————————————————————————————————————————————————————————————————

// ———————————————————————— PickerView ——————————————————————————————————————————————————————————————
#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == racePickerView) {
        return [raceList count];
    }
    if (pickerView == agePickerView) {
        return [ageList count];
    }
    if (pickerView == genderPickerView) {
        return [genderList count];
    }
//    if (pickerView == pacemakerPickerView) {
//        return [pacemakerList count];
//    }
    if (pickerView == bloodTypePickerView) {
        return [bloodTypeList count];
    }
    return 0;
}
#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return SCREEN_WIDTH;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    if (pickerView == racePickerView) {
        return verticalSpace5;
    }
    if (pickerView == agePickerView) {
        return verticalSpace5;
    }
    if (pickerView == genderPickerView) {
        return verticalSpace5;
    }
//    if (pickerView == pacemakerPickerView) {
//        return verticalSpace5;
//    }
    if (pickerView == bloodTypePickerView) {
         return verticalSpace5;
    }
    return 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == racePickerView) {
        return [raceList objectAtIndex:row];
    }
    if (pickerView == agePickerView) {
        return [ageList objectAtIndex:row];
    }
    if (pickerView == genderPickerView) {
        return [genderList objectAtIndex:row];
    }
//    if (pickerView == pacemakerPickerView) {
//        return [pacemakerList objectAtIndex:row];
//    }
    if (pickerView == bloodTypePickerView) {
        return [bloodTypeList objectAtIndex:row];
    }
    return nil;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == racePickerView) {
        NSLog(@">>> %@", [raceList objectAtIndex:row]);
        raceDataString = [raceList objectAtIndex:row];
    }
    if (pickerView == agePickerView) {
        NSLog(@">>> %@", [ageList objectAtIndex:row]);
        ageDataString = [ageList objectAtIndex:row];
    }
    if (pickerView == genderPickerView) {
        NSLog(@">>> %@", [genderList objectAtIndex:row]);
        genderDataString = [genderList objectAtIndex:row];
    }
//    if (pickerView == pacemakerPickerView) {
//        NSLog(@">>> %@", [pacemakerList objectAtIndex:row]);
//        pacemakerDataString = [pacemakerList objectAtIndex:row];
//    }
    if (pickerView == bloodTypePickerView) {
        NSLog(@">>> %@", [bloodTypeList objectAtIndex:row]);
        bloodTypeDataString = [bloodTypeList objectAtIndex:row];
    }
}
// 重写PickerView
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[HAppUIModel normalFont1]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
// ———————————————————————————————————————————————————————————————————————————————————————————————————————————————

// ———————————————————————————————————— TextFile ————————————————————————————————————————————————————————————
// 开始输入
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [clearView setHidden:NO];
    if (textField == heightDataTextField) {
        [heightDataTextField setText:@""];
        heightDataTextField.textColor = [HAppUIModel grayColor3];
    }
    if (textField == weightDataTextField) {
        [weightDataTextField setText:@""];
        weightDataTextField.textColor = [HAppUIModel grayColor3];
    }
    if (textField == phoneDataTextField) {
        [phoneDataTextField setText:@""];
        phoneDataTextField.textColor = [HAppUIModel grayColor3];
        offsetStyle = 1;
    }
    if (textField == mailDataTextField) {
        [mailDataTextField setText:@""];
        mailDataTextField.textColor = [HAppUIModel grayColor3];
        offsetStyle = 2;
    }
}
// 每次输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == heightDataTextField || textField == weightDataTextField) {
        //杜绝出现00，01等情况
        if(range.location == 1 && [textField.text isEqualToString:@"0"]&&![string isEqualToString:@"."]) {
            textField.text = @"";
            return YES;
        }
        //删除空格
        NSInteger stringLength = [textField.text length];
        if([string isEqualToString:@""]) {
            return YES;
        }
        if ([string isEqualToString:@" "]) {
            return NO;
        }
        //保证小数点后只有一位
        NSRange netRange = [textField.text rangeOfString:@"."];
        if (netRange.location != NSNotFound)
        {
            if([string isEqualToString:@"."]) {
                return NO;
            }
            if((range.location - netRange.location) >= 2) {
                return NO;
            }
        }
        //根据最大值保证数字位数
        if(textField == heightDataTextField) {
            if(stringLength >= 3) {
                return NO;
            }
        }
        if(textField == weightDataTextField) {
            if(stringLength >= 3) {
                return NO;
            }
        }
    }
    if (textField == phoneDataTextField) {
        NSInteger stringLength = [textField.text length];
        if([string isEqualToString:@""]) {
            return YES;
        }
        if ([string isEqualToString:@" "]) {
            return NO;
        }
        if(stringLength >= 11) {
            return NO;
        }
    }
    if (textField == mailDataTextField) {
        NSInteger stringLength = [textField.text length];
        NSString *mailString = [NSString stringWithFormat:@"%@ ",textField.text];
        CGSize mailDataTextField_Size = [mailString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont5]}];
        mailDataTextField_Size = CGSizeMake(ceilf(mailDataTextField_Size.width), ceilf(mailDataTextField_Size.height));
        mailDataTextField.frame = CGRectMake(0, 0, mailDataTextField_Size.width, mailDataTextField_Size.height);
        mailDataTextField.center = CGPointMake(SCREEN_WIDTH - horizontalSpace1 - mailDataTextField_Size.width * 0.5, verticalSpace1 * 0.5);
        if([string isEqualToString:@""]) {
            return YES;
        }
        if ([string isEqualToString:@" "]) {
            return NO;
        }
        if(stringLength >= 50) {
            return NO;
        }
    }
    return YES;
}
// 结束输入
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSInteger stringLength = [textField.text length];
    if(textField == heightDataTextField) {
        if(stringLength == 0) {
            [heightDataTextField setText:NSLocalizedString(@"mine_ProfileEnter", nil)];
            heightDataTextField.textColor = [HAppUIModel grayColor22];
        } else {
            heightDataString = textField.text;
        }
    }
    if(textField == weightDataTextField) {
        if(stringLength == 0) {
            [weightDataTextField setText:NSLocalizedString(@"mine_ProfileEnter", nil)];
            weightDataTextField.textColor = [HAppUIModel grayColor22];
        } else {
            weightDataString = textField.text;
        }
    }
    if(textField == phoneDataTextField) {
        if(stringLength == 0) {
            [phoneDataTextField setText:NSLocalizedString(@"mine_ProfileEnter", nil)];
            phoneDataTextField.textColor = [HAppUIModel grayColor22];
        } else {
            phoneDataString = textField.text;
        }
    }
    if(textField == mailDataTextField) {
        if(stringLength == 0) {
            [mailDataTextField setText:NSLocalizedString(@"mine_ProfileEnter", nil)];
            mailDataTextField.textColor = [HAppUIModel grayColor22];
        } else {
            mailDataString = textField.text;
            CGSize mailDataTextField_Size = [mailDataString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont5]}];
            mailDataTextField_Size = CGSizeMake(ceilf(mailDataTextField_Size.width), ceilf(mailDataTextField_Size.height));
            mailDataTextField.frame = CGRectMake(0, 0, mailDataTextField_Size.width, mailDataTextField_Size.height);
            mailDataTextField.center = CGPointMake(SCREEN_WIDTH - horizontalSpace1 - mailDataTextField_Size.width * 0.5, verticalSpace1 * 0.5);
        }
    }
    [self saveButtonStuta];
}
// ————————————————————————————————————————————————————————————————————————————————————————————————————————————————

// ———————————————————————————————————— TextView ———————————————————————————————————————————————————————————
#pragma mark - UITextViewDelegate协议中的方法
//将要进入编辑模式
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    offsetStyle = 3;
    [clearView setHidden:NO];
    return YES;
}
//已经进入编辑模式
- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"textview 编辑开始");
}
//将要结束/退出编辑模式
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    return YES;
}
//已经结束/退出编辑模式
- (void)textViewDidEndEditing:(UITextView *)textView {
    NSLog(@"textview 编辑结束");
    healthDataString = textView.text;
    [self saveButtonStuta];
}
//当textView的内容发生改变的时候调用的方法
- (void)textViewDidChange:(UITextView *)textView {
}
//选中textView 或者输入内容的时候调用的方法
- (void)textViewDidChangeSelection:(UITextView *)textView {
}
//从键盘上将要输入到textView的时候调用的方法
//text 将要输入的内容
//返回YES可以输入内容到textView中，返回NO则不能
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return YES;
}
// ————————————————————————————————————————————————————————————————————————————————————————————————————————————————

// ———————————————————————————————————— 按钮动作 —————————————————————————————————————————————————————————————
// 取消
- (void)raceCancelButtonAction:(UIButton *)sender {
    NSLog(@">>> raceCancelButtonAction");
    [transparentView setHidden:YES];
    [raceToolView removeFromSuperview];
    [racePickerView removeFromSuperview];
    [self saveButtonStuta];
}
- (void)ageCancelButtonAction:(UIButton *)sender {
    NSLog(@">>> ageCancelButtonAction");
    [transparentView setHidden:YES];
    [ageToolView removeFromSuperview];
    [agePickerView removeFromSuperview];
    [self saveButtonStuta];
}
- (void)genderCancelButtonAction:(UIButton *)sender {
    NSLog(@">>> genderCancelButtonAction");
    [transparentView setHidden:YES];
    [genderToolView removeFromSuperview];
    [genderPickerView removeFromSuperview];
    [self saveButtonStuta];
}
//- (void)pacemakerCancelButtonAction:(UIButton *)sender {
//    NSLog(@">>> pacemakerCancelButtonAction");
//    [transparentView setHidden:YES];
//    [pacemakerToolView removeFromSuperview];
//    [pacemakerPickerView removeFromSuperview];
//    [self saveButtonStuta];
//}
- (void)bloodTypeCancelButtonAction:(UIButton *)sender {
    NSLog(@">>> bloodTypeCancelButtonAction");
    [transparentView setHidden:YES];
    [genderToolView removeFromSuperview];
    [genderPickerView removeFromSuperview];
    [self saveButtonStuta];
}
// 完成
- (void)raceDoneButtonAction:(UIButton *)sender {
    NSLog(@">>> raceCancelButtonAction");
    [transparentView setHidden:YES];
    [raceToolView removeFromSuperview];
    [racePickerView removeFromSuperview];
    
    raceDataLabel.textColor = [HAppUIModel grayColor3];
    raceDataLabel.text = raceDataString;
    [self saveButtonStuta];
}
- (void)ageDoneButtonAction:(UIButton *)sender {
    NSLog(@">>> ageCancelButtonAction");
    [transparentView setHidden:YES];
    [ageToolView removeFromSuperview];
    [agePickerView removeFromSuperview];
    
    ageDataLabel.textColor = [HAppUIModel grayColor3];
    ageDataLabel.text = ageDataString;
    [self saveButtonStuta];
}
- (void)genderDoneButtonAction:(UIButton *)sender {
    NSLog(@">>> genderCancelButtonAction");
    [transparentView setHidden:YES];
    [genderToolView removeFromSuperview];
    [genderPickerView removeFromSuperview];
    
    genderDataLabel.textColor = [HAppUIModel grayColor3];
    genderDataLabel.text = genderDataString;
    [self saveButtonStuta];
}
//- (void)pacemakerDoneButtonAction:(UIButton *)sender {
//    NSLog(@">>> pacemakerCancelButtonAction");
//    [transparentView setHidden:YES];
//    [pacemakerToolView removeFromSuperview];
//    [pacemakerPickerView removeFromSuperview];
//
//    pacemakerDataLabel.textColor = [HAppUIModel grayColor3];
//    pacemakerDataLabel.text = pacemakerDataString;
//    [self saveButtonStuta];
//}
- (void)bloodTypeDoneButtonAction:(UIButton *)sender {
    NSLog(@">>> bloodTypeDoneButtonAction");
    [transparentView setHidden:YES];
    [genderToolView removeFromSuperview];
    [genderPickerView removeFromSuperview];
    
    bloodTypeDataLabel.textColor = [HAppUIModel grayColor3];
    bloodTypeDataLabel.text = bloodTypeDataString;
    [self saveButtonStuta];
}
- (void)saveButtonAction:(UIButton *)sender {
    NSLog(@"saveButtonAction");
    // 先存
    int user_id = 0;
    if ([ApplicationDelegate.profile valueForKey:@"UserId"]) {
        user_id = [[ApplicationDelegate.profile valueForKey:@"UserId"] intValue];
    }
    ApplicationDelegate.profile = [NSMutableDictionary dictionary];
    [ApplicationDelegate.profile setObject:@(user_id) forKey:@"UserId"];
    [ApplicationDelegate.profile setObject:@"" forKey:@"UserName"];
    [ApplicationDelegate.profile setObject:ageDataString forKey:@"AgeGroup"];
    [ApplicationDelegate.profile setObject:genderDataString forKey:@"Sex"];
    [ApplicationDelegate.profile setObject:heightDataString forKey:@"Height"];
    [ApplicationDelegate.profile setObject:weightDataString forKey:@"Weight"];
    if ([healthDataString isEqualToString:@""] || healthDataString == nil) {
        [ApplicationDelegate.profile setObject:@"" forKey:@"Health"];
    } else {
        [ApplicationDelegate.profile setObject:healthDataString forKey:@"Health"];
    }
    [ApplicationDelegate.profile setObject:raceDataString forKey:@"Race"];
    if ([bloodTypeDataString isEqualToString:@""] || bloodTypeDataString == nil) {
        [ApplicationDelegate.profile setObject:@"" forKey:@"BloodType"];
    } else {
        [ApplicationDelegate.profile setObject:bloodTypeDataString forKey:@"BloodType"];
    }
    [ApplicationDelegate.profile setObject:@"" forKey:@"Country"];
    [ApplicationDelegate.profile setObject:@"" forKey:@"Region"];
    if ([phoneDataString isEqualToString:@""] || phoneDataString == nil) {
        [ApplicationDelegate.profile setObject:@"" forKey:@"Phone"];
    } else {
        [ApplicationDelegate.profile setObject:phoneDataString forKey:@"Phone"];
    }
    if ([mailDataString isEqualToString:@""] || mailDataString == nil) {
        [ApplicationDelegate.profile setObject:@"" forKey:@"Mail"];
    } else {
        [ApplicationDelegate.profile setObject:mailDataString forKey:@"Mail"];
    }
    if ([pacemakerDataString isEqualToString:@"0"]) {
        [ApplicationDelegate.profile setObject:@(0) forKey:@"Pacemaker"];
    }
    if ([pacemakerDataString isEqualToString:@"1"]) {
        [ApplicationDelegate.profile setObject:@(1) forKey:@"Pacemaker"];
    }
    NSLog(@"将要上传 %@", ApplicationDelegate.profile);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"application/json",nil];
    [manager POST:Profile_URL parameters:ApplicationDelegate.profile progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"*_*");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功 responseObject %@", responseObject);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        int get_user_id = [[dic valueForKey:@"UserId"] intValue];
        NSLog(@"成功 get_user_id %d", get_user_id);
        [ApplicationDelegate.profile setObject:@(get_user_id) forKey:@"UserId"];
        
        NSLog(@">>> profile %@", ApplicationDelegate.profile);
        [[NSUserDefaults standardUserDefaults] setObject:ApplicationDelegate.profile forKey:@"profile"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [MBProgressHUD showSuccess:@"保存成功"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSString *eeee = [[NSString alloc] initWithData:error encoding:NSUTF8StringEncoding];
        NSLog(@"失败 error: %@", error);
        [[NSUserDefaults standardUserDefaults] setObject:ApplicationDelegate.profile forKey:@"profile"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [MBProgressHUD showSuccess:@"保存成功"];
    }];
}
- (void)leftSelectedButtonAction {
    NSLog(@"leftSelectedButtonAction");
    pacemakerDataString = [NSString stringWithFormat:@"1"];
    [leftSelectedButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    [rightSelectedButton setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    [self saveButtonStuta];
}
- (void)rightSelectedButtonAction {
    NSLog(@"rightSelectedButtonAction");
    pacemakerDataString = [NSString stringWithFormat:@"0"];
    [leftSelectedButton setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    [rightSelectedButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    [self saveButtonStuta];
}
// ————————————————————————————————————————————————————————————————————————————————————————————————————————————————

- (void)saveButtonStuta {
    if ([heightDataString isEqualToString:@""] || [weightDataString isEqualToString:@""] || [raceDataString isEqualToString:@""] || [ageDataString isEqualToString:@""] || [genderDataString isEqualToString:@""] || [pacemakerDataString isEqualToString:@""]) {
        NSLog(@"不完整");
    } else {
        NSLog(@"完整");
        [saveButton setEnabled:YES];
    }
}

- (void)keyboardWillShow:(NSNotification *)aNotification {
    /* 获取键盘的高度 */
    NSDictionary *userInfo = aNotification.userInfo;
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    keyboardRect = aValue.CGRectValue;
    NSLog(@"%f", keyboardRect.size.height);
    
    if (1 == offsetStyle) {
        CGFloat heightOffset = verticalSpace2 + 8 * verticalSpace1 - (SCREEN_HEIGHT - STATUS_HEIGHT - 44 - keyboardRect.size.height);
        mine_ProfileTableView.contentInset = UIEdgeInsetsMake(-heightOffset, 0, 0, 0);
    }
    if (2 == offsetStyle) {
        CGFloat heightOffset = verticalSpace2 + 9 * verticalSpace1 - (SCREEN_HEIGHT - STATUS_HEIGHT - 44 - keyboardRect.size.height);
        mine_ProfileTableView.contentInset = UIEdgeInsetsMake(-heightOffset, 0, 0, 0);
    }
    if (3 == offsetStyle) {
        CGFloat heightOffset = verticalSpace2 + 9 * verticalSpace1 + verticalSpace9 - (SCREEN_HEIGHT - STATUS_HEIGHT - 44 - keyboardRect.size.height);
        mine_ProfileTableView.contentInset = UIEdgeInsetsMake(-heightOffset, 0, 0, 0);
    }
}
- (void)keyboardWillHide:(NSNotification *)aNotification {
    if (1 == offsetStyle) {
        mine_ProfileTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    if (2 == offsetStyle) {
        mine_ProfileTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    if (3 == offsetStyle) {
        mine_ProfileTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    offsetStyle = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@">>> 进入 Mine - Profile");
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
