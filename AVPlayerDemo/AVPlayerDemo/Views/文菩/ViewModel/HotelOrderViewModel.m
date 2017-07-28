//
//  HotelOrderViewModel.m
//  AVPlayerDemo
//
//  Created by duanwenpu on 2017/7/28.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "HotelOrderViewModel.h"

@implementation HotelOrderViewModel

- (RACSignal *)submitData {
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        return nil;
    }];
    return dataSignal;
}

- (NSMutableAttributedString *)getShowTotalPrice {
    NSString *unitPrice = @"233";
    NSString *number = @"5";
    NSInteger totalPrice = [unitPrice integerValue] * [number integerValue];
    NSString *totalString = @"总计：";
    NSString *rmb = @"¥";
    NSMutableAttributedString *stringTotalPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%ld", totalString, rmb, totalPrice]];
    NSDictionary *attributeOne = @{NSFontAttributeName : [UIFont systemFontOfSize:15],
                                   NSForegroundColorAttributeName : [UIColor blueColor]};
    NSDictionary *attributeTwo = @{NSFontAttributeName : [UIFont systemFontOfSize:15],
                                   NSForegroundColorAttributeName : [UIColor greenColor]};
    NSDictionary *attributeThree = @{NSFontAttributeName : [UIFont systemFontOfSize:24],
                                     NSForegroundColorAttributeName : [UIColor redColor]};
    
    [stringTotalPrice setAttributes:attributeOne range:NSMakeRange(0, totalString.length)];
    [stringTotalPrice setAttributes:attributeTwo range:NSMakeRange(totalString.length, rmb.length)];
    [stringTotalPrice setAttributes:attributeThree range:NSMakeRange(totalString.length + rmb.length, [[NSString stringWithFormat:@"%ld",totalPrice] length])];
    return stringTotalPrice;
}

- (NSString *)getRoomsTimes {
    NSString *checkInTime = @"6月30日（周一）";
    NSString *checkOutTime = @"7月1日（周三）";
    NSString *days = @"共五晚";
    NSString *showString = [NSString stringWithFormat:@"入住：%@ 退房：%@ %@", checkInTime, checkOutTime, days];
    return showString;
}

@end
