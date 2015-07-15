//
//  ZJSImageView.m
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/19.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import "ZJSImageView.h"

@interface ZJSImageView()<UIScrollViewDelegate>

@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation ZJSImageView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];

    }
    return self;
}

//-(void)layoutSubviews{
//    [super layoutSubviews];
//}

-(void)awakeFromNib{
    [self setup];
}

-(void)setup{

    // 设置scrollView属性
    self.maximumZoomScale = 2;
    self.minimumZoomScale = 1;
    self.delegate = self;
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    [self addSubview:self.imageView];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark 调整frame
- (void)adjustFrame
{
    if (self.imageView.image == nil) return;
    
    // 基本尺寸参数
    CGSize boundsSize = self.bounds.size;
    CGFloat boundsWidth = boundsSize.width;
    CGFloat boundsHeight = boundsSize.height;
    
    CGSize imageSize =  self.imageView.image.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    
    // 设置伸缩比例
//    CGFloat minScale = boundsWidth / imageWidth;
//    if (minScale > 1) {
//        minScale = 1.0;
//    }
//    CGFloat maxScale = 2.0;
//    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
//        maxScale = maxScale / [[UIScreen mainScreen] scale];
//    }
//    self.maximumZoomScale = maxScale;
//    self.minimumZoomScale = minScale;
//    self.zoomScale = minScale;
    
    self.zoomScale = 1;
    
    CGRect imageFrame = CGRectMake(0, 0, boundsWidth, imageHeight * boundsWidth / imageWidth);
    // 内容尺寸
    self.contentSize = CGSizeMake(0, imageFrame.size.height);
    
    // y值
    if (imageFrame.size.height < boundsHeight) {
        imageFrame.origin.y = floorf((boundsHeight - imageFrame.size.height) / 2.0);
    } else {
        imageFrame.origin.y = 0;
    }

    self.imageView.frame = imageFrame;

}

#pragma mark - action

-(void)imageSingleTapped:(UIGestureRecognizer*)sender{
    
    // 通知代理
    if ([self.imageViewDelegate respondsToSelector:@selector(imageViewSingleTap:)]) {
        [self.imageViewDelegate imageViewSingleTap:self];
    }

}

-(void)imageDoubleTapped:(UIGestureRecognizer*)sender{
    CGPoint tapPoint = [sender locationInView:self];
    
    if (self.zoomScale ==self.minimumZoomScale) {
        [self zoomToRect:CGRectMake(tapPoint.x, tapPoint.y, 1, 1) animated:YES];
    }else{
        [self setZoomScale:self.minimumZoomScale animated:YES];
    }
}


#pragma mark - getter
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageSingleTapped:)];
        singleTap.delaysTouchesBegan = YES;
        singleTap.numberOfTapsRequired = 1;
        [_imageView addGestureRecognizer:singleTap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageDoubleTapped:)];
        doubleTap.numberOfTapsRequired = 2;
        [_imageView addGestureRecognizer:doubleTap];
        [singleTap requireGestureRecognizerToFail:doubleTap];
    }
    
    return _imageView;
}


#pragma mark - setter
-(void)setAsset:(ALAsset *)asset{
    _asset = asset;

    self.imageView.image =  [UIImage imageWithCGImage:self.asset.defaultRepresentation.fullScreenImage];
    [self adjustFrame];

}

#pragma mark - scrollview delegate

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
//    NSLog(@"scrollViewDidZoom");
//    NSLog(@" _imageView.center:%@",NSStringFromCGPoint(_imageView.center));
//    NSLog(@" NSStringFromCGPoint:%@",NSStringFromCGPoint( CGPointMake(self.contentSize.width/2, self.contentSize.height/2)));
    // _imageView.center = self.center;
    
    // 调整图片中心
    CGFloat y;
    if (self.contentSize.height>self.bounds.size.height) {
        y = self.contentSize.height/2;
    }else{
        y = self.bounds.size.height/2;
    }
    
    CGFloat x;
    if (self.contentSize.width>self.bounds.size.width) {
        x = self.contentSize.width/2;
    }else{
        x = self.bounds.size.width/2;
    }
    
    self.imageView.center =  CGPointMake(x, y);
    
    NSLog(@"self.maximumZoomScale:%f",self.maximumZoomScale);
    
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    NSLog(@"scale:%f",scale);

}

-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{

}



@end
