//
//  Utils.h
//  AVPlayerDemo
//
//  Created by dev on 2017/6/21.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

//通过视频URL 获取视频缩略图 
+ (UIImage *)getImageWithVideoUrl:(NSString *)videoUrl;

@end
