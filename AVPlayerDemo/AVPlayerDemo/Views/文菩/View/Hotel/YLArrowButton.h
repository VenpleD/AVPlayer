//
//  YLArrowButton.h
//  YL-Health-RB
//
//  Created by Duanwp on 17/6/21.
//  Copyright © 2017年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * title和image的排列类型
 *
 */
typedef NS_ENUM(NSInteger, ArrangementType) {
    ArrangementTypeLeft = 0, //全部居左
    ArrangementTypeRight, //全部居右
    ArrangementTypeBothEnds //位于两端
};

@interface YLArrowButton : UIButton

@property (nonatomic, assign) ArrangementType arrangementType;

@end
