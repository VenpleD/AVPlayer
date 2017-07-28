//
//  PhotoImageView.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/13.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DeleteBlock)();
@interface PhotoImageView : UIImageView
@property (nonatomic, copy) DeleteBlock deleteBlock;
@end
