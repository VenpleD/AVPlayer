//
//  PaymentTableViewProtocolAgent.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/22.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SelectCellBlcok)();
@interface PaymentTableViewProtocolAgent : NSObject <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) CGFloat allPrcie;
@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, copy) SelectCellBlcok selectBlcok;
@end
