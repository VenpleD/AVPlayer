//
//  WaitingEvaluationShopModel.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/18.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WaitingEvaluationGoodsModel.h"
@interface WaitingEvaluationShopModel : NSObject
@property (nonatomic, copy  ) NSString *shopID;
@property (nonatomic, copy  ) NSString *shopName;
@property (nonatomic, assign) NSInteger shopTpye;
@property (nonatomic, strong) NSString *payTimer;
@property (nonatomic, assign) CGFloat  allPrice;
@property (nonatomic, strong) NSMutableArray <WaitingEvaluationGoodsModel *> *goodsModel;
@end
