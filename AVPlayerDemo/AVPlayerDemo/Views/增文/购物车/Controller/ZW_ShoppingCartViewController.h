//
//  ZW_ShoppingCartViewController.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/7.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ShopcartCellEditiBlock)(BOOL isEditi);

@interface ZW_ShoppingCartViewController : BaseViewController
@property (nonatomic, copy) ShopcartCellEditiBlock shopcartCellEditiBlock;

@end
