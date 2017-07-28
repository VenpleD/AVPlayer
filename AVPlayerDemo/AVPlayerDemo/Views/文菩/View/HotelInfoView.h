//
//  HotelInfoView.h
//  AVPlayerDemo
//
//  Created by duanwenpu on 2017/7/25.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelInfoView : UIView

///房间类型
@property (nonatomic, strong) UILabel *roomsTypeLabel;

///居住时间
@property (nonatomic, strong) UILabel *timesLabel;

///房间环境条件
@property (nonatomic, strong) UILabel *roomsEnvironmentLabel;

///取消时间
@property (nonatomic, strong) UILabel *cancelTimeLabel;

@end
