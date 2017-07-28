//
//  EvaluateViewController.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/12.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "EvaluateViewController.h"
#import "StarView.h"
#import "PerCapitaConsumptionView.h"
#import "MWPhoto.h"
#import "MWPhotoBrowser.h"
#import "EvaluationContentView.h"
#import "TZImagePickerController.h"
#import "UploadImageManager.h"

@interface EvaluateViewController ()<MWPhotoBrowserDelegate,TZImagePickerControllerDelegate>
@property (nonatomic, strong) NSMutableArray *starViewArray;
@property (nonatomic, strong) NSArray <NSString *>*titleArray;
@property (nonatomic, strong) NSArray <NSNumber *>*scoreArray;
@property (nonatomic, strong) PerCapitaConsumptionView *inputAmountView;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) UIScrollView *evaluateBackgroundView;
@property (nonatomic, strong) EvaluationContentView *evaluationContentView;
@property (nonatomic, strong) NSMutableArray *imageViewCopyArray;
@property (nonatomic, strong) UIButton *commentButton;

@end

@implementation EvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self addSubView];
    [self updata];
}

- (void)addSubView {
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:self.commentButton];
    self.navigationItem.rightBarButtonItem = rightButton;
    
}
- (void)updata {
    self.starViewArray = [NSMutableArray array];
    WEAK_SELF(self)
    [self addSubViewsComplete:^{
        STRONG_SELF(self)
        [self updataSources];
    }];
    [self setSubViewLayout];
    
    self.evaluationContentView.goPhotoAlbumBlock = ^{
        STRONG_SELF(self)
        [self addPotho2];
    };
    self.imageViewCopyArray  = [NSMutableArray array];
}
- (void)addPhoto {

    NSMutableArray *photos = [[NSMutableArray alloc] init];
    MWPhoto *photo;
    BOOL displayActionButton = NO;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = YES;
    BOOL startOnGrid = NO;
    
    // Photos
    photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"5" ofType:@"png"]]];
    photo.caption = @"Fireworks";
    [photos addObject:photo];
    photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"4" ofType:@"png"]]];
    photo.caption = @"The London Eye is a giant Ferris wheel situated on the banks of the River Thames, in London, England.";
    [photos addObject:photo];
    photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"6" ofType:@"png"]]];
    photo.caption = @"York Floods";
    [photos addObject:photo];
    photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"7" ofType:@"png"]]];
    photo.caption = @"Campervan";
    [photos addObject:photo];
    // Options
    
    self.photos = photos;
//    self.thumbs = thumbs;
    
    //
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;//分享按钮,默认是
    browser.displayNavArrows = displayNavArrows;//左右分页切换,默认否
    browser.displaySelectionButtons = displaySelectionButtons;//是否显示选择按钮在图片上,默认否
    browser.alwaysShowControls = displaySelectionButtons;//控制条件控件 是否显示,默认否
    browser.zoomPhotosToFill = NO;//是否全屏,默认是
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    browser.wantsFullScreenLayout = YES;//是否全屏
#endif
    browser.enableGrid = enableGrid;//是否允许用网格查看所有图片,默认是
    browser.startOnGrid = startOnGrid;//是否第一张,默认否
    browser.enableSwipeToDismiss = YES;
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    [browser setCurrentPhotoIndex:1];
//    browser.photoTitles = @[@"000",@"111",@"222",@"333"];//标题
    
    //    [self presentViewController:browser animated:YES completion:nil];
    [self.navigationController pushViewController:browser animated:NO];
}
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count) {
        if (index < _photos.count)
            return [_photos objectAtIndex:index];
    }
    return nil;
}



- (void)addPotho2 {
    // 还剩可选的张数
    NSInteger optionalCount = 3 - self.evaluationContentView.imageArray.count ;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:optionalCount delegate:self];
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    WEAK_SELF(self)
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto) {
//        NSLog(@"---%@--%@---%d",photos,assets,);
        
        [UploadImageManager aaimage:photos];
        
        STRONG_SELF(self)
        [self.imageViewCopyArray addObjectsFromArray:photos];
//        self.evaluationContentView.imageArray = self.imageViewCopyArray;
        
        [self.evaluationContentView SetDataImagearray:[photos copy]];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}


