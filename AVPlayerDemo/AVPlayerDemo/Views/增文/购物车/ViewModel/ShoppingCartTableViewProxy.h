//
//  ShoppingCartTableViewProxy.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/10.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ShopcartProxyProductSelectBlock)(BOOL isSelected, NSIndexPath *indexPath);
typedef void(^ShopcartProxyBrandSelectBlock)(BOOL isSelected, NSInteger section);
typedef void(^ShopcartProxyChangeCountBlock)(NSInteger count, NSIndexPath *indexPath);
typedef void(^ShopcartProxyDeleteBlock)(NSIndexPath *indexPath);
typedef void(^ShopcartProxyStarBlock)(NSIndexPath *indexPath);
//typedef void(^ShopcartProxyCellEditiBlock)(BOOL isEditi);


@interface ShoppingCartTableViewProxy : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) ShopcartProxyProductSelectBlock shopcartProxyProductSelectBlock;
@property (nonatomic, copy) ShopcartProxyBrandSelectBlock shopcartProxyBrandSelectBlock;
@property (nonatomic, copy) ShopcartProxyChangeCountBlock shopcartProxyChangeCountBlock;
@property (nonatomic, copy) ShopcartProxyDeleteBlock shopcartProxyDeleteBlock;
@property (nonatomic, copy) ShopcartProxyStarBlock shopcartProxyStarBlock;
//@property (nonatomic, copy) ShopcartProxyCellEditiBlock shopcartProxyCellEditiBlock;
@end
