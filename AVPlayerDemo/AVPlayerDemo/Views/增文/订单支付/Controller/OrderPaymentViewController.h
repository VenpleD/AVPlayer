//
//  OrderPaymentViewController.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/19.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "BaseViewController.h"
@class ShopModel;
@interface OrderPaymentViewController : UIViewController
@property (nonatomic, strong) NSArray <ShopModel *> *modelArray;
@property (nonatomic, assign) CGFloat allPrice;
@end
