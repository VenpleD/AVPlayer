//
//  massageView.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/19.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickMessageButtonBlock)();
@interface messageView : UIView
@property (nonatomic, strong) UIImage *messageImage;
@property (nonatomic, strong) NSString *messageNumerString;
@property (nonatomic, copy) ClickMessageButtonBlock clickButton;

@end
