//
//  HotelOrderViewController.m
//  AVPlayerDemo
//
//  Created by duanwenpu on 2017/7/25.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "HotelOrderViewController.h"
#import "HotelNavView.h"
#import "HotelInfoView.h"
#import "HotelConfirmInfoView.h"
#import "ResidentFooterView.h"
#import "HotelOrderViewModel.h"

@interface HotelOrderViewController ()

@property (nonatomic, strong) HotelInfoView *infoView;

@property (nonatomic, strong) HotelConfirmInfoView *confirmInfoView;

@property (nonatomic, strong) ResidentFooterView *footerView;

@property (nonatomic, strong) HotelOrderViewModel *viewModel;

@end

@implementation HotelOrderViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:RGB_HEX(333333)];
    [self settingSubViews];
    [self bindViewModel];
}

- (void)settingSubViews {
    CGFloat topViewHeight = 175.f;
    UIView *topView = [[UIView alloc] init];
    [topView setBackgroundColor:[UIColor redColor]];
    [topView setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, topViewHeight)];
    [self.view addSubview:topView];
    
    HotelNavView *navView = [[HotelNavView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 64)];
    [navView.titleLabel setText:@"酒店title"];
    [self.view addSubview:navView];

    CGFloat infoViewHeight = 139.f;
    self.infoView = [[HotelInfoView alloc] initWithFrame:CGRectMake(HorizonInterval, RECT_MAX_Y(navView) + 5, kSCREEN_WIDTH - HorizonInterval * 2, infoViewHeight)];
    [self.infoView.roomsEnvironmentLabel setText:@"12312312"];
    [self.view addSubview:self.infoView];
    
    CGFloat footerHeight = 49.f;
    self.confirmInfoView = [[HotelConfirmInfoView alloc] initWithFrame:CGRectMake(0, RECT_MAX_Y(self.infoView), kSCREEN_WIDTH, KScreenH - footerHeight - RECT_MAX_Y(self.infoView))];
    [self.confirmInfoView.mobileTextField setKeyboardType:UIKeyboardTypePhonePad];
    [self.view addSubview:self.confirmInfoView];
    
    self.footerView = [[ResidentFooterView alloc] initWithFrame:CGRectMake(0, RECT_HEIGHT(self.view) - footerHeight, RECT_WIDTH(self.view), footerHeight)];
    [self.view addSubview:self.footerView];
}

/**
 *  绑定视图事件
 */
- (void)bindViewModel {
    [self.infoView.timesLabel setText:[self.viewModel getRoomsTimes]];
    
    [[self.confirmInfoView.roomsButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    [[self.confirmInfoView.arriveTimeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    RAC(self.viewModel, userName) = self.confirmInfoView.userNameTextField.rac_textSignal;
    RAC(self.viewModel, mobile) = self.confirmInfoView.mobileTextField.rac_textSignal;
    
    [self.footerView.totalPriceLabel setAttributedText:[self.viewModel getShowTotalPrice]];
    [self.footerView.submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)submitAction {
    [[self.viewModel submitData] subscribeNext:^(id x) {
        
    }];
}

- (HotelOrderViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[HotelOrderViewModel alloc] init];
    }
    return _viewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
