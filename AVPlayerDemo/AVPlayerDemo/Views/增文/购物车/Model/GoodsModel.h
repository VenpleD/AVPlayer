//
//  GoodsModel.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/7.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface GoodsModel : NSObject

/**
 商品名字
 */
@property (nonatomic, copy  ) NSString *goodsName;


/**
 商品规格
 */
@property (nonatomic, copy  ) NSString *goodsSpecifications;

/**
 商品图片
 */
@property (nonatomic, copy  ) NSString *goodsImageUrl;

/**
 现价
 */
@property (nonatomic, assign) CGFloat  goodsNewPrice;

/**
 原价
 */
@property (nonatomic, assign) CGFloat  goodsOldPrice;

/**
 库存
 */
@property (nonatomic, assign) NSInteger goodsStocks;

/**
 商品颜色
 */
@property (nonatomic, strong) NSString *goodsColor;

/**
 商品尺码
 */
@property (nonatomic, strong) NSString *goodsSize;

/**
 推荐尺寸
 */
@property (nonatomic, strong) NSString *goodsRecommendedSize;

/**
 数量
 */
@property (nonatomic, assign) NSInteger goodsQty;

/**
  记录每个对应 row 是否被选中
 */
@property (nonatomic, assign) BOOL     isSelected;

/**
 记录是否被编辑
 */
@property (nonatomic, assign) BOOL     isEdit;

@property (nonatomic, copy  ) NSString *goodsStandards;

@end
