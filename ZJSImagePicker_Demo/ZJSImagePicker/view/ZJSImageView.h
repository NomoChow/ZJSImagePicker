//
//  ZJSImageView.h
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/19.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
@class ZJSImageView;

@protocol ZJSImageViewDelegate <NSObject>

@optional
- (void)imageViewSingleTap:(ZJSImageView *)photoView;

@end

@interface ZJSImageView : UIScrollView

@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,strong) ALAsset *asset;
@property (nonatomic,weak) id<ZJSImageViewDelegate> imageViewDelegate;

- (void)adjustFrame;
@end
