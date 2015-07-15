//
//  ZJSImageBrowserTopView.h
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/20.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJSImageBrowserTopView;

@protocol ZJSImageBrowserTopViewDelegate <NSObject>

-(void)topViewLeftTappped:(ZJSImageBrowserTopView*)sender;
-(void)topViewRightTappped:(ZJSImageBrowserTopView*)sender;

@end

@interface ZJSImageBrowserTopView : UIView
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic) BOOL selected;

@property (nonatomic,weak) id<ZJSImageBrowserTopViewDelegate> topViewDelegate;

+(instancetype)imageBrowserTopView;

@end
