//
//  ShoppingCartView.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/6/23.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^settleAccountsBlock)();
@interface ZW_ShoppingCartView : UIView
@property (nonatomic, copy) settleAccountsBlock zw_Account;
@property (nonatomic, strong) UIImageView *cartImageView;

- (void)showView ;
@end
