//
//  HLGPUImageViewController.m
//  AVPlayerDemo
//
//  Created by hlznj on 2017/6/22.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import "HLGPUImageViewController.h"
#import <GPUImage/GPUImage.h>

@interface HLGPUImageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIImage *_selectImage;      //当前选择的原图
}

//可以缩放的要处理的图片
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImagePickerController *imgPickerController;

//选择特效的视图
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation HLGPUImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *itemBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    [itemBtn setTitle:@"selectImg" forState:UIControlStateNormal];
    [itemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    @weakify(self)
    [itemBtn bk_whenTapped:^{
        @strongify(self)
        [self selectBtnAction];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:itemBtn];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    [self.view addSubview:self.tableView];
}

- (void)selectBtnAction
{
    [self presentViewController:self.imgPickerController animated:YES completion:nil];
}

#pragma mark - 懒加载
- (UIImagePickerController *)imgPickerController
{
    if (!_imgPickerController) {
        _imgPickerController = [[UIImagePickerController alloc] init];
        _imgPickerController.allowsEditing = YES;
        _imgPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _imgPickerController.delegate = self;
    }
    return _imgPickerController;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH-64 - 50)];
        _scrollView.delegate = self;
        _scrollView.minimumZoomScale = 0.3;
        _scrollView.maximumZoomScale = 1.0;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 50, KScreenW)];
        _tableView.center = CGPointMake(KScreenW/2, KScreenH-30);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@"素描",@"卡通",@"模糊",@"反色"];
    }
    return _dataSource;
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.scrollView.contentSize = image.size;
    self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.imageView.image = image;
    _selectImage = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"GPUCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.numberOfLines = 0;
        cell.contentView.layer.masksToBounds = YES;
        cell.contentView.layer.cornerRadius = 25;
        cell.contentView.backgroundColor = RGB_HEX(0x76ccc4);
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self changeImageWithType:indexPath.row];
}

#pragma mark - 给图片加buff
- (void)changeImageWithType:(NSInteger)type
{
    if (!_selectImage) {
        NSLog(@"please select image!");
        return;
    }
    switch (type) {
        case 0:                 //素描
        {
            GPUImageSketchFilter *disFilter = [[GPUImageSketchFilter alloc] init];
            [disFilter forceProcessingAtSize:_selectImage.size];
            [disFilter useNextFrameForImageCapture];
            [self addTarget:disFilter];
        }
            break;
            
        case 1:                 //卡通
        {
            GPUImageSmoothToonFilter *toonFilter = [[GPUImageSmoothToonFilter alloc] init];
            toonFilter.blurRadiusInPixels = 0.5;
            [toonFilter forceProcessingAtSize:_selectImage.size];
            [toonFilter useNextFrameForImageCapture];
            [self addTarget:toonFilter];
        }
            break;
       
        case 2:                 //模糊
        {
            GPUImageiOSBlurFilter *blurFilter = [[GPUImageiOSBlurFilter alloc] init];
            blurFilter.blurRadiusInPixels = 0.5;
            [blurFilter forceProcessingAtSize:_selectImage.size];
            [blurFilter useNextFrameForImageCapture];
            [self addTarget:blurFilter];
        }
            break;
            
        case 3:                 //反色
        {
            GPUImageSobelEdgeDetectionFilter *blurFilter = [[GPUImageSobelEdgeDetectionFilter alloc] init];
            [blurFilter forceProcessingAtSize:_selectImage.size];
            [blurFilter useNextFrameForImageCapture];
            [self addTarget:blurFilter];
        }
            break;
        default:
            break;
    }
}

- (void)addTarget:(id<GPUImageInput>)newTarget
{
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:_selectImage];
    [stillImageSource addTarget:newTarget];
    [stillImageSource processImage];
    self.imageView.image = [newTarget performSelector:@selector(imageFromCurrentFramebuffer)];
}

@end
