//
//  CartTableViewHeaderView.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/7.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ShopcartHeaderViewBlock)(BOOL isSelected);

@interface CartTableViewHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) ShopcartHeaderViewBlock shopcartHeaderViewBlock;

- (void)configureShopcartHeaderViewWithshopName:(NSString *)shopName
                                    shopVariety:(NSInteger)shopVariety
                                       shopType:(NSInteger)type
                                     shopSelect:(BOOL)shopSelect ;




/**
 商家名称
 */
//@property (nonatomic, strong) NSString *shopName;
//
///**
// 商家id
// */
//@property (nonatomic, strong) NSString *shopID;
//
///**
// 商家类型
// */
//@property (nonatomic, assign) NSInteger shopType;

/**
 全选按钮
 */
//@property (nonatomic, strong) UIButton *shopSelectButton;





@end
