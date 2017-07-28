//
//  ShopcartCountView.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/10.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopcartCountViewEditBlock)(NSInteger count);

@interface ShopcartCountView : UIView

@property (nonatomic, copy) ShopcartCountViewEditBlock shopcartCountViewEditBlock;

- (void) configureShopcartCountViewWithProductCount:(NSInteger)count productStock:(NSInteger)stock goodsSpecifications:(NSString *)goodsSpecifications;

@end
