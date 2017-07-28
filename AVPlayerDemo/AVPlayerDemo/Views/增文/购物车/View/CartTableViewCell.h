//
//  CartTableViewCell.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/9.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopcartCellBlock)(BOOL isSelected);
typedef void(^ShopcartCellEditBlock)(NSInteger count);

@interface CartTableViewCell : UITableViewCell

@property (nonatomic, copy) ShopcartCellBlock shopcartCellBlock;
@property (nonatomic, copy) ShopcartCellEditBlock shopcartCellEditBlock;
@property (nonatomic, assign) BOOL isEdit;
- (void)cartCellEditing:(BOOL)isEdit;

- (void)configureShopcartCellWithProductURL:(NSString *)productURL
                                productName:(NSString *)productName
                               productColor:(NSString *)productColor
                                productSize:(NSString *)productSize
                     productRecommendedSize:(NSString *)productRecommendedSize
                               productPrice:(CGFloat)productPrice
                            productOldPrice:(CGFloat)oldPrice
                               productCount:(NSInteger)productCount
                               productStock:(NSInteger)productStock
                            productSelected:(BOOL)productSelected
                                    editing:(BOOL)edit ;
@end
