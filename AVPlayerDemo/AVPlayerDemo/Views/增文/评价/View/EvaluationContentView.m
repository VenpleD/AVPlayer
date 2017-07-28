//
//  evaluationContentView.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/13.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "EvaluationContentView.h"
//#import "PhotoImageView.h"
#import "EvaluationTextView.h"
#import "PhotoView.h"
#import "UploadImageManager.h"

@interface EvaluationContentView ()<UITextViewDelegate>
@property (nonatomic, strong) UIView *contentBackgroundView;
@property (nonatomic, strong) EvaluationTextView *textView;
@property (nonatomic, strong) UIButton *photographButton;

//@property (nonatomic, strong) PhotoImageView *photoImageView;
@property (nonatomic, strong) UILabel *remainingStringLabel; //你没有按钮啊，只有imageview啊...dengwo geini  zhao
@property (nonatomic, strong) NSMutableArray  <PhotoView *> *imageViewArray;

@end

@implementation EvaluationContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
        self.imageViewArray = [NSMutableArray array];
        self.imageArray     = [NSMutableArray array];
        [self updateConstraintsIfNeeded];
        [self setNeedsUpdateConstraints];
    }
    return self;
}


- (void)goPhotoAlbum {
    !self.goPhotoAlbumBlock ? : self.goPhotoAlbumBlock();
}

- (void)addSubviews {
    [self addSubview:self.contentBackgroundView];
    [self.contentBackgroundView addSubview:self.textView];
    [self.contentBackgroundView addSubview:self.photographButton];
    [self.contentBackgroundView addSubview:self.remainingStringLabel];
}

- (void)updateConstraints {
    [self.contentBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self).offset(0);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(5);
        make.right.equalTo(-5);
        make.top.equalTo(10);
        make.height.equalTo(162);
    }];
    
    [self.photographButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(self.textView.bottom).offset(20);
        make.size.equalTo(CGSizeMake(75, 75));
    }];
    
    
    [self.remainingStringLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.bottom.equalTo(-10);
        
    }];
    
    
    [super updateConstraints];
}

- (UIView *)contentBackgroundView {
    if (!_contentBackgroundView) {
        _contentBackgroundView = [[UIView alloc]init];
        [_contentBackgroundView setBackgroundColor:[UIColor whiteColor]];
    }
    return _contentBackgroundView;
}

- (EvaluationTextView *)textView {
    if (!_textView) {
        _textView = [[EvaluationTextView alloc]init];
        [_textView setDelegate:self];
        [_textView setPlaceholder:@"口味如何和？环境如何？服务周到吗？"];
        [_textView setPlaceholderColor:[UIColor lightGrayColor]];
        [_textView setPlaceholderFont:[UIFont systemFontOfSize:15.0f]];
        [_textView setBackgroundColor:[UIColor whiteColor]];
        
    }
    return _textView;
}

