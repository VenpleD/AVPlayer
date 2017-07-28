//
//  YLArrowButton.m
//  YL-Health-RB
//
//  Created by Duanwp on 17/6/21.
//  Copyright © 2017年 PingAn. All rights reserved.
//

#import "YLArrowButton.h"

@interface YLArrowButton ()

@property (nonatomic, assign) CGFloat recordTitleWidth;

@end

static CGFloat const ImageWidth = 7.f;

static CGFloat const ImageHeight = 12.f;

///左右两边距离边缘的间距
static CGFloat const HorizonInterval = 0.f;

///title和image之间的间距
static CGFloat const elementInterval = 5.f;

@implementation YLArrowButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGRect imageRect = [super imageRectForContentRect:contentRect];
    CGFloat contentWidth = contentRect.size.width;
    CGFloat imageOriginX;
    switch (self.arrangementType) {
        case ArrangementTypeRight:
            imageOriginX = contentWidth - ImageWidth - HorizonInterval;
            break;

        case ArrangementTypeBothEnds:
            imageOriginX = contentWidth - ImageWidth - HorizonInterval;
            break;

        default:
            imageOriginX = self.recordTitleWidth + elementInterval;
            break;
    }
    return CGRectMake(imageOriginX, (imageRect.size.height - ImageHeight) / 2, ImageWidth, ImageHeight);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect titleRect = [super titleRectForContentRect:contentRect];
    CGFloat contentWidth = contentRect.size.width;
    self.recordTitleWidth = titleRect.size.width;
    CGFloat titleOriginX;
    switch (self.arrangementType) {
        case ArrangementTypeRight:
            titleOriginX = contentWidth - ImageWidth - self.recordTitleWidth - HorizonInterval - elementInterval;
            break;

        case ArrangementTypeBothEnds:
            titleOriginX = 0.f;
            break;

        default:
            titleOriginX = 0.f;
            break;
    }
    return CGRectMake(titleOriginX, titleRect.origin.y, self.recordTitleWidth, titleRect.size.height);
}

@end
