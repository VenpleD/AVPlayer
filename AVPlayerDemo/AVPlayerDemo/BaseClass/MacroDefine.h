//
//  MacroDefine.h
//  AVPlayerDemo
//
//  Created by dev on 2017/6/21.
//  Copyright © 2017年 周伟. All rights reserved.
//

#ifndef MacroDefine_h
#define MacroDefine_h

#define FORMAT(string, args...) [NSString stringWithFormat:string, args]
#define URL(url) [NSURL URLWithString:url]
#ifdef DEBUG
#define DLog(...) printf("[%s %d行]:\n%s\n", __PRETTY_FUNCTION__, __LINE__,[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#define DLog_CURRENT_METHOD NSLog(@"%@-%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd))
#else
#define DLog(...) ;
#define DLog_CURRENT_METHOD ;
#endif


#define kSCREEN_WIDTH          ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT         ([UIScreen mainScreen].bounds.size.height)
#define kStatusBarHeight 20.f
#define kNavigationBarHeight 44.f
#define kTabBarHeight 49.f
#define kNavigationAndStatusBarHeight (20.f + 44.f)


#define WEAK_SELF(o)             __weak __typeof(o) weakSelf = o;
#define STRONG_SELF(o)            __strong __typeof (o)o = weakSelf;


#pragma mark - ios版本判断
#define kIOS8_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)
#define kIOS9_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending)
#define kIOS10_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"10.0"] != NSOrderedAscending)
#define kIOS11_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"11.0"] != NSOrderedAscending)

// iPhone5 or iPhone5s
#define  iPhone5_5s     (kSCREEN_WIDTH == 320.f && kSCREEN_HEIGHT == 568.f)

//iPhone6 or iPhone6s
#define  iPhone6_6s     (kSCREEN_WIDTH == 375.f && kSCREEN_HEIGHT == 667.f)

//iPhone6Plus or iPhone6sPlus
#define  iPhone6_6sPlus (kSCREEN_WIDTH == 414.f && kSCREEN_HEIGHT == 736.f)
//颜色
#define RGB_HEX(V)		[UIColor colorWithHex:V]
#define RGBA_HEX(V, A)	[UIColor colorWithHex:V alpha:A]


///view的宽高坐标
#define RECT_WIDTH(view)           (CGRectGetWidth(view.frame))
#define RECT_HEIGHT(view)          (CGRectGetHeight(view.frame))
#define RECT_MIN_X(view)           (CGRectGetMinX(view.frame))
#define RECT_MIN_Y(view)           (CGRectGetMinY(view.frame))
#define RECT_MAX_X(view)           (CGRectGetMaxX(view.frame))
#define RECT_MAX_Y(view)           (CGRectGetMaxY(view.frame))

#endif /* MacroDefine_h */