- (UIButton *)photographButton {
    if (!_photographButton) {
        _photographButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_photographButton  setImage:[UIImage imageNamed:@"icon_camera"] forState:UIControlStateNormal];
        [_photographButton addTarget:self action:@selector(goPhotoAlbum) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _photographButton;
}

#pragma mark ---设置图片imageView
- (void)SetDataImagearray:(NSMutableArray<UIImage *> *)imageArray {
    if (self.imageArray.count == 3) {
        
    } else {
         [self.imageArray addObjectsFromArray:imageArray];
        /// 已经有图片了
        if (self.imageViewArray.count != 0) {
            
            for (PhotoView *oldView in self.imageViewArray) {
                
                NSLog(@"----%ld--_%ld",oldView.tag,self.imageViewArray.count);
                if (oldView.tag == self.imageViewArray.count - 1 +1000) {
                    __block PhotoView *lastView = nil;
                    for (NSInteger i = 0; i < imageArray.count; i ++) {
                        PhotoView *photoImageView = [[PhotoView alloc]init];
                        [photoImageView.photoDeleteButton addTarget:self action:@selector(deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
                        [photoImageView setPhotoImage:imageArray[i]];
                        [photoImageView setTag:i + 1000 + self.imageViewArray.count];
                        [self.contentBackgroundView  addSubview: photoImageView];
                        [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                            if (lastView) {
                                make.left.equalTo(lastView.right).offset(0);
                            } else {
                                make.left.equalTo(oldView.right).offset(0);
                            }
                            
                            make.top.equalTo(self.textView.bottom).offset(0);
                            make.size.equalTo(CGSizeMake(95, 95));
                        }];
                        lastView = photoImageView;
                        [self.imageViewArray addObject:photoImageView];
                    }
                    [self updateButtonLayout];
                }
            }
            
        } else {
            /// 还没有图片了
            __block PhotoView *lastView = nil;
            for (NSInteger i = 0; i < imageArray.count; i ++) {
                PhotoView *photoImageView = [[PhotoView alloc]init];
                [photoImageView setPhotoImage:imageArray[i]];
                [photoImageView.photoDeleteButton addTarget:self action:@selector(deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
                [photoImageView setTag:i + 1000];
                [self.contentBackgroundView  addSubview: photoImageView];
                
                [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    if (lastView) {
                        make.left.equalTo(lastView.right).offset(0);
                    } else {
                        make.left.equalTo(self.contentBackgroundView.left).offset(15);
                    }
                    make.top.equalTo(self.textView.bottom).offset(0);
                    make.size.equalTo(CGSizeMake(95, 95));
                }];
                lastView = photoImageView;
                [self.imageViewArray addObject:photoImageView];
                
            }
            [self updateButtonLayout];
            //    }
            
            
            
        }
    }
    
   
}


#pragma mark --- 删除按钮
- (void)deleteBtn:(UIButton *)btn  {
    [self.imageArray removeObjectAtIndex:btn.tag - 1000];
    [self.imageViewArray removeObjectAtIndex:btn.tag - 1000];
    __block PhotoView *lastView = nil;
    for (NSInteger i = 0; i < self.imageArray.count; i ++) {
        PhotoView *photoImageView = self.imageViewArray[i];
        [photoImageView setTag:i + 1000];
        [self.contentBackgroundView  addSubview: photoImageView];
        if (lastView) {
            [photoImageView remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastView.right).offset(10);
                make.top.equalTo(self.textView.bottom).offset(0);
                make.size.equalTo(CGSizeMake(95, 95));
            }];
        } else {
            [photoImageView remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentBackgroundView.left).offset(15);
                make.top.equalTo(self.textView.bottom).offset(0);
                make.size.equalTo(CGSizeMake(95, 95));
            }];
        }
       
        lastView = photoImageView;
    }
    [btn.superview removeFromSuperview];
    [self updateButtonLayout];
}

#pragma mark --- 更新添加按钮的位置
- (void)updateButtonLayout {

    if (self.imageViewArray.count == 3) {
        [self.photographButton setHidden:YES];
    } else {
         [self.photographButton setHidden:NO];
        
        if (self.imageViewArray.count == 0) {
            [self.photographButton remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(15);
                make.top.equalTo(self.textView.bottom).offset(20);
                make.size.equalTo(CGSizeMake(75, 75));
            }];
        } else {
            for (PhotoView *lastView in self.imageViewArray) {
                switch (self.imageViewArray.count) {
                    case 1:
                        if (lastView.tag == 1000) {
                            
                            [self.photographButton remakeConstraints:^(MASConstraintMaker *make) {
                                make.left.equalTo(lastView.right).offset(0);
                                make.top.equalTo(self.textView.bottom).offset(20);
                                make.size.equalTo(CGSizeMake(75, 75));
                            }];
                        }
                        break;
                    case 2:
                        if (lastView.tag == 1001) {
                            [self.photographButton remakeConstraints:^(MASConstraintMaker *make) {
                                make.left.equalTo(lastView.right).offset(0);
                                make.top.equalTo(self.textView.bottom).offset(20);
                                make.size.equalTo(CGSizeMake(75, 75));
                            }];
                        }
                        break;
                    case 3:
                        if (lastView.tag == 1002) {
                            [self.photographButton remakeConstraints:^(MASConstraintMaker *make) {
                                make.left.equalTo(lastView.right).offset(0);
                                make.top.equalTo(self.textView.bottom).offset(20);
                                make.size.equalTo(CGSizeMake(75, 75));
                            }];
                        }
                        break;
                    default:
                        
                        break;
                }
                
            }
        }
        
    }
    
}


#pragma mark --- 还剩 XXX 个字
- (UILabel *)remainingStringLabel {
    if (!_remainingStringLabel) {
        _remainingStringLabel = [[UILabel alloc]init];
        [_remainingStringLabel setFont:[UIFont systemFontOfSize:12.0]];
        [_remainingStringLabel setTextColor:[UIColor lightGrayColor]];
        [_remainingStringLabel setText:@"0/300"];
    }
    return _remainingStringLabel;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    !self.textContentBlock ? : self.textContentBlock(textView.text);
}
- (void)textViewDidChangeSelection:(UITextView *)textView {
    self.remainingStringLabel.text = [NSString stringWithFormat:@"%ld/300",textView.text.length];
}

@end
