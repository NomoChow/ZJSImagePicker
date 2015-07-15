//
//  ZJSImagePickerViewController.h
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/16.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsFilter.h>

@interface ZJSImagePickerViewController : UIViewController

@property (nonatomic,strong) ALAssetsGroup *assetsGroup;

@end
