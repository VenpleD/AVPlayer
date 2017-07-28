//
//  OrderPaymentTableViewProtocolAgent.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/21.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopModel.h"
@interface OrderPaymentTableViewProtocolAgent : NSObject <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) NSArray <ShopModel *>*orderPaymentDataArray;

@end
