//
//  ShoppingCartBottomView.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/11.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ShopcartBotttomViewAllSelectBlock)(BOOL isSelected);
typedef void(^ShopcartBotttomViewSettleBlock)(void);
typedef void(^ShopcartBotttomViewStarBlock)(void);
typedef void(^ShopcartBotttomViewDeleteBlock)(void);

@interface ShoppingCartBottomView : UIView

@property (nonatomic, copy) ShopcartBotttomViewAllSelectBlock shopcartBotttomViewAllSelectBlock;
@property (nonatomic, copy) ShopcartBotttomViewSettleBlock shopcartBotttomViewSettleBlock;
@property (nonatomic, copy) ShopcartBotttomViewStarBlock shopcartBotttomViewStarBlock;
@property (nonatomic, copy) ShopcartBotttomViewDeleteBlock shopcartBotttomViewDeleteBlock;

- (void)configureShopcartBottomViewWithTotalPrice:(float)totalPrice
                                       totalCount:(NSInteger)totalCount
                                    isAllselected:(BOOL)isAllSelected;

- (void)changeShopcartBottomViewWithStatus:(BOOL)status;

@end
