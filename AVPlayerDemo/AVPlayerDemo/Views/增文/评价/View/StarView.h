//
//  StarView.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/12.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RatingBlock)(CGFloat rating);

@interface StarView : UIView

@property (nonatomic, copy) RatingBlock starBlock;

- (void)typeTitle:(NSString *)title rating:(CGFloat)rating;

@end
