//
//  TestViewController.h
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/19.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (nonatomic,strong) UIImage *image;
@end
