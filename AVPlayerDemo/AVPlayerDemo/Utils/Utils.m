//
//  Utils.m
//  AVPlayerDemo
//
//  Created by dev on 2017/6/21.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import "Utils.h"
#import <AVFoundation/AVFoundation.h>

@implementation Utils

#pragma mark -
#pragma mark --- 通过视频URL 获取视频缩略图 ---
+ (UIImage *)getImageWithVideoUrl:(NSString *)videoUrl{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoUrl] options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;
}

@end
