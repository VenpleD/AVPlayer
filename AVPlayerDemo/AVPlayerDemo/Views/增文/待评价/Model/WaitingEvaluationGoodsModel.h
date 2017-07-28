//
//  WaitingEvaluationGoodsModel.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/18.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WaitingEvaluationGoodsModel : NSObject
/**
 商品名字
 */
@property (nonatomic, copy  ) NSString *goodsName;


/**
 商品图片
 */
@property (nonatomic, copy  ) NSString *goodsImageUrl;

/**
 现价
 */
@property (nonatomic, assign) CGFloat  goodsPrice;

/**
 数量
 */
@property (nonatomic, assign) NSInteger goodsQty;


@end
