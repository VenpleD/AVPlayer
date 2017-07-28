//
//  PaymentTableViewCell.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/22.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentTableViewCell : UITableViewCell
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, assign) BOOL isLastLine;

- (void)titleImage:(UIImage *)titleImage
       titleString:(NSString *)titleString
     goodsAllPrice:(CGFloat)price;


@end