- (void)addSubViewsComplete:(void(^)())complete {
    [self.view addSubview:self.evaluateBackgroundView];
    __block StarView *lastView = nil;
    for (NSInteger i = 0; i < 4; i++) {
        StarView *starView = [[StarView alloc]init];
        [self.evaluateBackgroundView addSubview:starView];
        starView.tag = i +100;
        [starView typeTitle:self.titleArray[i] rating:[self.scoreArray[i] floatValue]];
        [starView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(44);
            make.left.equalTo(12);
            make.width.equalTo(KScreenW - 12 *2);
            if (lastView) {
                make.top.equalTo(lastView.bottom).offset(10);
            } else {
                make.top.equalTo(20);
            }
            
            lastView = starView;
        }];
        [self.starViewArray addObject:starView];
     
        i != 3 ? : complete();
    }
    

    
    [self.evaluateBackgroundView addSubview:self.inputAmountView];
    [self.evaluateBackgroundView addSubview:self.evaluationContentView];
}

- (void)updataSources {
    for (StarView *view in self.starViewArray) {
        NSLog(@"%f",view.frame.origin.x);
        switch (view.tag) {
            case 100:
                view.starBlock = ^(CGFloat rating) {
                    NSLog(@"第一个:%f",rating);
                };
                break;
            case 101:
                view.starBlock = ^(CGFloat rating) {
                    NSLog(@"第二个:%f",rating);
                };
                break;
            case 102:
                view.starBlock = ^(CGFloat rating) {
                    NSLog(@"第三个:%f",rating);
                };
                break;
            case 103:
                view.starBlock = ^(CGFloat rating) {
                    NSLog(@"第四个:%f",rating);
                };
                break;
            default:
                break;
        }
        
        
    }
    self.evaluationContentView.textContentBlock = ^(NSString *contentBlock) {
        NSLog(@"-----%@",contentBlock);
    };
}


- (NSArray<NSString *> *)titleArray {
    return @[@"味道",
             @"环境",
             @"服务",
             @"价格"];
}

- (NSArray<NSNumber *> *)scoreArray {
    return @[@1.3,
             @1.5,
             @2.0,
             @3.5];
}

- (void)comment {

    NSLog(@"发表了一次评论");

}


- (void)setSubViewLayout {
    
    [self.inputAmountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.evaluateBackgroundView);
        make.width.equalTo(KScreenW);
        for (StarView *view in self.starViewArray) {
            if (view.tag == 103) {
                make.top.equalTo(view.bottom).offset(20);
            }

        }
        make.height.equalTo(44);
    }];
    
    [self.evaluationContentView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputAmountView.bottom).offset(10);
        make.left.equalTo(self.inputAmountView);
        make.right.equalTo(self.inputAmountView);
        make.height.equalTo(250 + 30);
    }];
    
}

- (PerCapitaConsumptionView *)inputAmountView {
    if (!_inputAmountView) {
        _inputAmountView = [[PerCapitaConsumptionView alloc]initWithFrame:CGRectZero];
        [_inputAmountView setBackgroundColor:[UIColor whiteColor]];
    }
    return _inputAmountView;
}


- (UIScrollView *)evaluateBackgroundView {
    if (!_evaluateBackgroundView) {
        _evaluateBackgroundView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0 , KScreenW , KScreenH)];
        [_evaluateBackgroundView setContentSize: CGSizeMake(KScreenW , KScreenH - 64)];
        [_evaluateBackgroundView setScrollEnabled:YES];
        [_evaluateBackgroundView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        
    }
    return _evaluateBackgroundView;
}

- (EvaluationContentView *)evaluationContentView {
    if (!_evaluationContentView) {
        _evaluationContentView = [[EvaluationContentView alloc]initWithFrame:CGRectZero];
    }
    return _evaluationContentView;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.frame = CGRectMake(0, 0, 40, 40);
        [_commentButton setTitle:@"发表" forState:UIControlStateNormal];
        [_commentButton addTarget:self action:@selector(comment) forControlEvents:UIControlEventTouchUpInside];
        [_commentButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
    }
    return _commentButton;
}



@end
