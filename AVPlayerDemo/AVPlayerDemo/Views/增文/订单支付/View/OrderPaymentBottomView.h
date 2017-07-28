//
//  OrderPaymentBottomView.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/21.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SubmitButtonBlcok)();
@interface OrderPaymentBottomView : UIView
@property (nonatomic, strong) SubmitButtonBlcok submitBlcok;

- (void)setAllprice:(NSInteger)price;
@end
