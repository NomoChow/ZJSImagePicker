//
//  ZJSImageCollectionViewCell.h
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/16.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/ALAsset.h>

@interface ZJSImageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *selectionButton;
@property (weak, nonatomic) IBOutlet UIView *maskView;

@property (nonatomic,strong) ALAsset *asset;

@end
