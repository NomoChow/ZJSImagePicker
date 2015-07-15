//
//  Test2ViewController.m
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/19.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import "Test2ViewController.h"

@interface Test2ViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation Test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

    [self.view addSubview:self.scrollview];
    [self.scrollview addSubview:self.imageView];
    self.scrollview.delegate = self;
    [self adjustFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIScrollView *)scrollview{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.view.bounds;
        _scrollView.maximumZoomScale = 2;
        _scrollView.minimumZoomScale = 0.5;
    }
    return _scrollView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)adjustFrame
{
   // if (_imageView.image == nil) return;
    
    // 基本尺寸参数
    CGSize boundsSize = self.view.bounds.size;
    CGFloat boundsWidth = boundsSize.width;
    CGFloat boundsHeight = boundsSize.height;
    
    CGSize imageSize =  self.image.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    
    // 设置伸缩比例
   /* CGFloat minScale = boundsWidth / imageWidth;
    if (minScale > 1) {
        minScale = 1.0;
    }
    CGFloat maxScale = 2.0;
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        maxScale = maxScale / [[UIScreen mainScreen] scale];
    }
    self.scrollview.maximumZoomScale = maxScale;
    self.scrollview.minimumZoomScale = minScale;
    self.scrollview.zoomScale = minScale;*/
    
    CGRect imageFrame = CGRectMake(0, 0, boundsWidth, imageHeight * boundsWidth / imageWidth);
    // 内容尺寸
    self.scrollview.contentSize = CGSizeMake(0, imageFrame.size.height);
    
    // y值
    if (imageFrame.size.height < boundsHeight) {
        imageFrame.origin.y = floorf((boundsHeight - imageFrame.size.height) / 2.0);
    } else {
        imageFrame.origin.y = 0;
    }
    
    self.imageView.image = self.image;
    self.imageView.frame = imageFrame;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidZoom");
    NSLog(@" _imageView.center:%@",NSStringFromCGPoint(_imageView.center));
    NSLog(@" NSStringFromCGPoint:%@",NSStringFromCGPoint( CGPointMake(self.scrollview.contentSize.width/2, self.scrollview.contentSize.height/2)));
    // _imageView.center = self.center;
    
    CGFloat y;
    if (self.scrollview.contentSize.height>self.scrollview.bounds.size.height) {
        y = self.scrollview.contentSize.height/2;
    }else{
        y = self.scrollview.bounds.size.height/2;
    }
    
    CGFloat x;
    if (self.scrollview.contentSize.width>self.scrollview.bounds.size.width) {
        x = self.scrollview.contentSize.width/2;
    }else{
        x = self.scrollview.bounds.size.width/2;
    }
    
    _imageView.center =  CGPointMake(x, y);
}



-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

@end
