//
//  evaluationContentView.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/13.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TextContentBlock)(NSString *ContentBlock);
typedef void(^GoPhotoAlbumBlock)();

@interface EvaluationContentView : UIView
@property (nonatomic, copy) TextContentBlock textContentBlock;
@property (nonatomic, copy) GoPhotoAlbumBlock goPhotoAlbumBlock;

@property (nonatomic, strong) NSMutableArray <UIImage *>*imageArray;

- (void)SetDataImagearray:(NSMutableArray <UIImage *>*)imageArray;

@end
