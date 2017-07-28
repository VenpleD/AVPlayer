//
//  ShopModel.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/7.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"
@interface ShopModel : NSObject 

@property (nonatomic, assign) BOOL isSelected;   // 记录每个对应商家是否被全部选中
@property (nonatomic, copy  ) NSString *shopID;
@property (nonatomic, copy  ) NSString *shopName;
@property (nonatomic, assign) NSInteger shopTpye;
@property (nonatomic, assign) NSInteger shopVariety;
@property (nonatomic, strong) NSMutableArray <GoodsModel *> *goodsModel;
@property (nonatomic, strong) NSMutableArray *selectedArray;    //结算时筛选出选中的商品（自定义）

@end
