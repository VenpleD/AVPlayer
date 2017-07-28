//
//  HotelOrderViewModel.h
//  AVPlayerDemo
//
//  Created by duanwenpu on 2017/7/28.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelOrderViewModel : NSObject

@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *mobile;

/**
 *  返回footerView上面价格区域的显示数据
 */
- (NSMutableAttributedString *)getShowTotalPrice;

/**
 *  返回上面视图timeLabel的显示数据
 */
- (NSString *)getRoomsTimes;

/**
 *  提交数据
 */
- (RACSignal *)submitData;


@end
