//
//  HotelConfirmInfoView.h
//  AVPlayerDemo
//
//  Created by duanwenpu on 2017/7/25.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLArrowButton.h"

@interface HotelConfirmInfoView :UIScrollView

///房间数量按钮
@property (nonatomic, strong) YLArrowButton *roomsButton;

///姓名
@property (nonatomic, strong) UITextField *userNameTextField;

///手机号
@property (nonatomic, strong) UITextField *mobileTextField;

///到达时间时间按钮
@property (nonatomic, strong) YLArrowButton *arriveTimeButton;


@end
